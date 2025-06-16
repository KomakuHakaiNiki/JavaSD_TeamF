// FILE: JavaSD/src/servlet/student/StudentListServlet.java
package student;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Student;
// import dao.ClassNumDAO; // ★ClassNumDAOのインポートを削除
import dao.StudentDAO;

@WebServlet("/student/list")
public class StudentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // DAOのインスタンス化
        StudentDAO studentDao = new StudentDAO();
        // ClassNumDAO classNumDao = new ClassNumDAO(); // ★ClassNumDAOのインスタンス化を削除

        // 絞り込み条件をリクエストから取得
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");

        int entYear = 0; // 未選択時のデフォルト値
        if (entYearStr != null && !entYearStr.isEmpty()) {
            try {
                entYear = Integer.parseInt(entYearStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        try {
            // 1. 入学年度のリストをDAOから取得 (プルダウン用)
            List<Integer> entYearList = studentDao.getEntYears();

            // 2. クラス番号のリストをStudentDAOから取得 (プルダウン用) ★ここを修正
            List<String> classNumList = studentDao.getClassNums();

            // 3. 絞り込み条件に合った学生のリストを取得
            List<Student> studentList = studentDao.filter(entYear, classNum);


            // JSPに渡すためにリクエストスコープにデータをセット
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
