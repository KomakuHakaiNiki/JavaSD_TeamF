// FILE: JavaSD/src/servlet/student/StudentUpdateServlet.java
package student;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher; // Teacherクラスをインポート
import dao.StudentDAO;

@WebServlet("/student/update")
public class StudentUpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ログインチェック
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String no = req.getParameter("no");
        StudentDAO dao = new StudentDAO();
        try {
            Student student = dao.getStudentById(no);
            req.setAttribute("student", student);
            req.getRequestDispatcher("/student/student_edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "学生情報の取得中にエラーが発生しました。");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        // ログインチェック
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
        // ★★★重要: ログインユーザーの学校情報をセットする
        student.setSchool(user.getSchool());

        StudentDAO dao = new StudentDAO();
        try {
            dao.updateStudent(student);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の更新に失敗しました。");
            req.setAttribute("student", student);
            req.getRequestDispatcher("/student/student_edit.jsp").forward(req, resp);
            return;
        }

        // ★完了後はStudentListServletにリダイレクト
        resp.sendRedirect(req.getContextPath() + "/student/list");
    }
}
