// FILE: JavaSD/src/servlet/student/StudentUpdateServlet.java
package student;

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
import dao.StudentDAO;

@WebServlet("/student/update")
public class StudentUpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String no = req.getParameter("no");
        StudentDAO dao = new StudentDAO();
        try {
            Student student = dao.getStudentById(no);
            List<String> classNums = dao.getClassNums();
            req.setAttribute("student", student);
            req.setAttribute("classNumList", classNums);
            req.getRequestDispatcher("/student/student_edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の取得中にエラーが発生しました。");
            req.getRequestDispatcher("list").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String no = req.getParameter("no");
        String name = req.getParameter("name");
        int entYear = Integer.parseInt(req.getParameter("entYear"));
        String classNum = req.getParameter("classNum");
        boolean isAttend = req.getParameter("isAttend") != null;

        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntyear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend);
        student.setSchool(user.getSchool());

        StudentDAO dao = new StudentDAO();
        try {
            dao.updateStudent(student);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の更新に失敗しました。");
            req.setAttribute("student", student);
            try {
                 List<String> classNums = dao.getClassNums();
                 req.setAttribute("classNumList", classNums);
            } catch (Exception e2) {
                 e2.printStackTrace();
            }
            req.getRequestDispatcher("/student/student_edit.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/student/student_edit_done.jsp").forward(req, resp);
    }
}
