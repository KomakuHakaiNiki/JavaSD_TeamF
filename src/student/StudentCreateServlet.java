// FILE: JavaSD/src/servlet/student/StudentCreateServlet.java
package student;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Student;
import dao.StudentDAO;

@WebServlet("/student/create")
public class StudentCreateServlet extends HttpServlet {

    /**
     * 学生登録ページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/student/student_create.jsp").forward(req, resp);
    }

    /**
     * 学生情報の登録処理を実行します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

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

        StudentDAO dao = new StudentDAO();
        try {
            dao.insertStudent(student);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生の登録に失敗しました。");
            req.getRequestDispatcher("/student/student_create.jsp").forward(req, resp);
            return;
        }

        // 完了後は学生一覧画面にリダイレクト（※StudentListServletが別途必要）
        resp.sendRedirect(req.getContextPath() + "/student_list.jsp"); // 仮の遷移先
    }
}