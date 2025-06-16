package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.School;
import bean.Teacher;

public class TeacherDAO extends DAO {

    /**
     * IDとパスワードで認証を行い、教員情報を取得します。
     * ★修正点: 学校情報(SCHOOL_CD)も取得してセットするように変更
     * @param id 教員ID
     * @param password パスワード
     * @return 教員情報 (認証失敗時はnull)
     * @throws Exception
     */
    public Teacher login(String id, String password) throws Exception {
        Teacher teacher = null;
        // SQL文にSCHOOL_CDを追加
        String sql = "SELECT ID, PASSWORD, NAME, SCHOOL_CD FROM TEACHER WHERE ID = ? AND PASSWORD = ?";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, id);
            st.setString(2, password);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    teacher = new Teacher();
                    teacher.setId(rs.getString("ID"));
                    teacher.setPassword(rs.getString("PASSWORD"));
                    teacher.setName(rs.getString("NAME"));

                    // --- ここからが重要な修正 ---
                    // Schoolオブジェクトを生成
                    School school = new School();
                    // データベースから取得した学校コードをセット
                    school.setCd(rs.getString("SCHOOL_CD"));
                    // TeacherオブジェクトにSchoolオブジェクトをセット
                    teacher.setSchool(school);
                    // --- ここまでが重要な修正 ---
                }
            }
        }
        return teacher;
    }

    // 他のメソッド (getTeacherById, insertTeacherなど) はこの下に続きます...
}
