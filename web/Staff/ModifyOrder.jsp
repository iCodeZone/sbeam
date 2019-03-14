<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="sbeam.po.game.Game" %>
<%@ page import="sbeam.po.customer.Customer" %>
<%@ page import="sbeam.po.order.Order" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>修改订单状态</title>
    
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
				<h3 class="panel-title">检索订单</h3>
			</div>
			<div class="panel-body" id="newStaff">
				<s:form action="findOrder" method="post">
		    		<s:textfield name="order.id" class="input" value="%{id}" placeholder="请输入订单号" onfocus="this.placeholder=''" onblur="this.placeholder='请输入订单号'"/>
		    		<s:submit value="检索" class="btn btn-info" style="width:170px;"/>
		    	</s:form>
			</div>
		</div>
	    <s:if test="%{#session.OrderNull==null}">
		    <s:if test="#session.Order.id">
		    	<div class="panel panel-default" style="margin-left:20px;width:800px;height:150px;">
					<div class="panel-heading">
						<h3 class="panel-title">订单信息</h3>
					</div>
				    <table class="table" style="text-align:center;">
						<tr>
							<th>订单号</th>
							<th>客户</th>
							<th>购买商品名称</th>
							<th>付款金额</th>
							<th>订单生成时间</th>
							<th>当前订单状态</th>
							<th>操作</th>
						</tr>
							<tr>
								<td><s:property value="#session.Order.id"/></td>
								<td><s:property value="#session.Order.customer.account"/></td>
								<td width="100px"><s:property value="#session.Order.game.name"/></td>
								<td><s:property value="#session.Order.pay"/></td>
								<td width="200px"><s:date name="#session.Order.date" format="yyyy-MM-dd HH:mm:ss"/></td>
								<s:form action="modifyOrder" method="post">
									<td><s:select name="order.state" list="#{0:'待付款',1:'已退款',2:'已付款'}" value="%{#session.Order.state}" style="height:25px;"/></td>
									<td><s:hidden name="order.id" value="%{#session.Order.id}"/>
										<s:submit value="确认修改"/>
									</td>
								</s:form>
							</tr>
					</table>
				</div>
			</s:if>
		</s:if>
		
		<s:if test="%{#session.OrderNull!=null}">
			 <div class="alert alert-warning alert-dismissible" role="alert" style="width:200px;margin-left:20px;"> 
  				<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<%out.println(session.getAttribute("OrderNull")); %>
			</div>
			 <%  
			 session.removeAttribute("OrderNull"); 
			 %>
		</s:if>
		<a href="/sbeam/Staff/StaffPage.jsp" class="btn btn-info" style="margin-left:20px;width:200px;">返回主页</a>
	</div>
	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
