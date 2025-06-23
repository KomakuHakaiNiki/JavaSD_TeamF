package grade;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.StudentDAO;
import dao.SubjectDAO;
import dao.TestDAO;

@WebServlet("/grade/create")
public class GradeCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String schoolCd = user.getSchool().getCd();
        StudentDAO sDao = new StudentDAO();
        SubjectDAO subDao = new SubjectDAO();
        try {
            List<Integer> entYears = sDao.getEntYears(schoolCd);
            List<String>  classNums = sDao.getClassNums(schoolCd);
            List<Subject> subjects  = subDao.filterBySchool(schoolCd);
            req.setAttribute("ent_years",  entYears);
            req.setAttribute("class_nums",  classNums);
            req.setAttribute("subjects",    subjects);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "表示に必要な情報の取得に失敗しました。");
        }

        req.getRequestDispatcher("/grade/grade_create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        String cmd = req.getParameter("cmd");
        if ("search".equals(cmd)) {
            searchProcess(req, resp);
        } else if ("regist".equals(cmd)) {
            registProcess(req, resp);
        }
    }

    private void searchProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        String schoolCd = user.getSchool().getCd();

        int entYear   = Integer.parseInt(req.getParameter("f1"));
        String classNum = req.getParameter("f2");
        String subjectCd= req.getParameter("f3");
        int num         = Integer.parseInt(req.getParameter("f4"));

        TestDAO tDao = new TestDAO();
        try {
            List<Test> testResults = tDao.filter(entYear, classNum, subjectCd, num, schoolCd);
            req.setAttribute("results", testResults);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生の検索中にエラーが発生しました。");
        }
        doGet(req, resp);
    }

    private void registProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        String schoolCd = user.getSchool().getCd();

        Map<String,String[]> paramMap = req.getParameterMap();
        List<Test> testsToSave = new ArrayList<>();

        for (String key : paramMap.keySet()) {
            if (key.startsWith("point_")) {
                String studentNo = key.substring("point_".length());
                String[] arr = paramMap.get(key);
                if (arr.length>0 && arr[0]!=null && !arr[0].isEmpty()) {
                    int point = Integer.parseInt(arr[0]);

                    Test test = new Test();
                    Student st = new Student();
                    st.setNo(studentNo);
                    test.setStudent(st);
                    test.setPoint(point);

                    test.setSchool(user.getSchool());
                    test.setClassNum(req.getParameter("class_num_"+studentNo));
                    Subject subject = new Subject();
                    subject.setCd(req.getParameter("subject_cd"));
                    test.setSubject(subject);
                    test.setNo(Integer.parseInt(req.getParameter("num")));

                    testsToSave.add(test);
                }
            }
        }

        TestDAO tDao = new TestDAO();
        try {
            tDao.save(testsToSave);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の登録中にエラーが発生しました。");
            doGet(req, resp);
            return;
        }

        req.getRequestDispatcher("/grade/grade_create_done.jsp").forward(req, resp);
    }
}
