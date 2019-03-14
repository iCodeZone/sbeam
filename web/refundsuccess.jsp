<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>退款成功</title>
    <s:form action="getMyOrder" method="post">
        <s:hidden name="loginUser.id" value="%{#session.userId}"/>
        <button type="submit" class="btn btn-info">我的订单</button>
    </s:form>

</head>

<body>
<b>退款成功<br>
</body>
</html>
