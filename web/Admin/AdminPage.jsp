<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>系统管理员</title>
    
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
  </head>
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
  </style>
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
	</div>
	
	
	
	
	
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
    <script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
