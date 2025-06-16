package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Test;
import bean.TestListStudent;

public class TestListStudentDAO extends DAO {

    /**
     * 指定した学生番号のテスト成績一覧を取得します。
     */
    public List<TestListStudent> getTestListByStudentNo(String studentNo) throws Exception {
        List<TestListStudent> list = new ArrayList<>();
        String sql =
            "SELECT S.NAME AS subjectName, S.CD AS subjectCd, T.NO, T.POINT " +
            "FROM TEST T " +
            "JOIN SUBJECT S ON T.SUBJECT_CD = S.CD AND T.SCHOOL_CD = S.SCHOOL_CD " +
            "WHERE T.STUDENT_NO = ? " +
            "ORDER BY S.CD, T.NO";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, studentNo);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    TestListStudent test = new TestListStudent();
                    test.setSubjectName(rs.getString("subjectName"));
                    test.setSubjectCd(rs.getString("subjectCd"));
                    test.setNum(rs.getInt("NO"));
                    test.setPoint(rs.getInt("point"));
                    list.add(test);
                }
            }
        }
        return list;
    }

    // ========== ここからが追加されたメソッド ==========

    /**
     * 成績を一件取得します。
     */
    public Test get(String studentNo, String subjectCd, String schoolCd, int no) throws Exception {
        Test test = null;
        String sql = "SELECT * FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, studentNo);
            st.setString(2, subjectCd);
            st.setString(3, schoolCd);
            st.setInt(4, no);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    test = new Test();
                    // ... (必要に応じてBeanに値をセット)
                }
            }
        }
        return test;
    }

    /**
     * 成績を登録または更新します。
     */
    public boolean save(Test test) throws Exception {
        String sql_check = "SELECT COUNT(*) FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        String sql_insert = "INSERT INTO TEST(STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) VALUES(?, ?, ?, ?, ?, ?)";
        String sql_update = "UPDATE TEST SET POINT = ? WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        int count = 0;

        try (Connection con = getConnection()) {
            try (PreparedStatement st_check = con.prepareStatement(sql_check)) {
                st_check.setString(1, test.getStudent().getNo());
                st_check.setString(2, test.getSubject().getCd());
                st_check.setString(3, test.getSchool().getCd());
                st_check.setInt(4, test.getNo());
                try(ResultSet rs = st_check.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) { // レコードが存在する場合
                        try (PreparedStatement st_update = con.prepareStatement(sql_update)) {
                            st_update.setInt(1, test.getPoint());
                            st_update.setString(2, test.getStudent().getNo());
                            st_update.setString(3, test.getSubject().getCd());
                            st_update.setString(4, test.getSchool().getCd());
                            st_update.setInt(5, test.getNo());
                            count = st_update.executeUpdate();
                        }
                    } else { // レコードが存在しない場合
                        try (PreparedStatement st_insert = con.prepareStatement(sql_insert)) {
                            st_insert.setString(1, test.getStudent().getNo());
                            st_insert.setString(2, test.getSubject().getCd());
                            st_insert.setString(3, test.getSchool().getCd());
                            st_insert.setInt(4, test.getNo());
                            st_insert.setInt(5, test.getPoint());
                            st_insert.setString(6, test.getClassNum());
                            count = st_insert.executeUpdate();
                        }
                    }
                }
            }
        }
        return count > 0;
    }
}
