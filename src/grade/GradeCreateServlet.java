// FILE: JavaSD/src/servlet/grade/GradeCreateServlet.java
package grade;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Student;
import bean.Subject;
import bean.Test;
import dao.StudentDAO;
import dao.SubjectDAO;
// import dao.TestDAO; // ★注意: このDAOは提供されていないため、別途作成が必要です

@WebServlet("/grade/create")
public class GradeCreateServlet extends HttpServlet {

    /**
     * 成績登録ページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StudentDAO studentDao = new StudentDAO();
        SubjectDAO subjectDao = new SubjectDAO();

        try {
            List<Student> students = studentDao.getAllStudents();
            List<Subject> subjects = subjectDao.getAllSubjects();
            req.setAttribute("students", students);
            req.setAttribute("subjects", subjects);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生または科目情報の取得に失敗しました。");
        }

        req.getRequestDispatcher("/grade/grade_create.jsp").forward(req, resp);
    }

    /**
     * 成績情報の登録処理を実行します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String studentNo = req.getParameter("studentNo");
        String subjectCd = req.getParameter("subjectCd");
        int no = Integer.parseInt(req.getParameter("no"));
        int point = Integer.parseInt(req.getParameter("point"));

        Test test = new Test();
        Student student = new Student();
        student.setNo(studentNo);
        Subject subject = new Subject();
        subject.setCd(subjectCd);

        test.setStudent(student);
        test.setSubject(subject);
        test.setNo(no);
        test.setPoint(point);

        /*
         * ★注意: 成績を登録するためのTestDAOが存在しないため、以下は想定されるコードです。
         */
        // TestDAO testDao = new TestDAO();
        try {
            // testDao.save(test);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の登録に失敗しました。");
            doGet(req, resp); // エラーメッセージと共にフォームを再表示
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/grade/search?studentNo=" + studentNo);
    }
}