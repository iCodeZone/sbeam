<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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

  </head>
  
  <body>
        <table border=1 style="text-align:center;">
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
	
	<a href="/sbeam/Admin/ConfirmMessage.jsp">返回主页</a>
  </body>
</html>
