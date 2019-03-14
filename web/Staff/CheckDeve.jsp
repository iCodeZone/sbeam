<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>开发者信息审核</title>
    
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
  		#icont{
  		
  		}
  		#tcont{
  		
  		}
  		
  	</style>
  </head>
  
  <body>
  	<div id="content">
  	<s:if test="#session.developerType==0">
	  	<s:if test="#session.IDevelopers.size()!=0">
	  	<div id="icont" class="panel panel-default" style="height:300px;width:900px;overflow-y:auto;">
		    <div class="panel-heading" style="text-align:center;">
				  <h4>个人开发者信息</h4>
			</div>
		    <table class="table" style="text-align:center;">
				<tr>
					<th>个体开发者ID</th>
					<th>账号</th>
					<th>密码</th>
					<th>用户名</th>
					<th>身份证号</th>
					<th>所属团队</th>
					<th>银行卡账号</th>
					<th>审核</th>
				</tr>
				<s:iterator value="#session.IDevelopers" >
					<tr>
						<td><s:property value="id"/></td>
						<td><s:property value="account"/></td>
						<td><s:property value="password"/></td>
						<td><s:property value="name"/></td>
						<td><s:property value="idnumber"/></td>
						<td>
							<s:if test="team==null">
								无
							</s:if>
							<s:else>
								<s:property value="team"/>
							</s:else>
						</td>
						<td><s:property value="bankcard"/></td>
						<td width="150px">
							<div style="display:flex;align-items:center;">
								<s:form action="checkIDeveSuccess" method="post">
									<s:hidden name="individualDeveloper.id" value="%{id}" />
									<s:submit class="btn btn-success" value="审核通过" />
								</s:form>
		
								<s:form action="checkIDeveFail" method="post">
									<s:hidden name="individualDeveloper.id" value="%{id}" />
									<s:submit class="btn btn-danger" value="审核失败" />
								</s:form>
							</div>
						</td>
					</tr>
				</s:iterator>
				<tr>
			</table>
		   </div>
		</s:if>
		<s:else>
			<h3>没有收到个体开发者注册信息！</h3>
		</s:else>
	</s:if>
	<s:if test="#session.developerType==1">
		<s:if test="#session.TDevelopers.size()!=0">
		<div id="tcont" class="panel panel-default" style="height:300px;width:900px;overflow-y:auto;">
		    <div class="panel-heading" style="text-align:center;">
				  <h4>团队开发者信息</h4>
			</div>
		    <table class="table" style="text-align:center;">
				<tr>
					<th>团队开发者ID</th>
					<th>团队名称</th>
					<th>密码</th>
					<th>团队地址</th>
					<th>公司注册编号</th>
					<th>公司网站</th>	
					<th>银行卡号</th>
					<th>审核</th>
				</tr>
				<s:iterator value="#session.TDevelopers" >
					<tr>
						<td><s:property value="id"/></td>
						<td><s:property value="name"/></td>
						<td><s:property value="password"/></td>
						<td><s:property value="address"/></td>
						<td><s:property value="registmark"/></td>
						<td><s:property value="website"/></td>
						<td><s:property value="bankcard"/></td>
						<td width="150px">
							<div style="display:flex;align-items:center;">
								<s:form action="checkTDeveSuccess" method="post">
									<s:hidden name="teamDeveloper.id" value="%{id}" />
									<s:submit class="btn btn-success" value="审核通过" />
								</s:form>
		
								<s:form action="checkTDeveFail" method="post">
									<s:hidden name="teamDeveloper.id" value="%{id}" />
									<s:submit class="btn btn-danger" value="审核失败" />
								</s:form>
							</div>
						</td>
						
					</tr>
				</s:iterator>
				<tr>
			</table>
		</div>
		</s:if>
		<s:else>
			<div class="alert alert-warning alert-dismissible" role="alert">
  				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 				没有收到团队开发者注册信息！
			</div>
		</s:else>
	</s:if>
	<a href="/sbeam/Staff/StaffPage.jsp" class="btn btn-info">返回主页</a>
	</div>
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
    <script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
