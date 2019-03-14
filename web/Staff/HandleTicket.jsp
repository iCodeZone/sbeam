<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>工单处理</title>
    
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
	<style>
  	body{
  		margin:0;
  		padding:0;
  		display:flex;
  		justify-content: center;
  		align-items:center;
  	}
  	#content{
  		width:900px;
  		height:480px;
  		box-shadow:2px 1px 10px 1px;
  		background-color:rgba(246,246,247,0.85);
  		border-radius:5px;
  		position:absolute;
  	}
  	#content > a{
  		width:100%;
  		position:absolute;
  		bottom:0;
  	}
  </style>
  </head>
  
  <body>
  	<div id="content">
		  <div class="panel panel-default" style="height:400px;width:900px;overflow-y:auto;">
		    <div class="panel-heading" style="text-align:center;">
				<h4>未处理工单信息</h4>
			</div>
		    <table class="table" style="text-align:center;">
				<tr>
					<th>工单ID</th>
					<th>上传者ID</th>
					<th>上传者类型</th>
					<th>反馈时间</th>
					<th>工单类型</th>
				</tr>
				<s:iterator value="#session.Tickets" >
					<tr>
						<td><s:property value="pid"/></td>
						<td><s:property value="pfid"/></td>
						<td width="100px">
							<s:if test="ptype==0">
							用户
							</s:if>
							<s:if test="ptype==1">
							个体开发者
							</s:if>
							<s:if test="ptype==2">
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
						<td>
							<s:form action="ticketDetail" method="post">
								<s:hidden name="ticket.pid" value="%{pid}" />
								<s:submit value="查看该工单详情" class="btn btn-warning" />
							</s:form>
						</td>
					</tr>
				</s:iterator> 
			</table>
		</div>
		<%session.removeAttribute("nullTicket"); %>
		<a href="/sbeam/Staff/StaffPage.jsp" class="btn btn-info">返回主页</a>
	</div>
	
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
    <script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
