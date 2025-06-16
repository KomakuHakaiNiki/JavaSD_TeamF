// FILE: JavaSD/src/servlet/login/LoginServlet.java
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    /**
     * ログイン認証処理を実行します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        TeacherDAO dao = new TeacherDAO();
        Teacher teacher = null;

        try {
            teacher = dao.login(id, password);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "データベース接続中にエラーが発生しました。");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        if (teacher != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", teacher);
            resp.sendRedirect(req.getContextPath() + "/top.jsp");
        } else {
            req.setAttribute("error", "IDまたはパスワードが正しくありません。");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}