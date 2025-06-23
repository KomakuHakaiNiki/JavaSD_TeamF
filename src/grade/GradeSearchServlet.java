// FILE: JavaSD/src/servlet/grade/GradeSearchServlet.java
package grade;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.TestListStudent;
import bean.TestListSubject;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestListStudentDAO;

@WebServlet("/grade/search")
public class GradeSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        // 開発中ログインチェックバイパス
        if (user == null || user.getSchool() == null) {
            Teacher dummy = new Teacher();
            School school = new School();
            school.setCd("tes"); // H2に登録済みの学校コード
            dummy.setSchool(school);
            session.setAttribute("user", dummy);
            user = dummy;
        }

        StudentDAO sDao = new StudentDAO();
        SubjectDAO subDao = new SubjectDAO();
        try {
            String schoolCd = user.getSchool().getCd();
            List<Integer> entYears = sDao.getEntYears(schoolCd);
            List<String>  classNums = sDao.getClassNums(schoolCd);
            List<Subject> subjects  = subDao.filterBySchool(schoolCd);
            req.setAttribute("ent_years",   entYears);
            req.setAttribute("class_nums",   classNums);
            req.setAttribute("subjects",     subjects);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "表示に必要な情報の取得に失敗しました。");
        }
        req.getRequestDispatcher("/grade/grade_list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String type = req.getParameter("search_type");
        if ("subject".equals(type)) {
            searchBySubject(req, resp);
        } else if ("student".equals(type)) {
            searchByStudent(req, resp);
        } else {
            doGet(req, resp);
        }
    }

    private void searchBySubject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        int entYear = Integer.parseInt(req.getParameter("f1"));
        String classNum   = req.getParameter("f2");
        String subjectCd  = req.getParameter("f3");
        String schoolCd   = user.getSchool().getCd();

        TestListStudentDAO dao = new TestListStudentDAO();
        try {
            List<TestListSubject> results = dao.filterBySubject(entYear, classNum, subjectCd, schoolCd);
            req.setAttribute("results_subject", results);
            req.setAttribute("searched_subject", subjectCd);
            // 科目名取得
            SubjectDAO sd = new SubjectDAO();
            String name = subjectCd;
            for (Subject s : sd.filterBySchool(schoolCd)) {
                if (subjectCd.equals(s.getCd())) { name = s.getName(); break; }
            }
            req.setAttribute("searched_subject_name", name);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の検索中にエラーが発生しました。");
        }
        doGet(req, resp);
    }

    private void searchByStudent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String studentNo = req.getParameter("f4");
        StudentDAO sDao = new StudentDAO();
        TestListStudentDAO tDao = new TestListStudentDAO();
        try {
            Student student = sDao.getStudentById(studentNo);
            List<TestListStudent> results = tDao.filterByStudent(studentNo);
            req.setAttribute("student", student);
            req.setAttribute("results_student", results);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の検索中にエラーが発生しました。");
        }
        doGet(req, resp);
    }
}