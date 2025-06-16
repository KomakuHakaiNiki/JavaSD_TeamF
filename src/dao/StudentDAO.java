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
     * ★修正点★
     * 条件に基づいて学生情報を絞り込み検索します。
     * @param entYear 入学年度 (0の場合は条件に含めない)
     * @param classNum クラス番号 (nullまたは空文字の場合は条件に含めない)
     * @param schoolCd 学校コード (この引数を追加)
     * @return 絞り込み後の学生リスト
     * @throws Exception
     */
    public List<Student> filter(int entYear, String classNum, String schoolCd) throws Exception {
        List<Student> list = new ArrayList<>();
        // SQL文を修正: schoolCdで絞り込むように変更
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

            // パラメータをセットする順番を修正
            int paramIndex = 1;
            st.setString(paramIndex++, schoolCd); // 1番目のパラメータは学校コード

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

    // 他の既存メソッド...
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

    // insert, update, delete メソッドは変更なし
}
