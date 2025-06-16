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
     * @param schoolCd 学校コード
     * @return 絞り込み後の学生リスト
     * @throws Exception
     */
    public List<Student> filter(int entYear, String classNum, String schoolCd) throws Exception {
        List<Student> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM STUDENT WHERE SCHOOL_CD = ?");

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
            st.setString(paramIndex++, schoolCd);

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
     * 学生情報を1件取得します。
     * @param no 学生番号
     * @return 学生情報 (見つからない場合はnull)
     * @throws Exception
     */
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

    /**
     * 学生情報を新規登録します。
     * @param student 登録する学生情報 (学校情報を含む)
     * @return 実行された行数
     * @throws Exception
     */
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

    /**
     * ★★★このメソッドがエラーの原因です★★★
     * 学生情報を更新します。
     * @param student 更新する学生情報 (学校情報を含む)
     * @return 実行された行数
     * @throws Exception
     */
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

    // --- プルダウン用の補助メソッド ---
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
}
