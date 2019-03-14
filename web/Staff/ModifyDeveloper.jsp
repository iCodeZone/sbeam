<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="sbeam.po.game.Game" %>
<%@ page import="sbeam.po.customer.Customer" %>
<%@ page import="sbeam.po.order.Order" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>更新开发者信息</title>
    
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
				<h3 class="panel-title">检索个人开发者</h3>
			</div>
			<div class="panel-body">
				<s:form action="findIDeveloper" method="post">
		    		<s:textfield name="individualDeveloper.id" class="input" placeholder="请输入开发者编号" onfocus="this.placeholder=''" onblur="this.placeholder='请输入开发者编号'"/>
		    		<s:submit value="检索" class="btn btn-info" style="width:170px;"/>
		    	</s:form>
			</div>
		</div>
	    <s:if test="%{#session.individualDeveloperNull==null}">
	    	<s:if test="#session.IndividualDeveloper.id">
		    	<div class="panel panel-default" style="margin-left:20px;width:900px;height:150px;">
					<div class="panel-heading">
						<h3 class="panel-title">个人开发者信息</h3>
					</div>
				    <table class="table">
						<tr>
							<th>编号</th>
							<th>账号</th>
							<th>密码</th>
							<th>用户名</th>
							<th>身份证号</th>
							<th>所属团队</th>
							<th>银行卡号</th>
							<th>操作</th>
						</tr>
							<tr>
								<s:form action="updateIDeveloper" method="post">
								<td><s:property value="#session.IndividualDeveloper.id"/></td>
								<td><s:property value="#session.IndividualDeveloper.account"/></td>
								<td>******</td>
								<td><s:property value="#session.IndividualDeveloper.name"/></td>
								<td width="180px"><s:textfield class="input" name="individualDeveloper.idnumber" value="%{#session.IndividualDeveloper.idnumber}" style="width:180px;"/></td>
								<td>
									<s:if test="%{#session.IndividualDeveloper.team==null}">
										无
									</s:if>
									<s:if test="%{#session.IndividualDeveloper.team!=null}">
										<s:property value="#session.IndividualDeveloper.team.name" />
									</s:if>
								</td>
								<td width="180px"><s:textfield class="input" name="individualDeveloper.bankcard" value="%{#session.IndividualDeveloper.bankcard}" style="width:180px;"/></td>
									<td><s:hidden name="individualDeveloper.id" value="%{#session.IndividualDeveloper.id}"/>
										<s:submit class="btn btn-warning" value="确认修改"/>
									</td>
								</s:form>
							</tr>
					</table>
				</div>
			</s:if>
		</s:if>
		
		<s:if test="%{#session.individualDeveloperNull!=null}">
			 <div class="alert alert-warning alert-dismissible" role="alert" style="width:200px;margin-left:20px;"> 
  				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<%out.println(session.getAttribute("individualDeveloperNull")); %>
			</div>
			 <%  
			 session.removeAttribute("individualDeveloperNull"); 
			 %>
		</s:if>
		<a href="/sbeam/Staff/StaffPage.jsp" class="btn btn-info" style="margin-left:20px;width:200px;">返回主页</a>
	</div>
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
