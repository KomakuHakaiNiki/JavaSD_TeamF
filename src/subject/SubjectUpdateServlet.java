// FILE: JavaSD/src/servlet/subject/SubjectUpdateServlet.java
package subject;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Subject;
import dao.SubjectDAO;

@WebServlet("/subject/update")
public class SubjectUpdateServlet extends HttpServlet {

    /**
     * 科目更新ページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String cd = req.getParameter("cd");
        SubjectDAO dao = new SubjectDAO();
        try {
            Subject subject = dao.getSubjectByCd(cd);
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/subject/subject_edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "科目情報の取得中にエラーが発生しました。");
        }
    }

    /**
     * 科目情報の更新処理を実行します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);

        SubjectDAO dao = new SubjectDAO();
        try {
            dao.updateSubject(subject);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目情報の更新に失敗しました。");
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/subject/subject_edit.jsp").forward(req, resp);
            return;
        }

        // 完了後は科目一覧画面にリダイレクト（※SubjectListServletが別途必要）
        resp.sendRedirect(req.getContextPath() + "/subject_list.jsp"); // 仮の遷移先
    }
}