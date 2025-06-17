// FILE: JavaSD/src/dao/StudentDAO.java
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;

public class StudentDAO extends DAO {

    /**
     * 条件に基づいて学生情報を絞り込み検索します。(デバッグ機能付き)
     */
    public List<Student> filter(int entYear, String classNum, String schoolCd) throws Exception {
        System.out.println("--- StudentDAO filter Start ---"); // ★デバッグログ
        List<Student> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM STUDENT WHERE SCHOOL_CD = ?");

        // 条件に応じてWHERE句を動的に追加
        if (entYear != 0) {
            sql.append(" AND ENT_YEAR = ?");
        }
        if (classNum != null && !classNum.isEmpty()) {
            sql.append(" AND CLASS_NUM = ?");
        }
        sql.append(" ORDER BY NO ASC");

        // ★実行されるSQL文をコンソールに出力
        System.out.println("[DEBUG] Executing SQL: " + sql.toString());

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {

            // パラメータをセット
            int paramIndex = 1;
            st.setString(paramIndex++, schoolCd);
            System.out.println("[DEBUG] Param 1 (SCHOOL_CD): " + schoolCd);

            if (entYear != 0) {
                st.setInt(paramIndex++, entYear);
                System.out.println("[DEBUG] Param " + (paramIndex-1) + " (ENT_YEAR): " + entYear);
            }
            if (classNum != null && !classNum.isEmpty()) {
                st.setString(paramIndex++, classNum);
                 System.out.println("[DEBUG] Param " + (paramIndex-1) + " (CLASS_NUM): " + classNum);
            }

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Student s = new Student();
                    s.setNo(rs.getString("NO"));
                    s.setName(rs.getString("NAME"));
                    s.setEntyear(rs.getInt("ENT_YEAR"));
                    s.setClassNum(rs.getString("CLASS_NUM"));
                    s.setAttend(rs.getBoolean("IS_ATTEND"));
                    School school = new School();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    s.setSchool(school);
                    list.add(s);
                }
            }
        }
        // ★取得した件数をコンソールに出力
        System.out.println("[DEBUG] SQL execution finished. " + list.size() + " records found.");
        System.out.println("--- StudentDAO filter End ---");
        return list;
    }

    // 他のメソッド (getEntYears, getClassNums, getStudentById, etc.) は変更なし
    // ...
    public List<Integer> getEntYears() throws Exception {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT DISTINCT ENT_YEAR FROM STUDENT ORDER BY ENT_YEAR DESC";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getInt("ENT_YEAR"));
            }
        }
        return list;
    }

    public List<String> getClassNums() throws Exception {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT CLASS_NUM FROM STUDENT WHERE CLASS_NUM IS NOT NULL ORDER BY CLASS_NUM ASC";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("CLASS_NUM"));
            }
        }
        return list;
    }

    public Student getStudentById(String no) throws Exception {
        Student student = null;
        String sql = "SELECT * FROM STUDENT WHERE NO = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, no);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    student = new Student();
                    student.setNo(rs.getString("NO"));
                    student.setName(rs.getString("NAME"));
                    student.setEntyear(rs.getInt("ENT_YEAR"));
                    student.setClassNum(rs.getString("CLASS_NUM"));
                    student.setAttend(rs.getBoolean("IS_ATTEND"));
                    School school = new School();
                    school.setCd(rs.getString("SCHOOL_CD"));
                    student.setSchool(school);
                }
            }
        }
        return student;
    }

    public int insertStudent(Student student) throws Exception {
        String sql = "INSERT INTO STUDENT (NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, student.getNo());
            st.setString(2, student.getName());
            st.setInt(3, student.getEntyear());
            st.setString(4, student.getClassNum());
            st.setBoolean(5, student.isAttend());
            st.setString(6, student.getSchool().getCd());
            return st.executeUpdate();
        }
    }

    public int updateStudent(Student student) throws Exception {
        String sql = "UPDATE STUDENT SET NAME = ?, ENT_YEAR = ?, CLASS_NUM = ?, IS_ATTEND = ?, SCHOOL_CD = ? WHERE NO = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, student.getName());
            st.setInt(2, student.getEntyear());
            st.setString(3, student.getClassNum());
            st.setBoolean(4, student.isAttend());
            st.setString(5, student.getSchool().getCd());
            st.setString(6, student.getNo());
            return st.executeUpdate();
        }
    }
}
