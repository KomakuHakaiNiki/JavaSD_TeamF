package grade;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.TestListStudent;
import bean.TestListSubject;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestListStudentDAO;

@WebServlet("/grade/search")
public class GradeSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * 初期表示：プルダウン用データをセットして JSP 表示
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // プルダウンだけセット（検索結果属性はクリアしない）
        populateDropdown(req);
        req.getRequestDispatcher("/grade/grade_list.jsp")
           .forward(req, resp);
    }

    /**
     * POST の振り分け（検索）
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // まずプルダウンを再セット
        populateDropdown(req);

        String type = req.getParameter("search_type");
        if ("subject".equals(type)) {
            searchBySubject(req, resp);
        }
        else if ("student".equals(type)) {
            searchByStudent(req, resp);
        }
        else {
            // 想定外は初期表示に戻す
            doGet(req, resp);
        }
    }

    /**
     * ■ 科目情報での検索
     */
    private void searchBySubject(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String f1 = req.getParameter("f1");  // 入学年度
        String f2 = req.getParameter("f2");  // クラス
        String f3 = req.getParameter("f3");  // 科目コード

        // 未選択チェック
        if (isEmpty(f1) || isEmpty(f2) || isEmpty(f3)) {
            req.setAttribute("errorSubject", "入学年度とクラスと科目を入力してください。");
            // JSPへフォワード（この時点で resultsSubject は null）
            req.getRequestDispatcher("/grade/grade_list.jsp").forward(req, resp);
            return;
        }

        int entYear;
        try {
            entYear = Integer.parseInt(f1.trim());
        } catch (NumberFormatException e) {
            req.setAttribute("errorSubject", "入学年度の形式が不正です。");
            req.getRequestDispatcher("/grade/grade_list.jsp").forward(req, resp);
            return;
        }

        String classNum  = f2.trim();
        String subjectCd = f3.trim();
        String schoolCd  = getSchoolCd(req);

        try {
            List<TestListSubject> results = new TestListStudentDAO()
                .filterBySubject(entYear, classNum, subjectCd, schoolCd);

            req.setAttribute("resultsSubject", results);
            if (results.isEmpty()) {
                req.setAttribute("infoSubject", "成績情報が存在しませんでした。");
            }

            // 科目名取得
            String subjectName = subjectCd;
            for (Subject s : new SubjectDAO().filterBySchool(schoolCd)) {
                if (subjectCd.equals(s.getCd())) {
                    subjectName = s.getName();
                    break;
                }
            }
            req.setAttribute("searchedSubjectName", subjectName);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorSubject", "成績の検索中にエラーが発生しました。");
        }

        // JSP表示
        req.getRequestDispatcher("/grade/grade_list.jsp").forward(req, resp);
    }

    /**
     * ■ 学生番号での検索
     */
    private void searchByStudent(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String f4 = req.getParameter("f4");  // 学生番号

        if (isEmpty(f4)) {
            req.setAttribute("errorStudent", "学生番号を入力してください。");
            req.getRequestDispatcher("/grade/grade_list.jsp").forward(req, resp);
            return;
        }

        try {
            // 学生情報＆成績リストを取得
            Student student = new StudentDAO().getStudentById(f4.trim());
            List<TestListStudent> results = new TestListStudentDAO()
                .filterByStudent(f4.trim());

            req.setAttribute("student", student);
            req.setAttribute("resultsStudent", results);
            if (results.isEmpty()) {
                req.setAttribute("infoStudent", "成績情報が存在しませんでした。");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorStudent", "成績の検索中にエラーが発生しました。");
        }

        // JSP表示
        req.getRequestDispatcher("/grade/grade_list.jsp").forward(req, resp);
    }

    /**
     * ドロップダウン用の共通データをセット
     */
    private void populateDropdown(HttpServletRequest req) {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        // (開発中バイパス)
        if (user == null || user.getSchool() == null) {
            Teacher dummy = new Teacher();
            School school = new School();
            school.setCd("tes");
            dummy.setSchool(school);
            session.setAttribute("user", dummy);
            user = dummy;
        }
        try {
            String schoolCd = user.getSchool().getCd();
            req.setAttribute("ent_years",  new StudentDAO().getEntYears(schoolCd));
            req.setAttribute("class_nums", new StudentDAO().getClassNums(schoolCd));
            req.setAttribute("subjects",   new SubjectDAO().filterBySchool(schoolCd));
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorCommon", "表示に必要な情報の取得に失敗しました。");
        }
    }

    /** セッションから学校コードを取得 */
    private String getSchoolCd(HttpServletRequest req) {
        Teacher user = (Teacher) req.getSession().getAttribute("user");
        return user.getSchool().getCd();
    }

    /** null or 空文字の判定 */
    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}
