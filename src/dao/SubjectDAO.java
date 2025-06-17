package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Subject;

public class SubjectDAO extends DAO {

    /**
     * 指定された学校の科目リストを取得します。
     * @param schoolCd 学校コード
     * @return 科目のリスト
     * @throws Exception
     */
    public List<Subject> filterBySchool(String schoolCd) throws Exception {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM SUBJECT WHERE SCHOOL_CD = ? ORDER BY CD ASC";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, schoolCd);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Subject s = new Subject();
                    s.setCd(rs.getString("CD"));
                    s.setName(rs.getString("NAME"));

                    School school = new School();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    s.setSchool(school);

                    list.add(s);
                }
            }
        }
        return list;
    }

    /**
     * ★★★ このメソッドが今回の問題の原因です ★★★
     * 主キー（学校コード、科目コード）で科目を1件取得します。
     * @param schoolCd 学校コード
     * @param cd 科目コード
     * @return 科目情報 (見つからない場合はnull)
     * @throws Exception
     */
    public Subject get(String schoolCd, String cd) throws Exception {
        Subject subject = null;
        // SQL文が正しく引数(？)を使っていることを確認
        String sql = "SELECT * FROM SUBJECT WHERE SCHOOL_CD = ? AND CD = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            // 1番目の?に学校コードをセット
            st.setString(1, schoolCd);
            // 2番目の?に科目コードをセット
            st.setString(2, cd);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    subject = new Subject();
                    subject.setCd(rs.getString("CD"));
                    subject.setName(rs.getString("NAME"));

                    School school = new School();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    subject.setSchool(school);
                }
            }
        }
        return subject;
    }

    /**
     * 科目を新規登録します。
     */
    public int insert(Subject subject) throws Exception {
        String sql = "INSERT INTO SUBJECT (SCHOOL_CD, CD, NAME) VALUES (?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, subject.getSchool().getCd());
            st.setString(2, subject.getCd());
            st.setString(3, subject.getName());
            return st.executeUpdate();
        }
    }

    /**
     * 科目情報を更新します。
     */
    public int update(Subject subject) throws Exception {
        String sql = "UPDATE SUBJECT SET NAME = ? WHERE SCHOOL_CD = ? AND CD = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, subject.getName());
            st.setString(2, subject.getSchool().getCd());
            st.setString(3, subject.getCd());
            return st.executeUpdate();
        }
    }

    /**
     * 科目を削除します。
     */
    public int delete(String schoolCd, String cd) throws Exception {
        String sql = "DELETE FROM SUBJECT WHERE SCHOOL_CD = ? AND CD = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, schoolCd);
            st.setString(2, cd);
            return st.executeUpdate();
        }
    }
}
