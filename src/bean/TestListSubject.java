package bean;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * 成績一覧（科目単位）の情報を保持するBeanクラス
 */
public class TestListSubject implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 入学年度 */
    private int entYear;

    /** 学生番号 */
    private String studentNo;

    /** 氏名 */
    private String studentName;

    /** クラス番号 */
    private String classNum;

    /**
     * 成績Map（キー: テスト回数 (1回目, 2回目), 値: 得点）
     */
    private Map<Integer, Integer> points = new HashMap<>();

    // --- Getter / Setter ---

    public int getEntYear() {
        return entYear;
    }

    public void setEntYear(int entYear) {
        this.entYear = entYear;
    }

    public String getStudentNo() {
        return studentNo;
    }

    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getClassNum() {
        return classNum;
    }

    public void setClassNum(String classNum) {
        this.classNum = classNum;
    }

    public Map<Integer, Integer> getPoints() {
        return points;
    }

    public void setPoints(Map<Integer, Integer> points) {
        this.points = points;
    }

    // --- JSPで直接1回・2回を取り出すための補助メソッド ---

    /**
     * 1回目の得点を返す
     */
    public Integer getNo1() {
        return points.get(1);
    }

    /**
     * 1回目の得点を設定する
     */
    public void setNo1(Integer point) {
        if (point != null) {
            points.put(1, point);
        }
    }

    /**
     * 2回目の得点を返す
     */
    public Integer getNo2() {
        return points.get(2);
    }

    /**
     * 2回目の得点を設定する
     */
    public void setNo2(Integer point) {
        if (point != null) {
            points.put(2, point);
        }
    }
}
