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

        // ログイン／学校チェックは省略…

        // パラメータ取得
        String entYearStr  = req.getParameter("entYear");
        String classNum    = req.getParameter("classNum");
        String attendParam = req.getParameter("attend");
        // attendParam が null のときは絞り込みなし
        Boolean attend = (attendParam != null) ? Boolean.TRUE : null;

        // entYear を int に変換。空文字またはエラー時は 0 と見做す
        int entYear = 0;
        if (entYearStr != null && !entYearStr.isEmpty()) {
            try {
                entYear = Integer.parseInt(entYearStr);
            } catch (NumberFormatException e) {
                entYear = 0;
            }
        }

        String schoolCd = user.getSchool().getCd();
        StudentDAO dao = new StudentDAO();

        try {
            // DAO へ引数を渡して絞込検索
            List<Student> studentList   = dao.filter(entYear, classNum, attend, schoolCd);
            // プルダウン用リスト取得（学校コードを渡す）
            List<Integer> entYearList   = dao.getEntYears(schoolCd);
            List<String>  classNumList  = dao.getClassNums(schoolCd);

            // リクエスト属性にセット
            req.setAttribute("studentList",      studentList);
            req.setAttribute("entYearList",      entYearList);
            req.setAttribute("classNumList",     classNumList);
            req.setAttribute("selectedEntYear",  (entYear > 0 ? entYear : null));
            req.setAttribute("selectedClassNum", classNum);
            req.setAttribute("selectedAttend",   attend);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "データの取得中にエラーが発生しました。");
        }

        // コンテキストパスを JSP で使うため属性にセット
        req.setAttribute("ctx", req.getContextPath());

        // パターンB: forward() をチェーンせずに単独で呼び出す
        req.getRequestDispatcher("/student/student_list.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
