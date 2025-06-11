package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.Student;

public class StudentDAO extends DAO {
    // 全件取得
    public List<Student> getAllStudents() throws Exception {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT no, name FROM STUDENT";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Student s = new Student();
                s.setNo(rs.getString("no"));
                s.setName(rs.getString("name"));
                list.add(s);
            }
        }
        return list;
    }

    // 1件取得（主キー検索）
    public Student getStudentById(String No) throws Exception {
        Student student = null;
        String sql = "SELECT no, name FROM STUDENT WHERE no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, No);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    student = new Student();
                    student.setNo(rs.getString("setNo"));
                    student.setName(rs.getString("setName"));
                }
            }
        }
        return student;
    }

    // 新規登録
    public int insertStudent(Student student) throws Exception {
        String sql = "INSERT INTO STUDENT (no, name) VALUES (?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, student.getNo());
            st.setString(2, student.getName());
            return st.executeUpdate();
        }
    }

    // 更新
    public int updateStudent(Student student) throws Exception {
        String sql = "UPDATE STUDENT SET name = ? WHERE no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, student.getName());
            st.setString(2, student.getNo());
            return st.executeUpdate();
        }
    }

    // 削除
    public int deleteStudent(String No) throws Exception {
        String sql = "DELETE FROM STUDENT WHERE no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, No);
            return st.executeUpdate();
        }
    }
}
