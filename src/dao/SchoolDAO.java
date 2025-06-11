package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;

public class SchoolDAO extends DAO {

    // 全件取得
    public List<School> getAllSchools() throws Exception {
        List<School> list = new ArrayList<>();
        String sql = "SELECT cd, name FROM SCHOOL";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                School school = new School();
                school.setCd(rs.getString("cd"));
                school.setName(rs.getString("name"));
                list.add(school);
            }
        }
        return list;
    }

    // 主キーで1件取得
    public School getSchoolByCd(String cd) throws Exception {
        School school = null;
        String sql = "SELECT cd, name FROM SCHOOL WHERE cd = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, cd);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    school = new School();
                    school.setCd(rs.getString("cd"));
                    school.setName(rs.getString("name"));
                }
            }
        }
        return school;
    }

    // 新規登録
    public int insertSchool(School school) throws Exception {
        String sql = "INSERT INTO SCHOOL (cd, name) VALUES (?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, school.getCd());
            st.setString(2, school.getName());
            return st.executeUpdate();
        }
    }

    // 更新
    public int updateSchool(School school) throws Exception {
        String sql = "UPDATE SCHOOL SET name = ? WHERE cd = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, school.getName());
            st.setString(2, school.getCd());
            return st.executeUpdate();
        }
    }

    // 削除
    public int deleteSchool(String cd) throws Exception {
        String sql = "DELETE FROM SCHOOL WHERE cd = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, cd);
            return st.executeUpdate();
        }
    }
}
