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
        // ログインチェック
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        if (user == null || user.getSchool() == null || user.getSchool().getCd() == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String schoolCd = user.getSchool().getCd();
        StudentDAO sDao    = new StudentDAO();
        SubjectDAO subDao  = new SubjectDAO();
        try {
            List<Integer> entYears  = sDao.getEntYears(schoolCd);
            List<String>  classNums = sDao.getClassNums(schoolCd);
            List<Subject> subjects  = subDao.filterBySchool(schoolCd);
            req.setAttribute("ent_years",  entYears);
            req.setAttribute("class_nums", classNums);
            req.setAttribute("subjects",   subjects);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "表示に必要な情報の取得に失敗しました。");
        }

        // フォワード
        req.getRequestDispatcher("/grade/grade_create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String cmd = req.getParameter("cmd");
        if ("search".equals(cmd)) {
            searchProcess(req, resp);
        } else if ("regist".equals(cmd)) {
            registProcess(req, resp);
        } else {
            doGet(req, resp);
        }
    }

    private void searchProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ログインチェック（省略可）
        HttpSession session = req.getSession();
        Teacher user = (Teacher) session.getAttribute("user");
        String schoolCd = user.getSchool().getCd();

        // 1) パラメータ取得
        String f1 = req.getParameter("f1"); // 入学年度
        String f2 = req.getParameter("f2"); // クラス
        String f3 = req.getParameter("f3"); // 科目
        String f4 = req.getParameter("f4"); // 回数

        // 2) 全部が空 ("----" を value="" にしているので "") ならエラー
        if ((f1 == null || f1.isEmpty())
         && (f2 == null || f2.isEmpty())
         && (f3 == null || f3.isEmpty())) {

            // エラーメッセージ
            req.setAttribute("error", "入学年度かクラスか科目を入力してください。");

            // プルダウン用データ再セット
            StudentDAO sDao    = new StudentDAO();
            SubjectDAO subDao  = new SubjectDAO();
            try {
                req.setAttribute("ent_years",  sDao.getEntYears(schoolCd));
                req.setAttribute("class_nums", sDao.getClassNums(schoolCd));
                req.setAttribute("subjects",   subDao.filterBySchool(schoolCd));
            } catch (Exception e) {
                e.printStackTrace();
            }

            // JSPへ戻す
            req.getRequestDispatcher("/grade/grade_create.jsp").forward(req, resp);
            return;
        }

        // 3) 数値変換（空チェック済みのもののみ）
        int entYear;
        try {
            entYear = Integer.parseInt(f1.trim());
        } catch (Exception e) {
            req.setAttribute("error", "入学年度の形式が不正です。");
            // 再取得＆フォワード
            doGet(req, resp);
            return;
        }
        String classNum  = f2;
        String subjectCd = f3;
        int num;
        try {
            num = Integer.parseInt(f4.trim());
        } catch (Exception e) {
            req.setAttribute("error", "回数の形式が不正です。");
            doGet(req, resp);
            return;
        }

        // 4) 検索実行
        TestDAO tDao = new TestDAO();
        try {
            List<Test> testResults = tDao.filter(entYear, classNum, subjectCd, num, schoolCd);
            req.setAttribute("results", testResults);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "学生の検索中にエラーが発生しました。");
        }

        // プルダウン再取得＆JSPフォワード
        doGet(req, resp);
    }

    private void registProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ...（既存の登録処理をそのまま）...
        req.setCharacterEncoding("UTF-8");
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

        // 完了画面へ
        req.getRequestDispatcher("/grade/grade_create_done.jsp").forward(req, resp);
    }
}
