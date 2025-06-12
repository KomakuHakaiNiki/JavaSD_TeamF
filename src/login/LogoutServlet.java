// FILE: JavaSD/src/servlet/login/LogoutServlet.java
package login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login/logout")
public class LogoutServlet extends HttpServlet {

    /**
     * ログアウト処理を実行します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        req.getRequestDispatcher("/logout.jsp").forward(req, resp);
    }
}