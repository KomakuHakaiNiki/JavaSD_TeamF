// FILE: JavaSD/src/servlet/grade/GradeCreateServlet.java
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

    /**
     * 初期表示時: 検索フォームの選択肢を準備して画面を表示します。
     * 検索実行後: 検索条件と結果を保持して画面を再表示します。
     */
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
            // プルダウン用のリストを取得
            List<Integer> entYears = sDao.getEntYears();
            List<String> classNums = sDao.getClassNums();
            List<Subject> subjects = subDao.filterBySchool(schoolCd);

            // JSPで使えるようにリクエストスコープにセット
            req.setAttribute("ent_years", entYears);
            req.setAttribute("class_nums", classNums);
            req.setAttribute("subjects", subjects);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "表示に必要な情報の取得に失敗しました。");
        }

        // 成績登録ページにフォワード
        req.getRequestDispatcher("/grade/grade_create.jsp").forward(req, resp);
    }

    /**
     * フォームからのリクエストを"search"と"regist"で振り分けます。
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String cmd = req.getParameter("cmd");

        if ("search".equals(cmd)) {
            searchProcess(req, resp);
        } else if ("regist".equals(cmd)) {
            registProcess(req, resp);
        }
    }

    /**
     * 検索処理
     */
    private void searchProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        String schoolCd = user.getSchool().getCd();

        int entYear = Integer.parseInt(req.getParameter("f1"));
        String classNum = req.getParameter("f2");
        String subjectCd = req.getParameter("f3");
        int num = Integer.parseInt(req.getParameter("f4"));

        TestDAO tDao = new TestDAO();
        try {
            List<Test> testResults = tDao.filter(entYear, classNum, subjectCd, num, schoolCd);
            req.setAttribute("results", testResults);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生の検索中にエラーが発生しました。");
        }
        // 検索条件と結果を保持したまま、再度画面表示処理(doGet)を呼び出す
        doGet(req, resp);
    }

    /**
     * 登録処理
     */
    private void registProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");

        Map<String, String[]> paramMap = req.getParameterMap();
        List<Test> testsToSave = new ArrayList<>();

        // フォームから送信された点数データをリストに変換
        for (String key : paramMap.keySet()) {
            if (key.startsWith("point_")) {
                String studentNo = key.substring("point_".length());
                String pointStr = paramMap.get(key)[0];

                if (pointStr != null && !pointStr.isEmpty()) {
                    int point = Integer.parseInt(pointStr);

                    Test test = new Test();
                    Student student = new Student();
                    student.setNo(studentNo);
                    test.setStudent(student);
                    test.setPoint(point);

                    test.setSchool(user.getSchool());
                    test.setClassNum(req.getParameter("class_num_" + studentNo));
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
            // DAOで成績を一括保存
            tDao.save(testsToSave);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "成績の登録中にエラーが発生しました。");
            doGet(req, resp); // エラー時は検索画面に戻す
            return;
        }

        // ★★★ 登録成功時、登録完了ページにフォワード ★★★
        req.getRequestDispatcher("/grade/grade_create_done.jsp").forward(req, resp);
    }
}
