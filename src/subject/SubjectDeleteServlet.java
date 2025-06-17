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
     * 科目削除確認ページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("--- SubjectDeleteServlet doGet Start ---");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        SubjectDAO dao = new SubjectDAO();
        try {
            Subject subject = dao.get(user.getSchool().getCd(), cd);
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/subject/subject_delete.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目情報の取得中にエラーが発生しました。");
            req.getRequestDispatcher("/subject/subject_list.jsp").forward(req, resp);
        }
    }

    /**
     * 科目をデータベースから削除します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("--- SubjectDeleteServlet doPost Start ---");
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
            // 削除に失敗した場合は、エラーメッセージを付けて一覧に戻る
            req.setAttribute("error", "科目の削除に失敗しました。関連する成績データが存在する可能性があります。");
            // 一覧表示に必要なデータを再取得
            req.getRequestDispatcher("/subject/list").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/subject/list");
    }
}