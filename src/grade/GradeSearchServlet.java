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

    /**
     * 初期表示時: 検索フォームの選択肢を準備して画面を表示します。
     * 検索実行後: 検索条件と結果を保持して画面を再表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        StudentDAO sDao = new StudentDAO();
        SubjectDAO subDao = new SubjectDAO();

        try {
            // プルダウン用のリストを取得
            List<Integer> entYears = sDao.getEntYears();
            List<String> classNums = sDao.getClassNums();
            List<Subject> subjects = subDao.filterBySchool(user.getSchool().getCd());

            // JSPで使えるようにリクエストスコープにセット
            req.setAttribute("ent_years", entYears);
            req.setAttribute("class_nums", classNums);
            req.setAttribute("subjects", subjects);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "表示に必要な情報の取得に失敗しました。");
        }

        // grade_list.jspにフォワード
        req.getRequestDispatcher("/grade/grade_list.jsp").forward(req, resp);
    }

    /**
     * フォームからのリクエストを"subject"(科目検索)と"student"(学生検索)で振り分けます。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String searchType = req.getParameter("search_type");

        if ("subject".equals(searchType)) {
            searchBySubject(req, resp);
        } else if ("student".equals(searchType)) {
            searchByStudent(req, resp);
        }
    }

    /**
     * 科目情報による検索処理
     */
    private void searchBySubject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        int entYear = Integer.parseInt(req.getParameter("f1"));
        String classNum = req.getParameter("f2");
        String subjectCd = req.getParameter("f3");

        TestListStudentDAO dao = new TestListStudentDAO();
        try {
            // DAOには科目コード(String)を渡す
            List<TestListSubject> results = dao.filterBySubject(entYear, classNum, subjectCd, user.getSchool().getCd());
            req.setAttribute("results_subject", results);
            req.setAttribute("searched_subject", subjectCd); // 検索条件を保持
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の検索中にエラーが発生しました。");
        }
        // 検索条件と結果を保持したまま、再度画面表示処理(doGet)を呼び出す
        doGet(req, resp);
    }

    /**
     * 学生番号による検索処理
     */
    private void searchByStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String studentNo = req.getParameter("f4");

        StudentDAO sDao = new StudentDAO();
        TestListStudentDAO tDao = new TestListStudentDAO();
        try {
            Student student = sDao.getStudentById(studentNo);
            List<TestListStudent> results = tDao.filterByStudent(studentNo);

            req.setAttribute("student", student);
            req.setAttribute("results_student", results);
        } catch (Exception e) {
            e.printStackTrace();
             req.setAttribute("error", "成績の検索中にエラーが発生しました。");
        }
        // 検索条件と結果を保持したまま、再度画面表示処理(doGet)を呼び出す
        doGet(req, resp);
    }
}
