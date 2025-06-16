// FILE: JavaSD/src/servlet/subject/SubjectListServlet.java
package subject;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;
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

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ★NullPointerExceptionを回避するため、学校情報がnullでないことを確認
        if (user.getSchool() == null) {
            req.setAttribute("error", "ユーザー情報に学校が設定されていません。");
            req.getRequestDispatcher("/subject/subject_list.jsp").forward(req, resp);
            return;
        }

        SubjectDAO dao = new SubjectDAO();
        List<Subject> list = null;

        // ★ try-catchブロックを詳細化
        try {
            list = dao.filterBySchool(user.getSchool().getCd());
        } catch (NamingException e) {
            e.printStackTrace();
            req.setAttribute("error", "データベースリソースの取得に失敗しました。context.xmlの設定を確認してください。");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "データベース処理中にエラーが発生しました。SQL文やテーブル定義を確認してください。");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "予期せぬエラーが発生しました。");
        }

        req.setAttribute("subjects", list);
        req.getRequestDispatcher("/subject/subject_list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
