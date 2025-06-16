// FILE: JavaSD/src/servlet/subject/SubjectUpdateServlet.java
package subject;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;

@WebServlet("/subject/update")
public class SubjectUpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        SubjectDAO dao = new SubjectDAO();
        try {
            // ★修正後のDAOのgetメソッドを使用
            Subject subject = dao.get(user.getSchool().getCd(), cd);
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/subject/subject_edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "科目情報の取得中にエラーが発生しました。");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        subject.setSchool(user.getSchool()); // ★ログインユーザーの学校情報をセット

        SubjectDAO dao = new SubjectDAO();
        try {
            // ★修正後のDAOのupdateメソッドを使用
            dao.update(subject);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目情報の更新に失敗しました。");
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/subject/subject_edit.jsp").forward(req, resp);
            return;
        }

        // ★完了後はSubjectListServletにリダイレクト
        resp.sendRedirect(req.getContextPath() + "/subject/list");
    }
}
