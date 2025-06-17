// FILE: JavaSD/src/servlet/subject/SubjectListServlet.java
package subject;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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
        System.out.println("--- SubjectListServlet doGet Start ---"); // デバッグログ
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        // ログインチェック
        if (user == null) {
            System.out.println("[DEBUG] User not logged in. Redirecting to login page.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 学校情報チェック
        if (user.getSchool() == null || user.getSchool().getCd() == null) {
            System.out.println("[DEBUG] School info not in session for user: " + user.getId());
            req.setAttribute("error", "ユーザー情報に学校が設定されていません。");
            req.getRequestDispatcher("/subject/subject_list.jsp").forward(req, resp);
            return;
        }

        String schoolCd = user.getSchool().getCd();
        System.out.println("[DEBUG] Logged in user's school_cd: " + schoolCd);

        SubjectDAO dao = new SubjectDAO();
        List<Subject> list = new ArrayList<>(); // 空で初期化

        // try-catchブロックでエラーを詳細に捕捉
        try {
            list = dao.filterBySchool(schoolCd);
            System.out.println("[DEBUG] dao.filterBySchool() result size: " + list.size()); // ★取得件数を確認

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
        System.out.println("--- Forwarding to JSP ---");
        req.getRequestDispatcher("/subject/subject_list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
