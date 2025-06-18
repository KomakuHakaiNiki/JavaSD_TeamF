// FILE: JavaSD/src/servlet/login/LogoutServlet.java
package login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * ログアウト処理、およびアプリケーションの初期化を行うサーブレット。
 * 既存のセッションを破棄し、ログインページに遷移させます。
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 既存のセッションを取得（なければnull）
        HttpSession session = req.getSession(false);

        // セッションが存在すれば、それを無効化する
        if (session != null) {
            session.invalidate();
        }

        // ログインページにフォワードする
        req.getRequestDispatcher("/logout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
