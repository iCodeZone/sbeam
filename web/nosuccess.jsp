<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: zhu
  Date: 2019/1/9
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>取消成功</title>
</head>
<body>
取消成功
<s:form action="getMyOrder" method="post">
    <s:hidden name="loginUser.id" value="%{#session.userId}"/>
    <button type="submit" class="btn btn-info">我的订单</button>
</s:form>
</body>
</html>
