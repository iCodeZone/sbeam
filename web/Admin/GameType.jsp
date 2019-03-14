<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>游戏种类显示</title>
    
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
		
		
	  	<div class="panel panel-default" style="margin-left:20px;height:250px;width:200px;overflow-y:auto;">
			<div class="panel-heading" style="text-align:center;">
				<h4>游戏类型</h4>
			</div>
		    <table class="table">
		    	<tr>
		    		<th>类型ID</th>
		    		<th>类型名</th>
		    	</tr>
		    	<s:iterator value="#session.GameTypes" >
					<tr>
						<td><s:property value="id"/></td>
						<td><s:property value="name"/></td>
					</tr>
				</s:iterator>
		    </table>
		</div>
	
		<div class="panel panel-default" style="margin-left:20px;width:200px;height:120px;">
			<div class="panel-heading">
			    <h3 class="panel-title">设定新的游戏类型</h3>
			</div>
			<div class="panel-body">
				<s:form action="addGameType" method="post">
					<s:textfield name="gameType.name" class="input" value="" placeholder="请输入游戏类型" onfocus="this.placeholder=''" onblur="this.placeholder='请输入游戏类型'"/>
					<s:submit class="btn btn-info" style="width:153px;" value="添加" />
				</s:form>
			</div>
		</div>
	</div>
		
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
