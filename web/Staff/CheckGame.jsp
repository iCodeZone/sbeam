<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="sbeam.po.game.Game" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>游戏审核</title>
    
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
  </head>
  <style>
  	body{
  		display:flex;
  		justify-content:center;
  		align-items:center;
  	}
  	#content{
  		height:400px;
  		box-shadow:2px 1px 10px 1px;
  		background-color:rgba(246,246,247,0.85);
  		border-radius:5px;
  		position:absolute;
  	}
  	#content > a{
  		position:absolute;
  		bottom:0;
  		width:100%;
  	}
  </style>
  <body>
  	<%
	int num=0; 
	List Games = (List)session.getAttribute("Games"); 
	List deve = (List)session.getAttribute("deve");
	int id=0;
	%>
  	<div id="content">
  	<s:if test="#session.nullGames">
  	<div class="panel panel-default" style="height:300px;width:700px;overflow-y:auto;">
	    <div class="panel-heading" style="text-align:center;">
			<h4>游戏简略信息</h4>
		</div>
	    <table class="table">
			<tr>
				<th>游戏ID</th>
				<th>游戏名称</th>
				<th>开发者ID</th>
				<th>开发者类型</th>
			</tr>
			<s:iterator value="#session.Games" >
				<tr>
					<td><s:property value="id"/></td>
					<% 
					if(num<Games.size()){
						Game game = (Game)Games.get(num);
						id = game.getId();
						num++;
					}
					%>
					<td><a href="gameDetails?game.id=<%=id%>"><s:property value="name"/></a></td>
					<td><s:property value="developerId"/></td>
					<td>
						<s:if test="type">
							团队
						</s:if>
						<s:else>
							个人
						</s:else>
					</td>
				</tr>
			</s:iterator>
			<tr>
		</table>
		</div>
	</s:if>
	<s:else>
		<div class="alert alert-warning alert-dismissible" role="alert" style="width:300px;">
  			<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  			暂无游戏可审核！
		</div>
	</s:else>
	<a href="/sbeam/Staff/StaffPage.jsp" class="btn btn-info">返回主页</a>
	</div>
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
