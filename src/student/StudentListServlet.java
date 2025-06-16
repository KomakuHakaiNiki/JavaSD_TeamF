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
import dao.StudentDAO;

/**
* 学生一覧を表示するためのサーブレットです。
* データベースから学生の全件リストを取得し、JSPに渡します。
*/
@WebServlet("/student/list")
public class StudentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // StudentDAOのインスタンスを生成
        StudentDAO dao = new StudentDAO();
        List<Student> students = null;

        try {
            // DAOを利用して全学生のリストを取得
            students = dao.getAllStudents();
        } catch (Exception e) {
            e.printStackTrace();
            // エラーが発生した場合、エラーメッセージを設定してエラーページなどに遷移させる
            // ここでは簡易的にコンソールに出力し、エラーページにフォワードする例
            req.setAttribute("error", "学生一覧の取得中にエラーが発生しました。");
            req.getRequestDispatcher("/error.jsp").forward(req, resp); // エラーページ(error.jsp)が別途必要
            return;
        }

        // 取得した学生リストをリクエストスコープに設定
        req.setAttribute("students", students);

        // 学生一覧ページ (student_list.jsp) にフォワード
        req.getRequestDispatcher("/student/student_list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // POSTリクエストの場合もGETと同じ処理を行う
        doGet(req, resp);
    }
}
