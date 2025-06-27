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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String no = req.getParameter("no");
        String schoolCd = user.getSchool().getCd();
        StudentDAO dao = new StudentDAO();
        try {
            // 学生情報取得
            Student student = dao.getStudentById(no);
            // プルダウン用リスト取得 (学校コード指定)
            List<Integer> entYearList  = dao.getEntYears(schoolCd);
            List<String>  classNumList = dao.getClassNums(schoolCd);

            req.setAttribute("student",       student);
            req.setAttribute("entYearList",   entYearList);
            req.setAttribute("classNumList",  classNumList);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の取得に失敗しました。");
        }

        // 編集画面へフォワード
        req.getRequestDispatcher("/student/student_edit.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String no       = req.getParameter("no");
        String name     = req.getParameter("name");
        int entYear     = Integer.parseInt(req.getParameter("entYear"));
        String classNum = req.getParameter("classNum");
        boolean attend  = req.getParameter("isAttend") != null;

        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntyear(entYear);
        student.setClassNum(classNum);
        student.setAttend(attend);
        student.setSchool(user.getSchool());

        StudentDAO dao = new StudentDAO();
        try {
            dao.updateStudent(student);
            resp.sendRedirect(req.getContextPath() + "/student/student_edit_done.jsp");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の更新に失敗しました。");
            // 再度プルダウン用リストを用意
            try {
                req.setAttribute("entYearList",  dao.getEntYears(user.getSchool().getCd()));
                req.setAttribute("classNumList", dao.getClassNums(user.getSchool().getCd()));
            } catch (Exception ignore) {}
            req.setAttribute("student", student);
            req.getRequestDispatcher("/student/student_edit.jsp").forward(req, resp);
        }
    }
}

