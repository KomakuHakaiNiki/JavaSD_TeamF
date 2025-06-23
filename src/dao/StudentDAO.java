package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.School;
import bean.Student;

/**
 * DAO: STUDENT テーブル操作
 */
public class StudentDAO extends DAO {

    /**
     * 条件に基づいて学生情報を絞り込み検索します。(デバッグ機能付き)
     */
    public List<Student> filter(int entYear, String classNum, Boolean attend, String schoolCd) throws Exception {
        System.out.println("--- StudentDAO.filter Start ---");
        List<Student> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder()
            .append("SELECT NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD ")
            .append("FROM STUDENT WHERE SCHOOL_CD = ?");
        if (entYear > 0)               sql.append(" AND ENT_YEAR = ?");
        if (classNum != null && !classNum.isEmpty()) sql.append(" AND CLASS_NUM = ?");
        if (attend != null)            sql.append(" AND IS_ATTEND = ?");
        sql.append(" ORDER BY NO ASC");

        System.out.println("[DEBUG] Executing SQL: " + sql);

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {

            int idx = 1;
            st.setString(idx++, schoolCd);
            if (entYear > 0)        st.setInt(idx++, entYear);
            if (classNum != null && !classNum.isEmpty()) st.setString(idx++, classNum);
            if (attend != null)     st.setBoolean(idx++, attend);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Student s = new Student();
                    s.setNo(rs.getString("NO"));
                    s.setName(rs.getString("NAME"));
                    s.setEntyear(rs.getInt("ENT_YEAR"));
                    s.setClassNum(rs.getString("CLASS_NUM"));
                    s.setAttend(rs.getBoolean("IS_ATTEND"));
                    School sch = new School();
                    sch.setCd(rs.getString("SCHOOL_CD"));
                    s.setSchool(sch);
                    list.add(s);
                }
            }
        }

        System.out.println("[DEBUG] SQL execution finished. " + list.size() + " records found.");
        System.out.println("--- StudentDAO.filter End ---");
        return list;
    }

    /**
     * 入学年度一覧取得 (指定学校)
     */
    public List<Integer> getEntYears(String schoolCd) throws Exception {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT DISTINCT ENT_YEAR FROM STUDENT WHERE SCHOOL_CD = ? ORDER BY ENT_YEAR DESC";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, schoolCd);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt("ENT_YEAR"));
                }
            }
        }
        return list;
    }

    /**
     * クラス番号一覧取得 (指定学校)
     */
    public List<String> getClassNums(String schoolCd) throws Exception {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT CLASS_NUM FROM STUDENT WHERE SCHOOL_CD = ? AND CLASS_NUM IS NOT NULL ORDER BY CLASS_NUM ASC";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, schoolCd);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("CLASS_NUM"));
                }
            }
        }
        return list;
    }

    /**
     * 学生番号でひとり分の Student を取得します
     */
    public Student getStudentById(String no) throws Exception {
        String sql = "SELECT NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD FROM STUDENT WHERE NO = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, no);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Student s = new Student();
                    s.setNo(rs.getString("NO"));
                    s.setName(rs.getString("NAME"));
                    s.setEntyear(rs.getInt("ENT_YEAR"));
                    s.setClassNum(rs.getString("CLASS_NUM"));
                    s.setAttend(rs.getBoolean("IS_ATTEND"));
                    School sch = new School();
                    sch.setCd(rs.getString("SCHOOL_CD"));
                    s.setSchool(sch);
                    return s;
                }
            }
        }
        return null;
    }

    /**
     * 学生情報を更新します
     */
    public int updateStudent(Student student) throws Exception {
        String sql = "UPDATE STUDENT SET NAME = ?, ENT_YEAR = ?, CLASS_NUM = ?, IS_ATTEND = ?, SCHOOL_CD = ? WHERE NO = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, student.getName());
            st.setInt   (2, student.getEntyear());
            st.setString(3, student.getClassNum());
            st.setBoolean(4, student.isAttend());
            st.setString(5, student.getSchool().getCd());
            st.setString(6, student.getNo());
            return st.executeUpdate();
        }
    }

    /**
     * 新しい学生を登録します
     */
    public int insertStudent(Student student) throws Exception {
        String sql = "INSERT INTO STUDENT (NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, student.getNo());
            st.setString(2, student.getName());
            st.setInt   (3, student.getEntyear());
            st.setString(4, student.getClassNum());
            st.setBoolean(5, student.isAttend());
            st.setString(6, student.getSchool().getCd());
            return st.executeUpdate();
        }
    }
}
