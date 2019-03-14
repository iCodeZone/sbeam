<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="sbeam.po.message.Message" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>收到的消息</title>
    
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
		  <%int num=1; %>
		  <div class="panel panel-default" style="margin-left:20px;height:305px;width:700px;overflow-y:auto;">
			<div class="panel-heading" style="text-align:center;">
				<h4>收到的消息</h4>
			</div>
			<table class="table">
				<tr>
					<th width="30px"></th>
					<th>内容</th>
					<th>发送人</th>
					<th>收到时间</th>
				</tr>
				<s:iterator value="#session.Messages" >
					<tr>
						<td style="text-align:center;"><% out.print(num++); %></td>
						<td>
							<% 
							List<Message> Messages = (List<Message>)session.getAttribute("Messages");
							Message message = Messages.get(num-2);
							String s = message.getContent();
							out.println(s);
							%>
						</td>
						<td><s:property value="tid"/></td>
						<td><s:date name="time" format="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
							<div>
							<s:form action="confirmMessages" method="post">
								<s:hidden name="message.id" value="%{id}"/>
								<s:submit class="btn btn-success" value="标为已读"/>
							</s:form>
							</div>
						</td>
					</tr>
				</s:iterator>
			</table>
		  </div>
		  <s:if test="#session.nullTicket==true">
			  <div class="panel panel-default" style="margin-left:20px;height:90px;width:700px;">
				<table class="table" style="text-align:center;">
					<tr>
						<th>工单ID</th>
						<th>上传者ID</th>
						<th>上传者类型</th>
						<th>反馈时间</th>
						<th>工单类型</th>
						<th>具体内容</th>
					</tr>
					<s:iterator value="#session.Ticket" >
						<tr>
							<td><s:property value="pid"/></td>
							<td><s:property value="pfid"/></td>
							<td width="100px">
								<s:if test="ptype==1">
								用户
								</s:if>
								<s:if test="ptype==2">
								个体开发者
								</s:if>
								<s:if test="ptype==3">
								团队开发者
								</s:if>
							</td>
							<td width="200px"><s:date name="putime" format="yyyy-MM-dd HH:mm:ss"/></td>
							<td>
								<s:if test="type==1">
								简单问题反馈
								</s:if>
								<s:if test="type==2">
								bug问题反馈
								</s:if>
								<s:if test="type==3">
								侵权问题反馈
								</s:if>
								<s:if test="type==4">
								异常问题反馈
								</s:if>
							</td>
							<td><s:property value="pcontent"/></td>
						</tr>
					</s:iterator> 
				</table>
			  </div>
			  <%session.removeAttribute("nullTicket"); %>
			 </s:if>
			 <s:if test="#session.nullTicket==false">
			 	<div class="alert alert-warning alert-dismissible" role="alert">
  					<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					订单无法显示，出现错误！
				</div>
			 	<%session.removeAttribute("nullTicket"); %>
			 </s:if>
		</div>
	
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
