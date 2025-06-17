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
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("--- SubjectUpdateServlet doGet Start ---"); // ★デバッグログ
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        String schoolCd = user.getSchool().getCd();

        // ★受け取ったパラメータをコンソールに出力
        System.out.println("[DEBUG] Parameter 'cd': " + cd);
        System.out.println("[DEBUG] Session 'schoolCd': " + schoolCd);

        SubjectDAO dao = new SubjectDAO();
        Subject subject = null;
        try {
            System.out.println("[DEBUG] Calling dao.get(schoolCd, cd)...");
            subject = dao.get(schoolCd, cd); // DAOを呼び出し

            // ★DAOから返ってきた結果をコンソールに出力
            if (subject != null) {
                System.out.println("[DEBUG] DAO returned Subject. cd: " + subject.getCd() + ", name: " + subject.getName());
            } else {
                System.out.println("[DEBUG] DAO returned null.");
            }

            req.setAttribute("subject", subject);
            System.out.println("--- Forwarding to /subject/subject_edit.jsp ---");
            req.getRequestDispatcher("/subject/subject_edit.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目情報の取得中にエラーが発生しました。");
            req.getRequestDispatcher("/subject/subject_list.jsp").forward(req, resp);
        }
    }

    /**
     * 入力された情報で科目を更新します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // doPostは変更なし
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "科目名は必須入力です。");
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
        resp.sendRedirect(req.getContextPath() + "/subject/list");
    }
}
