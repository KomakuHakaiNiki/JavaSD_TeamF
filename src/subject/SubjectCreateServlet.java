// FILE: JavaSD/src/servlet/subject/SubjectCreateServlet.java
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

@WebServlet("/subject/create")
public class SubjectCreateServlet extends HttpServlet {

    /**
     * 科目登録ページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ログインチェック
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        // 登録ページへフォワード
        req.getRequestDispatcher("/subject/subject_create.jsp").forward(req, resp);
    }

    /**
     * 入力された情報で科目をデータベースに登録します。
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

        // 入力値のチェック
        if (cd == null || cd.trim().isEmpty() || name == null || name.trim().isEmpty()) {
             req.setAttribute("error", "科目コードと科目名は必須入力です。");
             req.getRequestDispatcher("/subject/subject_create.jsp").forward(req, resp);
             return;
        }

        // Subjectオブジェクトに値をセット
        Subject subject = new Subject();
        subject.setCd(cd.toUpperCase());
        subject.setName(name);
        subject.setSchool(user.getSchool());

        SubjectDAO dao = new SubjectDAO();
        try {
            dao.insert(subject);
        } catch (Exception e) {
            e.printStackTrace();
            if (e.getMessage() != null && (e.getMessage().toLowerCase().contains("primary key") || e.getMessage().toLowerCase().contains("unique constraint"))) {
                req.setAttribute("error", "エラー: 科目コード「" + subject.getCd() + "」は既に使用されています。");
            } else {
                req.setAttribute("error", "データベースエラー: 科目の登録に失敗しました。");
            }
            // 失敗した場合、入力値を保持したままフォームを再表示
            req.setAttribute("cd", cd);
            req.setAttribute("name", name);
            req.getRequestDispatcher("/subject/subject_create.jsp").forward(req, resp);
            return;
        }

        // ★★★ ここが修正点 ★★★
        // 成功した場合、登録完了ページにフォワードします。
        req.getRequestDispatcher("/subject/subject_create_done.jsp").forward(req, resp);
    }
}
