// FILE: JavaSD/src/servlet/student/StudentListServlet.java
package student;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Student;
import bean.Teacher;
import dao.StudentDAO;

@WebServlet("/student/list")
public class StudentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        // ログインチェック
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        // 学校情報チェック
        if (user.getSchool() == null || user.getSchool().getCd() == null) {
            req.setAttribute("error", "セッションにユーザーの学校情報が見つかりません。再ログインしてください。");
            req.getRequestDispatcher("/student/student_list.jsp").forward(req, resp);
            return;
        }

        StudentDAO studentDao = new StudentDAO();

        // 絞り込み条件をリクエストから取得
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        String schoolCd = user.getSchool().getCd(); // ★セッションから学校コードを取得

        int entYear = 0;
        if (entYearStr != null && !entYearStr.isEmpty()) {
            try {
                entYear = Integer.parseInt(entYearStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        try {
            // ★★★★★ ここが修正点 ★★★★★
            // filterメソッドに3つの引数（入学年度、クラス番号、学校コード）を渡す
            List<Student> studentList = studentDao.filter(entYear, classNum, schoolCd);

            // プルダウン用のリストも取得
            List<Integer> entYearList = studentDao.getEntYears();
            List<String> classNumList = studentDao.getClassNums();

            // JSPにデータをセット
            req.setAttribute("studentList", studentList);
            req.setAttribute("entYearList", entYearList);
            req.setAttribute("classNumList", classNumList);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "データの取得中にエラーが発生しました。");
        }

        // JSPページにフォワード
        req.getRequestDispatcher("/student/student_list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
