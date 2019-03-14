<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="sbeam.po.game.Game" %>
<%@ page import="sbeam.po.customer.Customer" %>
<%@ page import="sbeam.po.order.Order" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>更新用户信息</title>
    
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

  	.input{
  		border:none;
  		border-bottom:1px solid rgb(5, 160, 233);
    	outline:medium;
    	margin-bottom:5px;
  	}
  	</style>
  </head>
  
  <body>
  	<div id="content">
	    <div class="panel panel-default" style="margin-left:20px;width:200px;height:120px;">
			<div class="panel-heading">
				<h3 class="panel-title">检索用户</h3>
			</div>
			<div class="panel-body">
				<s:form action="findCustomer" method="post">
		    		<s:textfield name="customer.id" class="input" placeholder="请输入用户编号" onfocus="this.placeholder=''" onblur="this.placeholder='请输入用户编号'"/>
		    		<s:submit value="检索" class="btn btn-info" style="width:170px;"/>
		    	</s:form>
			</div>
		</div>
	    <s:if test="%{#session.CustomerNull==null}">
				<s:if test="#session.Customer.id">
					<div class="panel panel-default" style="margin-left:20px;width:800px;height:150px;">
						<div class="panel-heading">
							<h3 class="panel-title">用户信息</h3>
						</div>
						<table class="table">
							<tr>
								<th>编号</th>
								<th>账号</th>
								<th>密码</th>
								<th>联系电话</th>
								<th>生日</th>
								<th>操作</th>
							</tr>
								<tr>
									<s:form action="updateCustomer" method="post">
										<td><s:property value="#session.Customer.id"/></td>
										<td><s:property value="#session.Customer.account"/></td>
										<td>******</td>
										<td><s:textfield name="customer.phone" value="%{#session.Customer.phone}"/></td>
										<td width="200px"><s:date name="#session.Customer.birthday" format="yyyy-MM-dd HH:mm:ss"/></td>
										<td><s:hidden name="customer.id" value="%{#session.Customer.id}"/>
											<s:submit value="确认修改"/>
										</td>
									</s:form>
								</tr>
						</table>
					</div>
				</s:if>
		</s:if>
		
		<s:if test="%{#session.CustomerNull!=null}">
			 <div class="alert alert-warning alert-dismissible" role="alert" style="width:200px;margin-left:20px;"> 
  				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<%out.println(session.getAttribute("CustomerNull")); %>
			</div>
			 <%  
			 session.removeAttribute("CustomerNull"); 
			 %>
		</s:if>
		<a href="/sbeam/Staff/StaffPage.jsp" class="btn btn-info" style="margin-left:20px;width:200px;">返回主页</a>
	</div>
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
