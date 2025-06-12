package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.TestListStudent;

public class TestListStudentDAO extends DAO {

    /**
     * 指定した学生番号のテスト成績一覧を取得
     * @param studentNo 学生番号
     * @return テストリスト
     * @throws Exception
     */
    public List<TestListStudent> getTestListByStudentNo(String studentNo) throws Exception {
        List<TestListStudent> list = new ArrayList<>();
        String sql =
            "SELECT S.name AS subjectName, S.cd AS subjectCd, T.num, T.point " +
            "FROM TEST T " +
            "JOIN SUBJECT S ON T.subject_cd = S.cd " +
            "WHERE T.student_no = ? " +
            "ORDER BY S.cd, T.num";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, studentNo);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    TestListStudent test = new TestListStudent();
                    test.setSubjectName(rs.getString("subjectName"));
                    test.setSubjectCd(rs.getString("subjectCd"));
                    test.setNum(rs.getInt("num"));
                    test.setPoint(rs.getInt("point"));
                    list.add(test);
                }
            }
        }
        return list;
    }
}
