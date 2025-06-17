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

    /**
     * 科目更新ページを表示します。
     * データベースから変更対象の科目情報を取得します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        // ログインと学校情報のチェック
        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        SubjectDAO dao = new SubjectDAO();
        try {
            Subject subject = dao.get(user.getSchool().getCd(), cd);
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/subject/subject_edit.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目情報の取得中にエラーが発生しました。");
            req.getRequestDispatcher("/subject/subject_list.jsp").forward(req, resp);
        }
    }

    /**
     * 入力された情報で科目を更新し、完了ページに遷移します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        // ログインと学校情報のチェック
        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        // 入力値チェック
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "科目名は必須入力です。");
            // エラー時も表示に必要な情報を再取得
            doGet(req, resp);
            return;
        }

        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        subject.setSchool(user.getSchool());

        SubjectDAO dao = new SubjectDAO();
        try {
            dao.update(subject);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目情報の更新に失敗しました。");
            req.setAttribute("subject", subject);
            req.getRequestDispatcher("/subject/subject_edit.jsp").forward(req, resp);
            return;
        }

        // ★★★ ここからが修正点 ★★★
        // 成功した場合、変更完了ページにフォワードします。
        req.getRequestDispatcher("/subject/subject_update_done.jsp").forward(req, resp);
    }
}
