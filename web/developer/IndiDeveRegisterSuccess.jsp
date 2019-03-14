<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<html>
<head>
    <title>LoginSuccess</title>
    <s:head theme="xhtml"/>
    <sx:head parseContent="true" extraLocales="utf-8"/>
    <link rel="stylesheet" href="/sbeam/developer/lib/bootstrap.css"/>
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: #111;
        }
        #main{
            position: absolute;left: 30%; top: 25%;
            height: 36%;
            width: 40%;
            border-radius:5px;
            background-color:rgba(246,246,247,0.85);
            box-shadow: 3px 3px 10px grey;
        }
    </style>
</head>
<body>

<canvas id="world" style="z-index:-1;height: 100%;width: 100%;">
</canvas>
<div  id="main">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12" style="text-align: center"><strong><h4>恭喜您，注册成功！</h4></strong></div>
        </div>
        <div class="row" style="margin-top: 5%">
            <div class="col-md-12" style="text-align: center">您的ID是：<s:property value="#session.indiDeve.id" /></div>
        </div>
        <div class="row" style="margin-top: 5%">
            <div class="col-md-12" style="text-align: center">您的昵称是：<s:property value="#session.indiDeve.account" /></div>
        </div>
        <div class="row" style="margin-top: 5%">
            <div class="col-md-12" style="text-align: center"><a href="indiDeveLogin.jsp">点此进入登录界面</a></div>
        </div>
    </div>
</div>

<%--<h1>恭喜你，注册成功！</h1>
您的ID是：<s:property value="#session.indiDeve.id" /><br/>
您的昵称是：<s:property value="#session.indiDeve.account" /><br/>
PS.请牢记您的ID，登录请使用ID登录！
<a href="indiDeveLogin.jsp">点此进入登录界面</a>--%>
</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
