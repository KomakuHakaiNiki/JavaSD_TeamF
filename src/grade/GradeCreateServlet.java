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
import bean.Test;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestListStudentDAO; // TestDAOの代わり

@WebServlet("/grade/create")
public class GradeCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        StudentDAO studentDao = new StudentDAO();
        SubjectDAO subjectDao = new SubjectDAO();

        try {
            String schoolCd = user.getSchool().getCd();
            List<Student> students = studentDao.filter(0, "", schoolCd);
            List<Subject> subjects = subjectDao.filterBySchool(schoolCd);

            req.setAttribute("students", students);
            req.setAttribute("subjects", subjects);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "表示に必要な情報の取得に失敗しました。");
        }
        req.getRequestDispatcher("/grade/grade_create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String studentNo = req.getParameter("studentNo");
        String subjectCd = req.getParameter("subjectCd");
        int no = Integer.parseInt(req.getParameter("no"));
        int point = Integer.parseInt(req.getParameter("point"));

        Student student = new Student();
        student.setNo(studentNo);
        Subject subject = new Subject();
        subject.setCd(subjectCd);
        Test test = new Test();
        test.setStudent(student);
        test.setSubject(subject);
        test.setNo(no);
        test.setPoint(point);
        test.setSchool(user.getSchool());

        try {
            StudentDAO sDao = new StudentDAO();
            test.setClassNum(sDao.getStudentById(studentNo).getClassNum());
        } catch (Exception e) { e.printStackTrace(); }

        TestListStudentDAO testDao = new TestListStudentDAO(); // TestListStudentDAOを使用
        try {
            testDao.save(test);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の登録に失敗しました。");
            doGet(req, resp);
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/grade/search");
    }
}