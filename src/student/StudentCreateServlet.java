// FILE: JavaSD/src/servlet/student/StudentCreateServlet.java
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

@WebServlet("/student/create")
public class StudentCreateServlet extends HttpServlet {

    /**
     * 学生登録ページを表示します。
     * プルダウン用にクラス番号のリストも取得します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ログインチェック
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        StudentDAO dao = new StudentDAO();
        try {
            // クラス番号のリストを取得してJSPに渡す
            List<String> classNums = dao.getClassNums();
            req.setAttribute("classNumList", classNums);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "クラス情報が取得できませんでした。");
        }

        req.getRequestDispatcher("/student/student_create.jsp").forward(req, resp);
    }

    /**
     * 学生情報の登録処理を実行します。
     */
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

        // フォームからのデータを取得
        String no = req.getParameter("no");
        String name = req.getParameter("name");
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        boolean isAttend = req.getParameter("isAttend") != null;

        int entYear = 0;
        try {
            entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            // 数値変換エラー時の処理
        }

        // Studentオブジェクトに値をセット
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntyear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend);
        // ★重要: ログインユーザーの学校情報をセット
        student.setSchool(user.getSchool());

        StudentDAO dao = new StudentDAO();
        try {
            dao.insertStudent(student);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生の登録に失敗しました。");
            // 失敗時もフォームの選択肢を再取得
            doGet(req, resp);
            return;
        }

        // 完了後は学生一覧画面にリダイレクト
        resp.sendRedirect(req.getContextPath() + "/student/list");
    }
}
