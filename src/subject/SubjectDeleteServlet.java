// FILE: JavaSD/src/servlet/subject/SubjectDeleteServlet.java
package subject;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Subject;
import dao.SubjectDAO;

@WebServlet("/subject/delete")
public class SubjectDeleteServlet extends HttpServlet {

    /**
     * 科目削除確認ページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cd = req.getParameter("cd");
        SubjectDAO dao = new SubjectDAO();
        try {
            Subject subject = dao.getSubjectByCd(cd);
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/subject/subject_delete.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "科目情報の取得中にエラーが発生しました。");
        }
    }

    /**
     * 科目情報の削除処理を実行します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cd = req.getParameter("cd");

        SubjectDAO dao = new SubjectDAO();
        try {
            dao.deleteSubject(cd);
        } catch (Exception e) {
            e.printStackTrace();
            // 削除失敗時のエラーハンドリング
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "科目の削除に失敗しました。");
            return;
        }

        // 完了後は科目一覧画面にリダイレクト（※SubjectListServletが別途必要）
        resp.sendRedirect(req.getContextPath() + "/subject_list.jsp"); // 仮の遷移先
    }
}