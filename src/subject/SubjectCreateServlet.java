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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ログインチェック
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/subject/subject_create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        // ログインチェック
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String cd = req.getParameter("cd");
        String name = req.getParameter("name");

        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name);
        subject.setSchool(user.getSchool()); // ★ログインユーザーの学校情報をセット

        SubjectDAO dao = new SubjectDAO();
        try {
            // ★修正後のDAOのinsertメソッドを呼び出す
            dao.insert(subject);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "科目の登録に失敗しました。");
            req.getRequestDispatcher("/subject/subject_create.jsp").forward(req, resp);
            return;
        }

        // ★完了後はSubjectListServletにリダイレクト
        resp.sendRedirect(req.getContextPath() + "/subject/list");
    }
}
