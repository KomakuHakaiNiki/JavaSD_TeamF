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
        String sql = "SELECT no, name, entyear, classNum, isAttend FROM STUDENT";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Student s = new Student();
                s.setNo(rs.getString("no"));
                s.setName(rs.getString("name"));
                s.setEntyear(rs.getInt("entyear"));
                s.setClassNum(rs.getString("classNum"));
                s.setAttend(rs.getBoolean("isAttend"));
                // Schoolは別途JOINや2段階取得が必要な場合も（要設計）
                list.add(s);
            }
        }
        return list;
    }

    // 1件取得（主キー検索）
    public Student getStudentById(String no) throws Exception {
        Student student = null;
        String sql = "SELECT no, name, entyear, classNum, isAttend FROM STUDENT WHERE no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, no);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    student = new Student();
                    student.setNo(rs.getString("no"));
                    student.setName(rs.getString("name"));
                    student.setEntyear(rs.getInt("entyear"));
                    student.setClassNum(rs.getString("classNum"));
                    student.setAttend(rs.getBoolean("isAttend"));
                    // Schoolも必要に応じて
                }
            }
        }
        return student;
    }

    // 新規登録
    public int insertStudent(Student student) throws Exception {
        String sql = "INSERT INTO STUDENT (no, name, entyear, classNum, isAttend) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, student.getNo());
            st.setString(2, student.getName());
            st.setInt(3, student.getEntyear());
            st.setString(4, student.getClassNum());
            st.setBoolean(5, student.isAttend());
            return st.executeUpdate();
        }
    }

    // 更新
    public int updateStudent(Student student) throws Exception {
        String sql = "UPDATE STUDENT SET name = ?, entyear = ?, classNum = ?, isAttend = ? WHERE no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, student.getName());
            st.setInt(2, student.getEntyear());
            st.setString(3, student.getClassNum());
            st.setBoolean(4, student.isAttend());
            st.setString(5, student.getNo());
            return st.executeUpdate();
        }
    }

    // 削除
    public int deleteStudent(String no) throws Exception {
        String sql = "DELETE FROM STUDENT WHERE no = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, no);
            return st.executeUpdate();
        }
    }
}
