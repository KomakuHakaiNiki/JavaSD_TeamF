// FILE: JavaSD/src/servlet/grade/GradeUpdateServlet.java
package grade;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Student;
import bean.Subject;
import bean.Test;
// import dao.TestDAO; // ★注意: このDAOは提供されていないため、別途作成が必要です

@WebServlet("/grade/update")
public class GradeUpdateServlet extends HttpServlet {

    /**
     * 成績更新ページを表示します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String studentNo = req.getParameter("studentNo");
        String subjectCd = req.getParameter("subjectCd");
        int no = Integer.parseInt(req.getParameter("no"));

        /*
         * ★注意: 成績を1件取得するためのTestDAOのメソッドが必要です。
         */
        // TestDAO testDao = new TestDAO();
        // try {
        //     Test test = testDao.get(studentNo, subjectCd, no);
        //     req.setAttribute("test", test);
        // } catch (Exception e) {
        //     e.printStackTrace();
        //     req.setAttribute("error", "成績情報の取得に失敗しました。");
        // }

        // DAOがないため、暫定的にリクエストパラメータをそのままセット
        req.setAttribute("studentNo", studentNo);
        req.setAttribute("subjectCd", subjectCd);
        req.setAttribute("no", no);

        req.getRequestDispatcher("/grade/grade_edit.jsp").forward(req, resp);
    }

    /**
     * 成績情報の更新処理を実行します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String studentNo = req.getParameter("studentNo");
        String subjectCd = req.getParameter("subjectCd");
        int no = Integer.parseInt(req.getParameter("no"));
        int point = Integer.parseInt(req.getParameter("point"));

        Test test = new Test();
        Student student = new Student();
        student.setNo(studentNo);
        Subject subject = new Subject();
        subject.setCd(subjectCd);

        test.setStudent(student);
        test.setSubject(subject);
        test.setNo(no);
        test.setPoint(point);

        /*
         * ★注意: 成績を更新するためのTestDAOのメソッドが必要です。
         */
        // TestDAO testDao = new TestDAO();
        // try {
        //     testDao.update(test);
        // } catch (Exception e) {
        //     e.printStackTrace();
        //     req.setAttribute("error", "成績の更新に失敗しました。");
        //     doGet(req, resp); // エラーメッセージと共にフォームを再表示
        //     return;
        // }

        resp.sendRedirect(req.getContextPath() + "/grade/search?studentNo=" + studentNo);
    }
}