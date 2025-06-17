// FILE: JavaSD/src/servlet/student/StudentUpdateServlet.java
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

@WebServlet("/student/update")
public class StudentUpdateServlet extends HttpServlet {

    /**
     * 学生更新ページを表示します。
     * データベースから変更対象の学生情報と、クラス選択用のリストを取得します。
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String no = req.getParameter("no");
        StudentDAO dao = new StudentDAO();
        try {
            // 変更対象の学生情報を取得
            Student student = dao.getStudentById(no);
            // クラス選択プルダウン用のリストを取得
            List<String> classNums = dao.getClassNums();

            // 取得したデータをJSPに渡すためにリクエストスコープにセット
            req.setAttribute("student", student);
            req.setAttribute("classNumList", classNums);

            // 変更ページにフォワード
            req.getRequestDispatcher("/student/student_edit.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の取得中にエラーが発生しました。");
            // エラーが発生した場合は一覧ページに戻る
            req.getRequestDispatcher("/student/list").forward(req, resp);
        }
    }

    /**
     * フォームから送信された情報で学生を更新します。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // フォームから送信されたデータを取得
        String no = req.getParameter("no");
        String name = req.getParameter("name");
        String entYearStr = req.getParameter("entYear");
        String classNum = req.getParameter("classNum");
        boolean isAttend = req.getParameter("isAttend") != null;

        int entYear = 0;
        try {
             entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            // エラー処理（本来はエラーメッセージをセットして戻す）
        }

        // Studentオブジェクトに値をセット
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntyear(entYear);
        student.setClassNum(classNum);
        student.setAttend(isAttend);
        student.setSchool(user.getSchool()); // ログインユーザーの学校情報をセット

        StudentDAO dao = new StudentDAO();
        try {
            dao.updateStudent(student);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生情報の更新に失敗しました。");
            req.setAttribute("student", student); // 入力内容を保持
            // エラー時もプルダウン用のリストを再取得して画面に戻す
            try {
                 List<String> classNums = dao.getClassNums();
                 req.setAttribute("classNumList", classNums);
            } catch (Exception e2) {
                 e2.printStackTrace();
            }
            req.getRequestDispatcher("/student/student_edit.jsp").forward(req, resp);
            return;
        }

        // 成功した場合、学生一覧画面にリダイレクト
        resp.sendRedirect(req.getContextPath() + "/student/list");
    }
}
