package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.TestListStudent;
import bean.TestListSubject;

public class TestListStudentDAO extends DAO {

    /**
     * 科目情報で成績を検索します。
     * @param entYear 入学年度
     * @param classNum クラス番号
     * @param subjectCd 科目コード (String型) ★★★ ここを修正 ★★★
     * @param schoolCd 学校コード
     * @return TestListSubjectのリスト
     * @throws Exception
     */
    public List<TestListSubject> filterBySubject(int entYear, String classNum, String subjectCd, String schoolCd) throws Exception {
        List<TestListSubject> list = new ArrayList<>();
        String sql = "SELECT s.ENT_YEAR, s.NO AS student_no, s.NAME AS student_name, s.CLASS_NUM, t.NO AS test_no, t.POINT "
                   + "FROM STUDENT s "
                   + "LEFT JOIN TEST t ON s.NO = t.STUDENT_NO AND t.SUBJECT_CD = ? AND t.SCHOOL_CD = ? "
                   + "WHERE s.ENT_YEAR = ? AND s.CLASS_NUM = ? AND s.SCHOOL_CD = ? "
                   + "ORDER BY s.NO ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, subjectCd); // SQLの1番目の?に科目コードをセット
            st.setString(2, schoolCd);
            st.setInt(3, entYear);
            st.setString(4, classNum);
            st.setString(5, schoolCd);

            try (ResultSet rs = st.executeQuery()) {
                Map<String, TestListSubject> map = new HashMap<>();

                while (rs.next()) {
                    String studentNo = rs.getString("student_no");
                    TestListSubject tls;

                    if (map.containsKey(studentNo)) {
                        tls = map.get(studentNo);
                    } else {
                        tls = new TestListSubject();
                        tls.setEntYear(rs.getInt("ENT_YEAR"));
                        tls.setStudentNo(studentNo);
                        tls.setStudentName(rs.getString("student_name"));
                        tls.setClassNum(rs.getString("CLASS_NUM"));
                        tls.setPoints(new HashMap<>());
                        map.put(studentNo, tls);
                    }

                    tls.getPoints().put(rs.getInt("test_no"), rs.getInt("POINT"));
                }
                list.addAll(map.values());
            }
        }
        return list;
    }

    // filterByStudentメソッドは変更なし
    // ...
    public List<TestListStudent> filterByStudent(String studentNo) throws Exception {
        List<TestListStudent> list = new ArrayList<>();
        String sql =
            "SELECT sub.NAME AS subject_name, sub.CD AS subject_cd, t.NO, t.POINT " +
            "FROM TEST t " +
            "JOIN SUBJECT sub ON t.SUBJECT_CD = sub.CD AND t.SCHOOL_CD = sub.SCHOOL_CD " +
            "WHERE t.STUDENT_NO = ? " +
            "ORDER BY sub.CD, t.NO ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, studentNo);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    TestListStudent test = new TestListStudent();
                    test.setSubjectName(rs.getString("subject_name"));
                    test.setSubjectCd(rs.getString("subject_cd"));
                    test.setNum(rs.getInt("NO"));
                    test.setPoint(rs.getInt("POINT"));
                    list.add(test);
                }
            }
        }
        return list;
    }
}
