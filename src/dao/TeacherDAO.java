package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bean.Teacher;

public class TeacherDAO extends DAO {

    // 教員情報取得（主キー検索）
    public Teacher getTeacherById(String id) throws Exception {
        Teacher teacher = null;
        String sql = "SELECT id, password, name FROM TEACHER WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    teacher = new Teacher();
                    teacher.setId(rs.getString("id"));
                    teacher.setPassword(rs.getString("password"));
                    teacher.setName(rs.getString("name"));
                    // teacher.setSchool(...) // School情報が必要な場合はJOIN等
                }
            }
        }
        return teacher;
    }

    // ログイン認証（ID＋パスワード）
    public Teacher login(String id, String password) throws Exception {
        Teacher teacher = null;
        String sql = "SELECT id, password, name FROM TEACHER WHERE id = ? AND password = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, id);
            st.setString(2, password);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    teacher = new Teacher();
                    teacher.setId(rs.getString("id"));
                    teacher.setPassword(rs.getString("password"));
                    teacher.setName(rs.getString("name"));
                    // teacher.setSchool(...) // School情報も必要なら取得
                }
            }
        }
        return teacher;
    }

    // 新規登録
    public int insertTeacher(Teacher teacher) throws Exception {
        String sql = "INSERT INTO TEACHER (id, password, name) VALUES (?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, teacher.getId());
            st.setString(2, teacher.getPassword());
            st.setString(3, teacher.getName());
            return st.executeUpdate();
        }
    }

    // 更新
    public int updateTeacher(Teacher teacher) throws Exception {
        String sql = "UPDATE TEACHER SET password = ?, name = ? WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, teacher.getPassword());
            st.setString(2, teacher.getName());
            st.setString(3, teacher.getId());
            return st.executeUpdate();
        }
    }

    // 削除
    public int deleteTeacher(String id) throws Exception {
        String sql = "DELETE FROM TEACHER WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, id);
            return st.executeUpdate();
        }
    }
}
