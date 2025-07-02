package login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Teacher;
import dao.TeacherDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    /**
     * ログインページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // ログインページ(login.jsp)にフォワード
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    /**
     * IDとパスワードで認証を行い、ログイン処理を実行します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // ① ブラウザ側 required が効くよう、空文字の場合は何もセットせず戻す
        String id       = req.getParameter("id");
        String password = req.getParameter("password");
        if (id == null || id.trim().isEmpty()
         || password == null || password.trim().isEmpty()) {
            // error 属性をセットしない → JSP 上では <c:if test="${not empty error}"> が false になり、
            // input の required がブラウザで働きます
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // ② ID/PW が揃っていたら本認証
        TeacherDAO dao = new TeacherDAO();
        Teacher teacher;
        try {
            teacher = dao.login(id.trim(), password);
        } catch (Exception e) {
            e.printStackTrace();
            // DBエラー時は専用メッセージだけセット
            req.setAttribute("error", "データベースへの接続中にエラーが発生しました。");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // ③ 認証結果で分岐
        if (teacher != null) {
            // 認証成功 → セッションに登録してトップへリダイレクト
            HttpSession session = req.getSession();
            session.setAttribute("user", teacher);
            resp.sendRedirect(req.getContextPath() + "/top.jsp");
        } else {
            // 認証失敗 → error 属性をセットして JSP 表示
            req.setAttribute("error", "IDまたはパスワードが正しくありません。");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
