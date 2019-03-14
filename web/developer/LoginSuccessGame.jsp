<%--
  Created by IntelliJ IDEA.
  User: LXY
  Date: 2019/1/6
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<html>
<head>
    <title>MyGame</title>
    <s:head theme="xhtml"/>
    <sx:head parseContent="true" extraLocales="utf-8"/>
    <link rel="stylesheet" href="lib/bootstrap.css"/>
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
            position: absolute;left: 30%; top: 10%;
            /*height: 40%;*/
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
        <div class="row" style="margin-top: 5%">
            <div class="col-md-12">
                <ul class="nav nav-pills">
                    <li role="presentation"><a href="<%=((int)session.getAttribute("type"))==1?"/sbeam/developer/IndiDeveLoginSuccess.jsp":"/sbeam/developer/TeamDeveLoginSuccess.jsp"%>">个人资料</a></li>
                    <li role="presentation"><a href="<%=((int)session.getAttribute("type"))==1?"/sbeam/developer/IndiDeveLoginSuccessTeam.jsp":"/sbeam/developer/TeamDeveLoginSuccessTeam.jsp"%>">我的团队</a></li>
                    <li role="presentation"><a href="getMessagesAgain">我的消息(<s:property value="%{#session.messages==null?0:#session.messages.size()}"/>条)</a></li>
                    <li role="presentation" class="active"><a href="/sbeam/developer/LoginSuccessGame.jsp">我的游戏</a></li>
                    <li role="presentation"><a href="/sbeam/developer/LoginSuccessProblem.jsp">工单</a></li>
                </ul>
            </div>
        </div>
        <div class="row" style="margin-top: 10px">
            <div class="col-md-6">
                <form action="getAllType" method="post">
                    <div class="form-group">
                        <input type="hidden" class="form-control" name="type" value="<%=(int)session.getAttribute("type")%>">
                    </div>
                    <button type="submit" class="btn btn-default" style="width: 100%">我要上传游戏</button>
                </form>
            </div>
            <div class="col-md-6">
                <form action="gameList" method="post">
                    <div class="form-group">
                        <input type="hidden" class="form-control" name="type" value="<%=(int)session.getAttribute("type")%>">
                    </div>
                    <button type="submit" class="btn btn-default" style="width: 100%">查看已上传的游戏</button>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12"><hr/></div>
        </div>
        <div class="row"><div class="col-md-12" style="text-align: center"><h3>查看过去时间的总收入</h3></div></div>
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <form action="getAllGamesSaleStatus" method="post">
                    <div class="form-group">
                        <input type="hidden" class="form-control" name="type" value="1">
                    </div>
                    <div class="form-group" style="text-align: center">
                    <label class="radio-inline">
                        <input type="radio" name="days" id="inlineRadio1" value="30"> 30天
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="days" id="inlineRadio2" value="90"> 90天
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="days" id="inlineRadio3" value="365"> 365天
                    </label>
                    </div>
                    <button type="submit" class="btn btn-default" style="width: 100%">查询</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script src="lib/background.js"/>
<script src="lib/bootstrap.js"></script>
</html>
