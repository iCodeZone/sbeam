<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>购买成功</title>
</head>

<body>
购买成功 <br>
<s:form action="getMyOrder" method="post">
    <s:hidden name="loginUser.id" value="%{#session.userId}"/>
    <button type="submit" class="btn btn-info">我的订单</button>
</s:form>
</body>
</html>