<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>操作主界面</title>
    
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
  </head>
  <style>
  	body{
  		display:flex;
  		justify-content:center;
  	}
  	#header{
  		position:absolute;
  		top:0;
  		width:100%;
  		height:50px;
  		text-align:center;
  		font-size:24;
  	}
  	#main{
  		margin-top:50px;
  		width:800px;
  		height:500px;
  		box-shadow:2px 1px 10px 1px;
  		background-color:rgba(246,246,247,0.85);
  		border-radius:5px;
  		position:absolute;
  	}
  	#content{
  		margin-top:50px;
  		position:absolute;
  		
  	}
  	a{
  		width:150px;
  		height:150px;
  		text-align:center;
  	}
  	a > font{
  		line-height:140px;
  		font-size:16;
  	}
  	
  </style>
  <body>
  <canvas id="starts" style="position:absolute;z-index:-1;"></canvas>
  	<div id="main">
	  	<div id="header">sbeam商城后台</div>
	  	<div style="display:flex;justify-content:center;">
	  	<div id="content">
		  <s:if test="#session.staff.stype==0">
		    <h2>客服<s:property value="#session.staff.sid "/>,准备服务</h2>
		    <table>
			    <tr>
				    <td><a href="findTickets" class="btn btn-primary"><font>查看未处理工单</font></a></td>
				    <td></td>
				    <td><a href="/sbeam/Staff/ModifyOrder.jsp" class="btn btn-info"><font>修改订单状态</font></a></td>
				    <td></td>
				    <td><a href="/sbeam/Staff/ModifyCustomer.jsp" class="btn btn-warning"><font>更新用户信息</font></a></td>
				</tr>
				<tr>
					<td></td>
				    <td><a href="/sbeam/Staff/ModifyDeveloper.jsp" class="btn btn-success"><font>更新开发者信息</font></a></td>
				    <td></td>
				    <td><a href="/sbeam/AdminStaffLogin.jsp" class="btn btn-danger"><font>登出</font></a></td>
				    <td></td>
				</tr>
		    </table>
	      </s:if>
	      
	      <s:if test="#session.staff.stype==1">
		    <h2>审核员<s:property value="#session.staff.sid "/>,准备服务</h2>
		    <table>
		    	<tr>
					<td><a href="checkIdeveloper" class="btn btn-primary"><font>审核个体开发者</font></a></td>
					<td></td>
		    		<td><a href="checkTdeveloper" class="btn btn-info"><font>审核团体开发者</font></a></td>
		    		<td></td>
		    	</tr>
		    	<tr>
		    		<td></td>
				    <td><a href="checkGame" class="btn btn-warning"><font>审核游戏</font></a></td>
				    <td></td>
				    <td><a href="/sbeam/AdminStaffLogin.jsp" class="btn btn-success"><font>登出</font></a></td>
		    	</tr>
		    </table>
	      </s:if>
	      </div>
	      </div>
     </div>
    <script src="/sbeam/Source/jquery-3.3.1.js"></script>
    <script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script  src="/sbeam/Source/AdminStaffLogin/cosmos_canvas.js"></script>
  </body>
</html>
