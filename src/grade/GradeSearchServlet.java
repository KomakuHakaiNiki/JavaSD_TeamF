// FILE: JavaSD/src/servlet/grade/GradeSearchServlet.java
package grade;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Student;
import bean.TestListStudent;
import dao.StudentDAO;
import dao.TestListStudentDAO;

@WebServlet("/grade/search")
public class GradeSearchServlet extends HttpServlet {

    /**
     * 成績検索の初期ページ（学生選択）を表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StudentDAO sDao = new StudentDAO();
        try {
            List<Student> students = sDao.getAllStudents();
            req.setAttribute("students", students);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の取得に失敗しました。");
        }
        req.getRequestDispatcher("/grade/grade_search.jsp").forward(req, resp);
    }

    /**
     * 指定された学生の成績を検索し、結果を表示します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String studentNo = req.getParameter("studentNo");

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

        req.getRequestDispatcher("/grade/grade_view_student.jsp").forward(req, resp);
    }
}