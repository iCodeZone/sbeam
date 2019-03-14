<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="sbeam.po.ticket.Ticket" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>工单详情</title>
    
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
		display:flex;
		justify-content:center;
		align-items:center;
	}
	#content{
	  	height:480px;
	  	box-shadow:2px 1px 10px 1px;
	  	background-color:rgba(246,246,247,0.85);
	  	border-radius:5px;
	  	position:absolute;
  	}
  	
  	#content > a {
  		width:100%;
  		position:absolute;
  		bottom:0;
  	}
	</style>
  </head>
  
  <body>
  	<div id="content">
	  	<div class="panel panel-default" style="height:200px;width:900px;overflow-y:auto;">
		    <div class="panel-heading" style="text-align:center;">
				<h4>工单详细信息</h4>
			</div>
		    <table class="table">
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
		<div style="display:flex;">
			<%
			List Ticket = (List)session.getAttribute("Ticket"); 
			Ticket ticket = (Ticket)Ticket.get(0);
			String src = "/sbeam";
            src += ticket.getPphotoaddr();
			%>
			<%if(ticket.getPphotoaddr()!=null){ %>
				<div id="img">
					<font style="position:absolute;bottom:255px;">截图详情</font><br/>
					<img src="<%=src%>"  style="width:400px;height:220px;position:absolute;bottom:35px;">
				</div>
			<%} %>
			<div style="position:absolute;right:0;margin-top:4px;">
				<s:form action="replyTicket" method="post">
					<s:hidden name="ticket.pid" value="#session.Ticket.pid"/>
					<s:textarea name="ticket.premes"  placeholder="请输入回复" onfocus="this.placeholder=''" onblur="this.placeholder='请输入回复'" rows="4" cols="52"/><br/>
					<s:submit value="提交" class="btn btn-success" style="width:100%;margin-top:2px;"/>
				</s:form>
				<div style="display:flex;">
					<s:form action="deliverTicket" method="post">
						<s:hidden name="ticket.pid" value="#session.Ticket.pid"/>
						<s:hidden name="game.type" value="false"/>
						<s:submit class="btn btn-success" value="转交个体开发者" style="margin-right:20px;"/>
					</s:form>
					
					<s:form action="deliverTicket" method="post">
						<s:hidden name="ticket.pid" value="#session.Ticket.pid"/>
						<s:hidden name="game.type" value="true"/>
						<s:submit class="btn btn-success" value="转交团队开发者" style="margin-right:20px;" />
					</s:form>
					
					<s:form action="deliverTicket" method="post">
						<s:hidden name="ticket.pid" value="#session.Ticket.pid"/>
						<s:submit class="btn btn-success" value="转交管理员" />
					</s:form>
				</div>
			</div>
		</div>
		<a href="/sbeam/Staff/HandleTicket.jsp" class="btn btn-info">返回上一页</a>
	</div>
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
    <script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
