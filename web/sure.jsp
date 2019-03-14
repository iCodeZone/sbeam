<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>确认界面</title>
</head>

<body>

是否确认购买
<s:form action="yes" method="post">
    <s:submit name="submit" value="确定"/>
</s:form>
<a href="buy.jsp">取消</a>
</body>
</html>
