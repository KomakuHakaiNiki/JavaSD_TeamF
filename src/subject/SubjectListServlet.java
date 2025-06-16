// FILE: JavaSD/src/servlet/subject/SubjectListServlet.java
package subject;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDAO;

/**
 * 科目一覧を表示するためのサーブレットです。
 */
@WebServlet("/subject/list")
public class SubjectListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        // ログインしていない場合はログインページにリダイレクト
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        SubjectDAO dao = new SubjectDAO();
        List<Subject> list = null;

        try {
            // ログインしている教員の学校コードで科目を絞り込む
            list = dao.filterBySchool(user.getSchool().getCd());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目一覧の取得中にエラーが発生しました。");
        }

        // 取得したリストをリクエストスコープにセット
        req.setAttribute("subjects", list);

        // 科目一覧ページにフォワード
        req.getRequestDispatcher("/subject/subject_list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
