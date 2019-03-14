<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>登录成功</title>
    <link type="text/css" rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="css/zzsc.css">

    <style>
        #datouwang{
            z-index: -1;
        }
        #welcome{
            position: absolute;
            left: 800px;
            top : 0px;
        }
    </style>

</head>
<body>

<div id="datouwang" class="container"></div>
<div id="welcome">
    <h1 id="point"><font color="#6495ed">登录成功,欢迎您!<s:property  value="#session.user.account"/></font></h1>
    <table class="table table-condensed">
        <tr>
            <td>
                <font color="#6495ed"> 用户编号：<s:property  value="#session.user.id"/></font>
            </td>
        </tr>
        <tr>
            <td>
                <font color="#6495ed"> 电话号码：<s:property  value="#session.user.phone"/></font>
            </td>
        </tr>
        <tr>
            <td align="center">
                <a class="btn btn-info" href="update.jsp" role="button">修改个人信息</a>
            </td>
            <td align="center">
                <s:form action="getAllGame" method="post">
                    <button type="submit" class="btn btn-info">进入游戏商城</button>
                </s:form>
            </td>
        </tr>
        <tr>
            <td align="center">
                <s:form action="getCollection" method="post">
                    <s:hidden name="loginUser.id" value="%{#session.userId}"/>
                    <button type="submit" class="btn btn-info">我的收藏</button>
                </s:form>
            </td>
            <td align="center">
                <s:form action="getEvaluate" method="post">
                    <s:hidden name="loginUser.id" value="%{#session.userId}"/>
                    <button type="submit" class="btn btn-info">我的评价</button>
                </s:form>
            </td>
        </tr>
        <tr>
            <td align="center">
                <s:form action="getMyOrder" method="post">
                    <s:hidden name="loginUser.id" value="%{#session.userId}"/>
                    <button type="submit" class="btn btn-info">我的订单</button>
                </s:form>
            </td>
            <td align="center">
                <s:form action="getMyGame" method="post">
                    <s:hidden name="loginUser.id" value="%{#session.userId}"/>
                    <button type="submit" class="btn btn-info">我的游戏</button>
                </s:form>
            </td>
        </tr>
        <tr>
            <td align="center">
                <a class="btn btn-info" href="sendmessage.jsp" role="button">发送工单</a>
            </td>
            <td align="center">
                <s:form action="playtickets" method="post">
                    <button type="submit" class="btn btn-info">查看工单</button>
                </s:form>
            </td>
        </tr>
    </table>

</div>

<script src='js/jquery.min.js'></script>
<script src="js/zzsc.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.js"></script>

<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
</div>
</body>
</html>