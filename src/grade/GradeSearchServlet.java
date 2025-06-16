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
import bean.Teacher;
import bean.TestListStudent;
import dao.StudentDAO;
import dao.TestListStudentDAO;

@WebServlet("/grade/search")
public class GradeSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ★ NullPointerException対策: 学校情報がセッションに存在するか確認
        if (user.getSchool() == null || user.getSchool().getCd() == null) {
            req.setAttribute("error", "セッションにユーザーの学校情報が見つかりません。再ログインしてください。");
            req.getRequestDispatcher("/grade/grade_search.jsp").forward(req, resp);
            return;
        }

        StudentDAO sDao = new StudentDAO();
        String schoolCd = user.getSchool().getCd();

        try {
            List<Student> students = sDao.filter(0, "", schoolCd);
            req.setAttribute("students", students);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の取得中にデータベースエラーが発生しました。");
        }
        req.getRequestDispatcher("/grade/grade_search.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String studentNo = req.getParameter("studentNo");
        if (studentNo == null || studentNo.isEmpty()) {
            doGet(req, resp);
            return;
        }

        TestListStudentDAO tDao = new TestListStudentDAO();
        StudentDAO sDao = new StudentDAO();

        try {
            Student student = sDao.getStudentById(studentNo);
            List<TestListStudent> tests = tDao.getTestListByStudentNo(studentNo);
            req.setAttribute("student", student);
            req.setAttribute("tests", tests);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績情報の取得に失敗しました。");
        }

        // ★ doPostの最後はdoGetを呼び出して画面を再描画する
        doGet(req, resp);
    }
}