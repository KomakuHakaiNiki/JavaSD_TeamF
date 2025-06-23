// FILE: JavaSD/src/servlet/student/StudentCreateServlet.java
package student;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher;
import dao.StudentDAO;

@WebServlet("/student/create")
public class StudentCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String schoolCd = user.getSchool().getCd();
        StudentDAO dao = new StudentDAO();
        try {
            // プルダウン用リスト取得 (学校コード指定)
            req.setAttribute("entYearList",  dao.getEntYears(schoolCd));
            req.setAttribute("classNumList", dao.getClassNums(schoolCd));
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "クラス情報の取得中にエラーが発生しました。");
        }

        req.getRequestDispatcher("/student/student_create.jsp")
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

        String schoolCd = user.getSchool().getCd();
        String no        = req.getParameter("no");
        String name      = req.getParameter("name");
        String entYearStr= req.getParameter("entYear");
        String classNum  = req.getParameter("classNum");
        boolean attend   = req.getParameter("isAttend") != null;

        // バリデーション
        if (no == null || no.trim().isEmpty() || name == null || name.trim().isEmpty() || entYearStr == null || entYearStr.trim().isEmpty()) {
            req.setAttribute("error", "学籍番号、氏名、入学年度は必須入力です。");
            // リスト再取得して再フォワード
            doGet(req, resp);
            return;
        }

        int entYear;
        try {
            entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "入学年度は半角数字で入力してください。");
            doGet(req, resp);
            return;
        }

        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntyear(entYear);
        student.setClassNum(classNum);
        student.setAttend(attend);
        student.setSchool(user.getSchool());

        StudentDAO dao = new StudentDAO();
        try {
            dao.insertStudent(student);
            resp.sendRedirect(req.getContextPath() + "/student/list");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            String msg = e.getMessage() != null && e.getMessage().toLowerCase().contains("primary key")
                ? "エラー: 学籍番号「" + no + "」は既に使用されています。"
                : "データベースエラー: 学生の登録に失敗しました。";
            req.setAttribute("error", msg);
            // 再度プルダウンリストをセットしてフォーム表示
            try {
                req.setAttribute("entYearList",  dao.getEntYears(schoolCd));
                req.setAttribute("classNumList", dao.getClassNums(schoolCd));
            } catch (Exception ignore) {}
            req.getRequestDispatcher("/student/student_create.jsp").forward(req, resp);
        }
    }
}
