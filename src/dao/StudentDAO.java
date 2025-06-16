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
     * 全ての学生情報を取得します。
     * @return 学生のリスト
     * @throws Exception
     */
    public List<Student> getAllStudents() throws Exception {
        List<Student> list = new ArrayList<>();
        // SQL文を修正: SCHOOL_CDカラムを追加
        String sql = "SELECT NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD FROM STUDENT";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Student s = new Student();
                s.setNo(rs.getString("NO"));
                s.setName(rs.getString("NAME"));
                s.setEntyear(rs.getInt("ENT_YEAR"));
                s.setClassNum(rs.getString("CLASS_NUM"));
                s.setAttend(rs.getBoolean("IS_ATTEND"));

                // Schoolオブジェクトを作成し、学校コードを設定
                School school = new School();
                school.setCd(rs.getString("SCHOOL_CD"));
                s.setSchool(school); // StudentにSchoolオブジェクトをセット

                list.add(s);
            }
        }
        return list;
    }

    /**
     * 指定した学生番号の学生情報を1件取得します。
     * @param no 学生番号
     * @return 学生情報 (見つからない場合はnull)
     * @throws Exception
     */
    public Student getStudentById(String no) throws Exception {
        Student student = null;
        // SQL文を修正: SCHOOL_CDカラムを追加
        String sql = "SELECT NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD FROM STUDENT WHERE NO = ?";
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

                    // Schoolオブジェクトを作成し、学校コードを設定
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
     * @param student 登録する学生情報
     * @return 実行された行数
     * @throws Exception
     */
    public int insertStudent(Student student) throws Exception {
        // SQL文を修正: SCHOOL_CDカラムとプレースホルダを追加
        String sql = "INSERT INTO STUDENT (NO, NAME, ENT_YEAR, CLASS_NUM, IS_ATTEND, SCHOOL_CD) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, student.getNo());
            st.setString(2, student.getName());
            st.setInt(3, student.getEntyear());
            st.setString(4, student.getClassNum());
            st.setBoolean(5, student.isAttend());
            // studentオブジェクトからSchoolオブジェクトを取得し、さらにその中のCDを取得
            st.setString(6, student.getSchool().getCd());

            return st.executeUpdate();
        }
    }

    /**
     * 学生情報を更新します。
     * @param student 更新する学生情報
     * @return 実行された行数
     * @throws Exception
     */
    public int updateStudent(Student student) throws Exception {
        // SQL文を修正: SCHOOL_CDカラムの更新を追加
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

    /**
     * 指定した学生番号の学生情報を削除します。
     * @param no 削除する学生番号
     * @return 実行された行数
     * @throws Exception
     */
    public int deleteStudent(String no) throws Exception {
        String sql = "DELETE FROM STUDENT WHERE NO = ?";
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {

            st.setString(1, no);
            return st.executeUpdate();
        }
    }
}
