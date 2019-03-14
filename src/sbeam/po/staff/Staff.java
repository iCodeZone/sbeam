package sbeam.po.staff;

public class Staff {
	private Integer sid;           //工作人员登录编号
	private String spassword;  //工作人员登录密码
	private Integer stype;     //工作人员类型
	public Staff(){}
	
	//getter 方法
	public Integer getSid(){
		return sid;
	}
	public String getSpassword(){
		return spassword;
	}
	public Integer getStype(){
		return stype;
	}
	//setter 方法
	public void setSid(Integer sid){
		this.sid = sid;
	}
	public void setSpassword(String spassword){
		this.spassword = spassword;
	}
	public void setStype(Integer stype){
		this.stype = stype;
	}
}
