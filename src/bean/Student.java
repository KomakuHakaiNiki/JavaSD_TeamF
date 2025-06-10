package bean;

import java.io.Serializable;

public class Student implements Serializable {

	private String no;
	private String name;
	private int entyear;
	private String classNum;
	private boolean isAttend;
	private School school;

	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getEntyear() {
		return entyear;
	}
	public void setEntyear(int entyear) {
		this.entyear = entyear;
	}
	public String getClassNum() {
		return classNum;
	}
	public void setClassNum(String classNum) {
		this.classNum = classNum;
	}
	public boolean isAttend() {
		return isAttend;
	}
	public void setAttend(boolean isAttend) {
		this.isAttend = isAttend;
	}
	public School getSchool() {
		return school;
	}
	public void setSchool(School school) {
		this.school = school;
	}

}
