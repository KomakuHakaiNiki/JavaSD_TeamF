// FILE: JavaSD/src/servlet/login/LoginServlet.java
package login; // パッケージ名をフォルダ構成に合わせてください

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Teacher;
import dao.TeacherDAO;

// ★URLパターンを修正
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    /**
     * ログインページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ログインページ(login.jsp)にフォワード
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    /**
     * IDとパスワードで認証を行い、ログイン処理を実行します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // リクエストからIDとパスワードを取得
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        TeacherDAO dao = new TeacherDAO();
        Teacher teacher = null;

        try {
            // DAOのloginメソッドで認証
            teacher = dao.login(id, password);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "データベースへの接続中にエラーが発生しました。");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        // 認証の結果で処理を分岐
        if (teacher != null) {
            // ログイン成功
            HttpSession session = req.getSession();
            // セッションにログインユーザーの情報を保存
            session.setAttribute("user", teacher);

            // トップページ(top.jsp)にリダイレクト
            resp.sendRedirect(req.getContextPath() + "/top.jsp");

        } else {
            // ログイン失敗
            req.setAttribute("error", "IDまたはパスワードが正しくありません。");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
