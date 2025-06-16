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
     * 条件に基づいて学生情報を絞り込み検索します。
     * @param entYear 入学年度 (0の場合は条件に含めない)
     * @param classNum クラス番号 (nullまたは空文字の場合は条件に含めない)
     * @return 絞り込み後の学生リスト
     * @throws Exception
     */
    public List<Student> filter(int entYear, String classNum) throws Exception {
        List<Student> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM STUDENT WHERE 1=1");

        if (entYear != 0) {
            sql.append(" AND ENT_YEAR = ?");
        }
        if (classNum != null && !classNum.isEmpty()) {
            sql.append(" AND CLASS_NUM = ?");
        }
        sql.append(" ORDER BY NO ASC");

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (entYear != 0) {
                st.setInt(paramIndex++, entYear);
            }
            if (classNum != null && !classNum.isEmpty()) {
                st.setString(paramIndex++, classNum);
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
        return list;
    }

    /**
     * データベースに登録されている全ての入学年度を重複なく取得します。
     * @return 入学年度のリスト
     * @throws Exception
     */
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

    /**
     * ★追加されたメソッド★
     * データベースに登録されている全てのクラス番号を重複なく取得します。
     * @return クラス番号のリスト
     * @throws Exception
     */
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


    // 既存のメソッド (getStudentById, insertStudent など) はこの下に続きます...

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

    public int deleteStudent(String no) throws Exception {
        String sql = "DELETE FROM STUDENT WHERE NO = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, no);
            return st.executeUpdate();
        }
    }
}
