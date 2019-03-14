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
    <title>MyProblem</title>
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
                    <li role="presentation"><a href="/sbeam/developer/LoginSuccessGame.jsp">我的游戏</a></li>
                    <li role="presentation" class="active"><a href="/sbeam/developer/LoginSuccessProblem.jsp">工单</a></li>
                </ul>
            </div>
        </div>
        <s:if test="#session.tip!=null">
            <div class="row" style="margin-top: 5px"><div class="col-md-12" style="text-align: center"><div class="alert alert-info" role="alert"><s:property value="#session.tip"/> </div></div></div>
            <%
                session.removeAttribute("tip");
            %>
        </s:if>
        <div class="row" style="margin-top: 10px">
            <div class="col-md-6" style="margin-top: 15px">
                <a href="/sbeam/developer/Problem.jsp" class="btn btn-default">有问题？不要犹豫，来发工单吧！</a>
            </div>
            <div class="col-md-6">
                <form action="getAllProblem" method="post">
                    <div class="form-group">
                        <input type="hidden" class="form-control" name="type" value="<%=(int)session.getAttribute("type")%>">
                    </div>
                    <button type="submit" class="btn btn-default" style="width: 100%">查看所有工单</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script src="lib/background.js"/>
<script src="lib/bootstrap.js"></script>
</html>
