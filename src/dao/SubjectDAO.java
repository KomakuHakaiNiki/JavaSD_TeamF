package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Subject;

public class SubjectDAO extends DAO {

    // 全件取得
    public List<Subject> getAllSubjects() throws Exception {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT cd, name FROM SUBJECT";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Subject s = new Subject();
                s.setCd(rs.getString("cd"));
                s.setName(rs.getString("name"));
                // s.setSchool(...)  // School情報が必要ならJOINなどで取得
                list.add(s);
            }
        }
        return list;
    }

    // 主キー検索
    public Subject getSubjectByCd(String cd) throws Exception {
        Subject subject = null;
        String sql = "SELECT cd, name FROM SUBJECT WHERE cd = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, cd);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    subject = new Subject();
                    subject.setCd(rs.getString("cd"));
                    subject.setName(rs.getString("name"));
                    // subject.setSchool(...) // School情報も必要なら取得
                }
            }
        }
        return subject;
    }

    // 新規登録
    public int insertSubject(Subject subject) throws Exception {
        String sql = "INSERT INTO SUBJECT (cd, name) VALUES (?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, subject.getCd());
            st.setString(2, subject.getName());
            return st.executeUpdate();
        }
    }

    // 更新
    public int updateSubject(Subject subject) throws Exception {
        String sql = "UPDATE SUBJECT SET name = ? WHERE cd = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, subject.getName());
            st.setString(2, subject.getCd());
            return st.executeUpdate();
        }
    }

    // 削除
    public int deleteSubject(String cd) throws Exception {
        String sql = "DELETE FROM SUBJECT WHERE cd = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, cd);
            return st.executeUpdate();
        }
    }
}
