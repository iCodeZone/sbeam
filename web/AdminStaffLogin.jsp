<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="Source/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="Source/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="Source/AdminStaffLogin/admin.css">
  </head>
  
  <body style="margin: 0 auto;padding:0;overflow:hidden;">
	<canvas id='d1' width="1000" height="700" style="position:absolute;z-index:-2;filter: alpha(opacity=50);opacity: 0.5"></canvas>
	<canvas id='d2' width="1000" height="700" style="left: 440px; position:absolute;z-index:-2;filter: alpha(opacity=50);opacity: 0.5"></canvas>
		<div id="YST" style="width:600px; height:700px;text-align: center;left: 340px;position:absolute; display:flex;justify-content: center;">
    		<div style="width:480px; height:300px;  background-color:rgba(246,246,247,0.85);;opacity:0.5;margin-top:150px;box-shadow: 0 3px 10px 1px">
        		<ul class="nav nav-tabs nav-justified">
            		<li role="presentation"><a href="#" id="staff">员工通道</a></li>
            		<li role="presentation"><a href="#" id="admin">管理员通道</a></li>
        		</ul>
        		<div id="staff-content">
            		<s:form action="staffLogin" method="post">
						<s:textfield class="input" name="staff.sid" placeholder="请输入员工编号" onfocus="this.placeholder=''" onblur="this.placeholder='请输入员工编号'"/>
						<s:password class="input" name="staff.spassword" placeholder="请输入密码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入密码'"/>
						<s:submit class="button" value="登录"/>
					</s:form>
        		</div>
        		<div id="admin-content">
            		<s:form action="adminLogin" method="post">
						<s:textfield class="input"  name="administrator.aid"  placeholder="请输入管理员编号" onfocus="this.placeholder=''" onblur="this.placeholder='请输入管理员编号'"/>
						<s:password class="input" name="administrator.apassword"  placeholder="请输入密码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入密码'"/>
						<s:submit class="button" value="登录"/>
					</s:form>
        		</div>
    		</div>
		</div>


	<script src="Source/jquery-3.3.1.js"></script>
	<script src="Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
	<script type="text/javascript" src="Source/AdminStaffLogin/admin.js"></script>
	<script  src="Source/AdminStaffLogin/function.js"></script>
</body>
</html>
