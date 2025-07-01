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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // ログインチェック
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // プルダウン用リスト取得
        String schoolCd = user.getSchool().getCd();
        StudentDAO dao = new StudentDAO();
        try {
            List<Integer> entYears   = dao.getEntYears(schoolCd);
            List<String>  classNums  = dao.getClassNums(schoolCd);
            req.setAttribute("entYearList",  entYears);
            req.setAttribute("classNumList", classNums);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "クラス情報の取得中にエラーが発生しました。");
        }

        // 入力フォーム表示
        req.getRequestDispatcher("/student/student_create.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // ログインチェック
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String schoolCd   = user.getSchool().getCd();
        String no         = req.getParameter("no");
        String name       = req.getParameter("name");
        String entYearStr = req.getParameter("entYear");
        String classNum   = req.getParameter("classNum");
        boolean attend    = req.getParameter("isAttend") != null;

        StudentDAO dao = new StudentDAO();

        // ■ 基本バリデーション
        if (no == null || no.trim().isEmpty() ||
            name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "学籍番号と氏名は必須入力です。");
            doGet(req, resp);
            return;
        }
        if (entYearStr == null || entYearStr.trim().isEmpty()) {
            req.setAttribute("error", "入学年度を入力してください。");
            doGet(req, resp);
            return;
        }

        int entYear;
        try {
            entYear = Integer.parseInt(entYearStr.trim());
        } catch (NumberFormatException e) {
            req.setAttribute("error", "入学年度は半角数字で入力してください。");
            doGet(req, resp);
            return;
        }

        // ■ 重複チェック：入学年度
        try {
            List<Integer> existingYears = dao.getEntYears(schoolCd);
            if (existingYears.contains(entYear)) {
                req.setAttribute("error", "この数値はすでに存在しています");
                doGet(req, resp);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "入学年度のチェック中にエラーが発生しました。");
            doGet(req, resp);
            return;
        }

        // ■ 重複チェック：クラス
        try {
            List<String> existingClasses = dao.getClassNums(schoolCd);
            if (existingClasses.contains(classNum)) {
                req.setAttribute("error", "この数値はすでに存在しています");
                doGet(req, resp);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "クラスのチェック中にエラーが発生しました。");
            doGet(req, resp);
            return;
        }

        // ■ 登録処理
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntyear(entYear);
        student.setClassNum(classNum);
        student.setAttend(attend);
        student.setSchool(user.getSchool());

        try {
            dao.insertStudent(student);
            // 成功時は完了画面にフォワード
            req.getRequestDispatcher("/student/student_create_done.jsp")
               .forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            String msg = (e.getMessage() != null && e.getMessage().toLowerCase().contains("primary key"))
                ? "エラー: 学籍番号「" + no + "」は既に使用されています。"
                : "データベースエラー: 学生の登録に失敗しました。";
            req.setAttribute("error", msg);

            // 再度プルダウン用リストをセット
            try {
                req.setAttribute("entYearList",  dao.getEntYears(schoolCd));
                req.setAttribute("classNumList", dao.getClassNums(schoolCd));
            } catch (Exception ignore) {}

            // 入力フォームに戻す
            req.getRequestDispatcher("/student/student_create.jsp")
               .forward(req, resp);
        }
    }
}
