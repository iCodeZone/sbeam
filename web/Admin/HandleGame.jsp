<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>游戏管理</title>
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
		
		<s:if test="%{#session.Games.size()>0}">
		<div>
		<div style="display:flex;">
		<div class="panel panel-default" style="margin-left:20px;height:240px;width:500px;overflow-y:auto;">
		  	<div class="panel-heading" style="text-align:center;">
			  	<h4>审核游戏</h4>
			</div>
		  	<table class="table">
				<tr>
					<th>游戏ID</th>
					<th>游戏名</th>
					<th>游戏类型</th>
					<th>上传者类型</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
					<s:iterator value="#session.Games" >
						<tr>
							<td><s:property value="id"/></td>
							<td><s:property value="name"/></td>
							<td>
								<s:iterator value="types">
									<s:property value="name" />
								</s:iterator>
							</td>
							<td style="width:100px;text-align:center;">
								<s:if test="type">
									个体开发者
								</s:if>
								<s:else>
									团队开发者
								</s:else>
							</td>
							<td>
								<s:if test="ground">
									上架中
								</s:if>
								<s:else>
									下架中
								</s:else>
							</td>
							<td>
							    <s:if test="ground">
									<s:form action="offTheShelf" method="post">
										<s:hidden name="game.id" value="%{id}"/>
										<s:submit class="btn btn-danger" value="下架" />
									</s:form>
								</s:if>
								<s:else>
									<s:form action="onTheShelf" method="post">
										<s:hidden name="game.id" value="%{id}"/>
										<s:submit class="btn btn-danger" value="上架" />
									</s:form>
								</s:else>
							</td>
						</tr>
					</s:iterator>
				<tr>
			</table>
		  </div>
		
	    <div class="panel panel-default" style="margin-left:20px;width:200px;height:120px;">
		  	<div class="panel-heading">
		    	<h3 class="panel-title">搜索游戏</h3>
		  	</div>
		  	<div class="panel-body">
		    	<s:form action="searchGames" method="post">
	    			<s:textfield name="game.id" class="input" value="" placeholder="请输入游戏编号" onfocus="this.placeholder=''" onblur="this.placeholder='请输入游戏编号'"/>
	    			<s:submit class="btn btn-info" style="width:153px;" value="检索"/>
	    		</s:form>
		  	</div>
		</div>
		</div>
	    <s:if test="#session.Tips">
	    <div class="panel panel-default" style="margin-left:20px;height:160px;width:500px;;">
		  	<table class="table">
				<tr>
					<th>游戏ID</th>
					<th>游戏名</th>
					<th>游戏类型</th>
					<th>上传者类型</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
					<s:iterator value="#session.Game" >
						<tr>
							<td><s:property value="id"/></td>
							<td><s:property value="name"/></td>
							<td>
								<s:iterator value="types">
									<s:property value="name" />
								</s:iterator>
							</td>
							<td style="width:100px;text-align:center;">
								<s:if test="type">
									个体开发者
								</s:if>
								<s:else>
									团队开发者
								</s:else>
							</td>
							<td>
								<s:if test="ground">
									上架中
								</s:if>
								<s:else>
									下架中
								</s:else>
							</td>
							<td>
							    <s:if test="ground">
									<s:form action="offTheShelf" method="post">
										<s:hidden name="game.id" value="%{id}"/>
										<s:submit class="btn btn-danger" value="下架" />
									</s:form>
								</s:if>
								<s:else>
									<s:form action="onTheShelf" method="post">
										<s:hidden name="game.id" value="%{id}"/>
										<s:submit class="btn btn-danger" value="上架" />
									</s:form>
								</s:else>
							</td>
						</tr>
					</s:iterator>
				<tr>
			</table>
			</div>
			<%session.removeAttribute("Tips"); %>
		</s:if>
		
		<s:if test="#session.Tips==false">
			<h3>
				<div class="alert alert-warning alert-dismissible" role="alert">
  					<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<%
					out.println(session.getAttribute("tips")); 
					session.removeAttribute("Tips");
					%>
				</div>
			</h3>
		</s:if>
		</div>
	</s:if>
	<s:if test="%{#session.Games.size()==0}">
		<div class="alert alert-warning alert-dismissible" role="alert">
  			<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			尚未有游戏通过审核，无需上架操作！
		</div>
	</s:if>
	</div>
  
 

	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
