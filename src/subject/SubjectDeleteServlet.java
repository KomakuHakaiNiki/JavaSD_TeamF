// FILE: JavaSD/src/servlet/subject/SubjectDeleteServlet.java
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

@WebServlet("/subject/delete")
public class SubjectDeleteServlet extends HttpServlet {

    /**
     * 科目削除の確認ページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        SubjectDAO dao = new SubjectDAO();
        try {
            // 削除対象の科目情報を取得
            Subject subject = dao.get(user.getSchool().getCd(), cd);
            req.setAttribute("subject", subject);
            // 確認ページにフォワード
            req.getRequestDispatcher("/subject/subject_delete.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目情報の取得中にエラーが発生しました。");
            req.getRequestDispatcher("list").forward(req, resp);
        }
    }

    /**
     * 科目をデータベースから削除し、完了ページに遷移します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        SubjectDAO dao = new SubjectDAO();
        try {
            dao.delete(user.getSchool().getCd(), cd);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目の削除に失敗しました。関連する成績データが存在する可能性があります。");
            req.getRequestDispatcher("list").forward(req, resp);
            return;
        }

        // 成功した場合、削除完了ページにフォワード
        req.getRequestDispatcher("/subject/subject_delete_done.jsp").forward(req, resp);
    }
}
