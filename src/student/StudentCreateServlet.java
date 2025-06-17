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
            req.setAttribute("error", "クラス情報の取得中にエラーが発生しました。");
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

        // ログインと学校情報のチェック
        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // フォームからのデータを取得
        String no = req.getParameter("no");
        String name = req.getParameter("name");
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        boolean isAttend = req.getParameter("isAttend") != null;

        // 入力値のバリデーション
        if (no == null || no.trim().isEmpty() || name == null || name.trim().isEmpty() || entYearStr == null || entYearStr.trim().isEmpty()) {
            req.setAttribute("error", "学籍番号、氏名、入学年度は必須入力です。");
            // エラー時もフォームの選択肢と入力値を保持して戻す
            populateFormAndForward(req, resp);
            return;
        }

        int entYear = 0;
        try {
            entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "入学年度は半角数字で入力してください。");
            populateFormAndForward(req, resp);
            return;
        }

        // Studentオブジェクトに値をセット
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntyear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend);
        student.setSchool(user.getSchool());

        StudentDAO dao = new StudentDAO();
        try {
            dao.insertStudent(student);
        } catch (Exception e) {
            e.printStackTrace();
            if (e.getMessage() != null && e.getMessage().toLowerCase().contains("primary key")) {
                 req.setAttribute("error", "エラー: 学籍番号「" + no + "」は既に使用されています。");
            } else {
                 req.setAttribute("error", "データベースエラー: 学生の登録に失敗しました。");
            }
            populateFormAndForward(req, resp);
            return;
        }

        // 完了後は学生一覧画面にリダイレクト
        resp.sendRedirect(req.getContextPath() + "/student/list");
    }

    /**
     * エラー発生時にフォームの表示に必要なデータを準備してフォワードする補助メソッド
     */
    private void populateFormAndForward(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StudentDAO dao = new StudentDAO();
        try {
            // クラス番号のリストを再取得
            List<String> classNums = dao.getClassNums();
            req.setAttribute("classNumList", classNums);
        } catch (Exception e) {
            e.printStackTrace();
            // このエラーは致命的ではないので、続行
        }
        // 入力された値をリクエストスコープにセットして画面に戻す
        req.setAttribute("no", req.getParameter("no"));
        req.setAttribute("name", req.getParameter("name"));
        req.setAttribute("entYear", req.getParameter("entYear"));
        req.setAttribute("classNum", req.getParameter("classNum"));
        req.setAttribute("isAttend", req.getParameter("isAttend") != null);

        req.getRequestDispatcher("/student/student_create.jsp").forward(req, resp);
    }
}
