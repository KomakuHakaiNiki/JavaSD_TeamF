package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.Test;

public class TestDAO extends DAO {

    /**
     * 指定された条件で学生を検索し、既存のテスト点数も取得します。
     * @param entYear 入学年度
     * @param classNum クラス番号
     * @param subjectCd 科目コード
     * @param num テスト回数
     * @param schoolCd 学校コード
     * @return 点数情報を含む学生のリスト (Testビーンのリスト)
     * @throws Exception
     */
    public List<Test> filter(int entYear, String classNum, String subjectCd, int num, String schoolCd) throws Exception {
        List<Test> list = new ArrayList<>();
        String sql = "SELECT s.NO AS student_no, s.NAME AS student_name, s.CLASS_NUM, t.POINT "
                   + "FROM STUDENT s "
                   + "LEFT JOIN TEST t ON s.NO = t.STUDENT_NO AND t.SUBJECT_CD = ? AND t.NO = ? "
                   + "WHERE s.ENT_YEAR = ? AND s.CLASS_NUM = ? AND s.SCHOOL_CD = ? "
                   + "ORDER BY s.NO ASC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, subjectCd);
            st.setInt(2, num);
            st.setInt(3, entYear);
            st.setString(4, classNum);
            st.setString(5, schoolCd);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Test test = new Test();
                    Student student = new Student();
                    student.setNo(rs.getString("student_no"));
                    student.setName(rs.getString("student_name"));
                    test.setStudent(student);

                    test.setClassNum(rs.getString("CLASS_NUM"));
                    test.setPoint(rs.getInt("POINT"));

                    list.add(test);
                }
            }
        }
        return list;
    }

    /**
     * ★★★ このメソッドがエラーの原因です ★★★
     * 複数の成績データをまとめて登録または更新します (Upsert)。
     * トランザクション処理を行い、すべてのデータが成功するか、すべて失敗するかのどちらかになります。
     * @param list 登録または更新するTestオブジェクトのリスト
     * @return 処理が成功した場合はtrue
     */
    public boolean save(List<Test> list) throws Exception {
        String sql_check = "SELECT COUNT(*) FROM TEST WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";
        String sql_insert = "INSERT INTO TEST(STUDENT_NO, SUBJECT_CD, SCHOOL_CD, NO, POINT, CLASS_NUM) VALUES(?, ?, ?, ?, ?, ?)";
        String sql_update = "UPDATE TEST SET POINT = ? WHERE STUDENT_NO = ? AND SUBJECT_CD = ? AND SCHOOL_CD = ? AND NO = ?";

        try (Connection con = getConnection()) {
            // トランザクションを開始 (AutoCommitをオフにする)
            con.setAutoCommit(false);

            try {
                // リスト内の全件を処理
                for (Test test : list) {
                    // 既存レコードの存在チェック
                    try (PreparedStatement st_check = con.prepareStatement(sql_check)) {
                        st_check.setString(1, test.getStudent().getNo());
                        st_check.setString(2, test.getSubject().getCd());
                        st_check.setString(3, test.getSchool().getCd());
                        st_check.setInt(4, test.getNo());

                        try (ResultSet rs = st_check.executeQuery()) {
                            if (rs.next() && rs.getInt(1) > 0) { // レコードが存在する場合
                                try (PreparedStatement st_update = con.prepareStatement(sql_update)) {
                                    st_update.setInt(1, test.getPoint());
                                    st_update.setString(2, test.getStudent().getNo());
                                    st_update.setString(3, test.getSubject().getCd());
                                    st_update.setString(4, test.getSchool().getCd());
                                    st_update.setInt(5, test.getNo());
                                    st_update.executeUpdate();
                                }
                            } else { // レコードが存在しない場合
                                try (PreparedStatement st_insert = con.prepareStatement(sql_insert)) {
                                    st_insert.setString(1, test.getStudent().getNo());
                                    st_insert.setString(2, test.getSubject().getCd());
                                    st_insert.setString(3, test.getSchool().getCd());
                                    st_insert.setInt(4, test.getNo());
                                    st_insert.setInt(5, test.getPoint());
                                    st_insert.setString(6, test.getClassNum());
                                    st_insert.executeUpdate();
                                }
                            }
                        }
                    }
                }
                // すべての処理が成功したらコミット
                con.commit();
                return true;

            } catch (Exception e) {
                // エラーが発生したらロールバック
                con.rollback();
                throw e; // エラーを上位に伝える
            } finally {
                 // 正常・異常問わず、最後に必ずAutoCommitをオンに戻す
                con.setAutoCommit(true);
            }
        }
    }
}
