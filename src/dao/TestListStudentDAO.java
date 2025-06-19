// FILE: JavaSD/src/dao/TestListStudentDAO.java
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
     * 科目情報で成績を検索します。(SQLロジック修正版)
     */
    public List<TestListSubject> filterBySubject(int entYear, String classNum, String subjectCd, String schoolCd) throws Exception {
        List<TestListSubject> list = new ArrayList<>();
        String sql = "SELECT "
                   + "s.ENT_YEAR, s.NO AS student_no, s.NAME AS student_name, s.CLASS_NUM, "
                   + "(SELECT POINT FROM TEST WHERE STUDENT_NO = s.NO AND SCHOOL_CD = s.SCHOOL_CD AND SUBJECT_CD = ? AND NO = 1) AS point1, "
                   + "(SELECT POINT FROM TEST WHERE STUDENT_NO = s.NO AND SCHOOL_CD = s.SCHOOL_CD AND SUBJECT_CD = ? AND NO = 2) AS point2 "
                   + "FROM STUDENT s "
                   + "WHERE s.ENT_YEAR = ? AND s.CLASS_NUM = ? AND s.SCHOOL_CD = ? "
                   + "ORDER BY s.NO ASC";

        // --- デバッグ出力開始 ---
        System.out.println("【DEBUG】filterBySubject SQL:");
        System.out.println(sql);
        System.out.printf("【DEBUG】parameters: entYear=%d, classNum=%s, subjectCd=%s, schoolCd=%s%n",
                          entYear, classNum, subjectCd, schoolCd);
        // --- ここまで ---

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, subjectCd);
            st.setString(2, subjectCd);
            st.setInt(3, entYear);
            st.setString(4, classNum);
            st.setString(5, schoolCd);

            System.out.println("【DEBUG】PreparedStatement: " + st);

            try (ResultSet rs = st.executeQuery()) {
                int rowCount = 0;
                while (rs.next()) {
                    rowCount++;
                    TestListSubject tls = new TestListSubject();
                    tls.setEntYear(rs.getInt("ENT_YEAR"));
                    tls.setStudentNo(rs.getString("student_no"));
                    tls.setStudentName(rs.getString("student_name"));
                    tls.setClassNum(rs.getString("CLASS_NUM"));

                    Map<Integer, Integer> points = new HashMap<>();
                    int p1 = rs.getInt("point1");
                    if (!rs.wasNull()) { points.put(1, p1); }
                    int p2 = rs.getInt("point2");
                    if (!rs.wasNull()) { points.put(2, p2); }
                    tls.setPoints(points);

                    System.out.printf("【DEBUG】row %d: no=%s, name=%s, points=%s%n",
                                      rowCount, tls.getStudentNo(), tls.getStudentName(), points);
                    list.add(tls);
                }
                System.out.println("【DEBUG】filterBySubject returned rows: " + list.size());
            }
        }
        return list;
    }

    /**
     * 学生番号で成績を検索します。
     */
    public List<TestListStudent> filterByStudent(String studentNo) throws Exception {
        List<TestListStudent> list = new ArrayList<>();
        String sql = "SELECT sub.NAME AS subject_name, sub.CD AS subject_cd, t.NO, t.POINT "
                   + "FROM TEST t "
                   + "JOIN SUBJECT sub "
                   + "  ON t.SUBJECT_CD = sub.CD AND t.SCHOOL_CD = sub.SCHOOL_CD "
                   + "WHERE t.STUDENT_NO = ? "
                   + "ORDER BY sub.CD, t.NO ASC";

        // --- デバッグ出力開始 ---
        System.out.println("【DEBUG】filterByStudent SQL:");
        System.out.println(sql);
        System.out.println("【DEBUG】parameter: studentNo=" + studentNo);
        // --- ここまで ---

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, studentNo);
            System.out.println("【DEBUG】PreparedStatement: " + st);

            try (ResultSet rs = st.executeQuery()) {
                int count = 0;
                while (rs.next()) {
                    count++;
                    TestListStudent bean = new TestListStudent();
                    bean.setSubjectName(rs.getString("subject_name"));
                    bean.setSubjectCd  (rs.getString("subject_cd"));
                    bean.setNum        (rs.getInt   ("NO"));
                    bean.setPoint      (rs.getInt   ("POINT"));
                    System.out.printf("【DEBUG】student row %d: %s, %s, %d->%d%n",
                                      count, bean.getSubjectCd(), bean.getSubjectName(), bean.getNum(), bean.getPoint());
                    list.add(bean);
                }
                System.out.println("【DEBUG】filterByStudent returned rows: " + list.size());
            }
        }
        return list;
    }
}

