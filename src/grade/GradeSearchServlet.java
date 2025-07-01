// FILE: JavaSD/src/servlet/grade/GradeSearchServlet.java
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
     * 初期表示用。プルダウンに必要な「年度／クラス／科目リスト」をセットして
     * grade_list.jsp を表示します。
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

        StudentDAO sDao = new StudentDAO();
        SubjectDAO subDao = new SubjectDAO();
        try {
            String schoolCd = user.getSchool().getCd();
            List<Integer> entYears  = sDao.getEntYears(schoolCd);
            List<String>  classNums = sDao.getClassNums(schoolCd);
            List<Subject> subjects  = subDao.filterBySchool(schoolCd);

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
     * form の submit (POST) を受けて、search_type に応じて処理を振り分けます。
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
            // 想定外は初期表示へ
            doGet(req, resp);
        }
    }

    /**
     * 科目情報による絞り込み検索処理。
     * まず f1／f2／f3 のいずれかが空ならエラーメッセージをセットして doGet へ戻る。
     */
    private void searchBySubject(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ① まずパラメータを取得
        String f1 = req.getParameter("f1");  // 入学年度
        String f2 = req.getParameter("f2");  // クラス
        String f3 = req.getParameter("f3");  // 科目コード

        // ② いずれかが空ならエラー
        if (f1 == null || f1.trim().isEmpty()
         || f2 == null || f2.trim().isEmpty()
         || f3 == null || f3.trim().isEmpty()) {
            req.setAttribute("error", "入学年度とクラスと科目を入力してください。");
            // 初期表示用情報を再セットして doGet へ戻す
            doGet(req, resp);
            return;
        }

        // ③ 空でないことが保証されたので、parse や DAO 呼び出しへ
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
            TestListStudentDAO dao = new TestListStudentDAO();
            List<TestListSubject> results =
                dao.filterBySubject(entYear, classNum, subjectCd, schoolCd);

            req.setAttribute("results_subject", results);

            // 科目コード→科目名の変換
            SubjectDAO sd = new SubjectDAO();
            String name = subjectCd;
            for (Subject s : sd.filterBySchool(schoolCd)) {
                if (subjectCd.equals(s.getCd())) {
                    name = s.getName(); break;
                }
            }
            req.setAttribute("searched_subject_name", name);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の検索中にエラーが発生しました。");
        }

        // 結果表示も新たにプルダウン情報を用意して表示
        doGet(req, resp);
    }

    /**
     * 学生番号による絞り込み検索処理。
     * f4 が空ならエラー、DAO実行後に結果をセットして再表示します。
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
            StudentDAO sDao = new StudentDAO();
            TestListStudentDAO tDao = new TestListStudentDAO();

            // 学生オブジェクト取得
            Student student = sDao.getStudentById(f4.trim());
            // 成績リスト取得
            List<TestListStudent> results = tDao.filterByStudent(f4.trim());

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
