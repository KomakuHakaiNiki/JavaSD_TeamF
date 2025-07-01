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
     * 初期表示：プルダウン用データをセットして grade_list.jsp を表示
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        // 開発中はログイン不要にするバイパス
        if (user == null || user.getSchool() == null) {
            Teacher dummy = new Teacher();
            School school = new School();
            school.setCd("tes");  // テスト用H2の学校コード
            dummy.setSchool(school);
            session.setAttribute("user", dummy);
            user = dummy;
        }

        try {
            String schoolCd = user.getSchool().getCd();
            List<Integer> entYears  = new StudentDAO().getEntYears(schoolCd);
            List<String>  classNums = new StudentDAO().getClassNums(schoolCd);
            List<Subject> subjects  = new SubjectDAO().filterBySchool(schoolCd);

            req.setAttribute("ent_years",  entYears);
            req.setAttribute("class_nums", classNums);
            req.setAttribute("subjects",   subjects);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "表示に必要な情報の取得に失敗しました。");
        }
        req.getRequestDispatcher("/grade/grade_list.jsp").forward(req, resp);
    }

    /**
     * POST の振り分け
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String type = req.getParameter("search_type");
        if ("subject".equals(type)) {
            searchBySubject(req, resp);
        } else if ("student".equals(type)) {
            searchByStudent(req, resp);
        } else {
            doGet(req, resp);
        }
    }

    /**
     * ■ 科目情報での検索
     * f1/f2/f3 のいずれかが空 → エラー
     * DAO実行後、ヒットなしなら info をセット
     */
    private void searchBySubject(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String f1 = req.getParameter("f1");  // 入学年度
        String f2 = req.getParameter("f2");  // クラス
        String f3 = req.getParameter("f3");  // 科目コード

        // 未選択チェック
        if (f1 == null || f1.trim().isEmpty()
         || f2 == null || f2.trim().isEmpty()
         || f3 == null || f3.trim().isEmpty()) {
            req.setAttribute("error", "入学年度とクラスと科目を入力してください。");
            doGet(req, resp);
            return;
        }

        // parse & DAO
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        String schoolCd = user.getSchool().getCd();

        int entYear;
        try {
            entYear = Integer.parseInt(f1.trim());
        } catch (NumberFormatException e) {
            req.setAttribute("error", "入学年度の形式が不正です。");
            doGet(req, resp);
            return;
        }
        String classNum  = f2.trim();
        String subjectCd = f3.trim();

        try {
            List<TestListSubject> results = new TestListStudentDAO()
                .filterBySubject(entYear, classNum, subjectCd, schoolCd);
            req.setAttribute("results_subject", results);

            // ヒットなし時のメッセージ
            if (results.isEmpty()) {
                req.setAttribute("info", "成績情報が存在しませんでした。");
            }

            // 科目名の取得
            String name = subjectCd;
            for (Subject s : new SubjectDAO().filterBySchool(schoolCd)) {
                if (subjectCd.equals(s.getCd())) {
                    name = s.getName();
                    break;
                }
            }
            req.setAttribute("searched_subject_name", name);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の検索中にエラーが発生しました。");
        }

        // プルダウンを再セットして結果表示
        doGet(req, resp);
    }

    /**
     * ■ 学生番号での検索
     * f4 が空 → エラー
     * DAO実行後、ヒットなしなら info をセット
     */
    private void searchByStudent(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String f4 = req.getParameter("f4"); // 学生番号

        if (f4 == null || f4.trim().isEmpty()) {
            req.setAttribute("error", "学生番号を入力してください。");
            doGet(req, resp);
            return;
        }

        try {
            Student student = new StudentDAO().getStudentById(f4.trim());
            List<TestListStudent> results = new TestListStudentDAO()
                .filterByStudent(f4.trim());

            req.setAttribute("student", student);
            req.setAttribute("results_student", results);

            if (results.isEmpty()) {
                req.setAttribute("info", "成績情報が存在しませんでした。");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の検索中にエラーが発生しました。");
        }

        doGet(req, resp);
    }
}
