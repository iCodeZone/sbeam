<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>游戏定价</title>
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
			
			<div>
			<div style="display:flex;">
			    <div class="panel panel-default" style="margin-left:20px;height:250px;width:900px;overflow-y:auto;">
				  	<div class="panel-heading">
				  		<h4>游戏定价</h4>
				  	</div>
					  <table class="table">
							<tr>
								<th>游戏ID</th>
								<th>游戏类型</th>
								<th>游戏名</th>
								<th>上传者类型</th>
								<th>开发者定价</th>
								<th>商城定价</th>
								<th>折扣价</th>
								<th>操作</th>
							</tr>
							<s:iterator value="#session.Games" >
								<s:form action="placeMallPrice" method="post">
								<s:hidden name="game.id" value="%{id}"/>
									<tr>
										<td><s:property value="id"/></td>
										<td>
											<s:iterator value="types">
												<s:property value="name" />
											</s:iterator>
										</td>
										<td><s:property value="name"/></td>
										<td style="width:100px;text-align:center;">
											<s:if test="type">
												个体开发者
											</s:if>
											<s:else>
												团队开发者
											</s:else>
										</td>
										<td><s:property value="developerPrice"/></td>	
										<td><s:textfield class="input" name="game.mallPrice" value="%{mallPrice}"/></td>
										<td><s:textfield class="input" name="game.discountPrice" value="%{discountPrice}"/></td>
										<td><s:submit class="btn btn-info" value="确定"/></td>
									</tr>
								</s:form>
							</s:iterator>
						</table>
					</div>
			    	<div class="panel panel-default" style="margin-left:20px;width:180px;height:120px;">
				  		<div class="panel-heading">
				    		<h3 class="panel-title">检索游戏</h3>
				  		</div>
				  		<div class="panel-body" id="newStaff">
				    		<s:form action="searchGame" method="post">
			    				<s:textfield name="game.id" class="input" value="" placeholder="请输入游戏编号" onfocus="this.placeholder=''" onblur="this.placeholder='请输入游戏编号'" />
			    				<s:submit class="btn btn-info" style="width:153px;" value="检索"/>
			    			</s:form>
				  		</div>
					</div>
				</div>
		    <s:if test="#session.Tip==true">
		    <div class="panel panel-default" style="margin-left:20px;height:150px;width:800px;overflow-y:auto;">
			    <table class="table">
				<tr>
					<th>游戏ID</th>
					<th>游戏类型</th>
					<th>游戏名</th>
					<th>上传者类型</th>
					<th>开发者定价</th>
					<th>商城定价</th>
					<th>折扣价</th>
					<th>操作</th>
				</tr>
				<s:iterator value="#session.Game" >
					<tr>
						<td><s:property value="id"/></td>
						<td>
							<s:iterator value="types">
								<s:property value="name" />
							</s:iterator>
						</td>
						<td><s:property value="name"/></td>
						<td style="width:100px;text-align:center;">
							<s:if test="type">
								个体开发者
							</s:if>
							<s:else>
								团队开发者
							</s:else>
						</td>
						<td><s:property value="developerPrice"/></td>
						<s:form action="placeMallPrice" method="post">
							<td><s:textfield class="input" name="game.mallPrice" value="%{mallPrice}"/></td>
							<td><s:textfield class="input" name="game.discountPrice" value="%{discountPrice}"/></td>
							<td><s:submit class="btn btn-info" value="确定"/></td>
						</s:form>
					</tr>
				</s:iterator>
				<tr>
			</table>
			<%session.removeAttribute("Tip"); %>
			</div>
			</s:if>
			
			<s:if test="#session.Tip==false">
				<h3>
					<div class="alert alert-warning alert-dismissible" role="alert">
  						<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<%
						out.println(session.getAttribute("tip")); 
						session.removeAttribute("Tip");
						%>
					</div>
				</h3>
			</s:if>
			</div>
		</div>
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
