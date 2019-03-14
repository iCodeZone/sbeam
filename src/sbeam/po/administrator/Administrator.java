package sbeam.po.administrator;

public class Administrator {
	private Integer aid;           //管理员登录编号
	private String apassword;  //管理员登录密码
	public Administrator(){}
	
	//getter 方法 
	public Integer getAid(){
		return aid;
	}
	public String getApassword(){
		return apassword;
	}
	//setter 方法
	public void setAid(Integer aid){
		this.aid = aid;
	}
	public void setApassword(String apassword){
		this.apassword = apassword;
	}
}
