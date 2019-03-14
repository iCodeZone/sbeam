<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>工作人员调度</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="/sbeam/Source/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="/sbeam/Source/bootstrap-3.3.7-dist/css/bootstrap.min.css">
  	<link rel="stylesheet" href="/sbeam/Source/AdminPage/templatemo_main.css">
  	<style>
  	#header{
  		position:absolute;
  		top:0;
  		background-color:rgb(205,205,205);
  		width:100%;
  		height:80px;
  	}
  	#message{
  		margin-top:80px;
  	}
  	.input{
  		border:none;
  		border-bottom:1px solid rgb(5, 160, 233);
    	outline:medium;
    	margin-bottom:5px;
  	}
  	</style>
  </head>
  
  <body>
  	<div id="header">
  		<h1>sbeam <small>网上游戏商城</small></h1>
	</div> 
	<div id="message">
	    <button class="btn btn-info" type="button" style="width:235px;height:60px;border-radius:0;">
	  		<a href="/sbeam/Admin/ConfirmMessage.jsp">未读消息</a> 
	  		<s:if test="#session.MessageNum">
	  			<span class="badge"><s:property value="#session.MessageNum"/></span>
	  		</s:if>
		</button>
	</div>
	<div style="display:flex; flex-direction: row">
		<div>
	      <div class="navbar-collapse collapse templatemo-sidebar">
	        <ul class="templatemo-sidebar-menu">
	          <li class="sub open">
	            <a href="javascript:;">
	              <i class="fa fa-database"></i> 功能 <div class="pull-right"><span class="caret"></span></div>
	            </a>
	            <ul class="templatemo-submenu">
	              <li><a href="findAdmin">管理员列表</a></li>
	              <li><a href="findStaff">工作人员调度</a></li>
	              <li><a href="findGame">游戏调度</a></li>             
	              <li><a href="checkGamePrice">游戏定价</a></li>
	              <li><a href="showGameType">查看游戏种类</a></li>
	              <li><a href="/sbeam/AdminStaffLogin.jsp"><i class="fa fa-sign-out"></i>登出</a></li>
	            </ul>
	          </li>
	        </ul>
	      </div>
		</div>
		
		<div style="height:450px;overflow:hidden;">
			<div class="panel panel-default" style="height:420px;width:500px;margin-left:20px;overflow-y: auto;">
			  	<div class="panel-heading" style="text-align:center;">
			  		<h4>工作人员调度</h4>
			  	</div>
			    <table class="table">
					<tr>
						<th>工作人员ID</th>
						<th>工作人员类型</th>
						<th>操作</th>
					</tr>
					<s:iterator value="#session.Staffs" >
						<tr height="30px">
							<td><s:property value="sid"/></td>
							<td>
								<s:if test="stype==0">
									客服
								</s:if>
								<s:if test="stype==1">
									审核员
								</s:if>
							</td>
							<td>
								<div>
									<s:form action="dismissStaff" method="post">
										<s:hidden name="staff.sid" value="%{sid}"/>
										<s:submit class="btn btn-danger" value="辞退"/>
									</s:form>
								</div>
							</td>
						</tr>
					</s:iterator>
				</table>
			</div>
		</div>
		
		<div class="panel panel-default" style="margin-left:20px;width:200px;height:200px;">
  			<div class="panel-heading">
    			<h3 class="panel-title">创建员工专属账号</h3>
  			</div>
  			<div class="panel-body" id="newStaff">
    			<s:form action="dispatchStaff" method="post">
					<s:textfield name="staff.sid" class="input" value="" label="编号" placeholder="请输入编号" onfocus="this.placeholder=''" onblur="this.placeholder='请输入编号'"/>
					<s:password name="staff.spassword" class="input" value="" label="密码" placeholder="请输入初始密码" onfocus="this.placeholder=''" onblur="this.placeholder='请输入初始密码'"/>
					<s:select name="staff.stype" list="#{'0':'客服','1':'审核员'}" headerKey="0" headerValue="---员工类型---" style="height:25px;"	/><br/><br/>
					<s:submit class="btn btn-info" style="width:153px;" value="新建" />
				</s:form>
  			</div>
		</div>
		<s:if test="%{#session.addStaffError!=null}">
			<div class="alert alert-warning alert-dismissible" role="alert" style="height:50px;">
  				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<%
				out.println(session.getAttribute("addStaffError")); 
				session.removeAttribute("addStaffError");
				%>
			</div>
		</s:if>
	</div>
	
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
