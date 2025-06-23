package grade;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Teacher;
import bean.TestListSubject;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestDAO;
import dao.TestListStudentDAO;

@WebServlet("/grade/delete")
public class GradeDeleteServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // ↓↓↓★★ココを追加★★↓↓↓
	    Teacher loginUser = (Teacher) req.getSession().getAttribute("user");
	    String schoolCd = loginUser.getSchool().getCd();

	    StudentDAO sDao = new StudentDAO();
	    SubjectDAO subDao = new SubjectDAO();
	    try {
	        req.setAttribute("ent_years", sDao.getEntYears());
	        req.setAttribute("class_nums", sDao.getClassNums());
	        // ↓↓↓ 固定だった "tes" を schoolCd に変更 ↓↓↓
	        req.setAttribute("subjects", subDao.filterBySchool(schoolCd));

	        String entYear = req.getParameter("entYear");
	        String classNum = req.getParameter("classNum");
	        String subjectCd = req.getParameter("subjectCd");
	        if (entYear != null && classNum != null && subjectCd != null) {
	            TestListStudentDAO dao = new TestListStudentDAO();
	            List<TestListSubject> list = dao.filterBySubject(
	                Integer.parseInt(entYear), classNum, subjectCd, schoolCd
	            );
	            req.setAttribute("delete_list", list);
	        }
	    } catch (Exception e) {
	        req.setAttribute("error", "情報取得エラー");
	    }
	    req.getRequestDispatcher("/grade/grade_delete.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    // ↓↓↓★★ココも同様★★↓↓↓
	    Teacher loginUser = (Teacher) req.getSession().getAttribute("user");
	    String schoolCd = loginUser.getSchool().getCd();

	    String[] deleteIds = req.getParameterValues("deleteIds");
	    if (deleteIds != null) {
	        TestDAO dao = new TestDAO();
	        for (String key : deleteIds) {
	            String[] vals = key.split(",");
	            String studentNo = vals[0];
	            int num = Integer.parseInt(vals[1]);
	            try {
	                dao.delete(studentNo, req.getParameter("subjectCd"), num, schoolCd); // schoolCd
	            } catch (Exception e) {
	                // エラー時はメッセージ表示
	            }
	        }
	    }
	    // 再検索で一覧表示
	    doGet(req, resp);
	}
}

