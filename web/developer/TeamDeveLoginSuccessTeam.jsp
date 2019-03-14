<%--
  Created by IntelliJ IDEA.
  User: LXY
  Date: 2019/1/7
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<html>
<head>
    <title>MyTeam</title>
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
            position: absolute;left: 25%; top: 10%;
            height: 60%;
            width: 50%;
            border-radius:5px;
            background-color:rgba(246,246,247,0.85);
            box-shadow: 3px 3px 10px grey;
            overflow-y: auto;
        }
    </style>
</head>
<body>

<canvas id="world" style="z-index:-1;height: 100%;width: 100%;">
</canvas>
<div style="overflow: hidden">
<div  id="main">
    <div class="container-fluid">
        <div class="row" style="margin-top: 5%">
            <div class="col-md-12">
                <ul class="nav nav-pills">
                    <li role="presentation"><a href="/sbeam/developer/TeamDeveLoginSuccess.jsp">个人资料</a></li>
                    <li role="presentation" class="active"><a href="/sbeam/developer/TeamDeveLoginSuccessTeam.jsp">我的团队</a></li>
                    <li role="presentation"><a href="getMessagesAgain">我的消息(<s:property value="%{#session.messages==null?0:#session.messages.size()}"/>条)</a></li>
                    <li role="presentation"><a href="/sbeam/developer/LoginSuccessGame.jsp">我的游戏</a></li>
                    <li role="presentation"><a href="/sbeam/developer/LoginSuccessProblem.jsp">工单</a></li>
                </ul>
            </div>
        </div>
        <div class="row" style="margin-top: 2%;height:40px;">
            <s:if test="%{#session.tip!=null}">
                <div class="col-md-12"><div class="alert alert-info" role="alert"><s:property value="#session.tip"/> </div></div>
                <%
                    session.removeAttribute("tip");
                %>
            </s:if>
        </div>
        <div class="row">
            <div class="col-md-12" style="text-align: center">
                <h3>团队共有<s:property value="#session.teamDeve.staffs.size()"/>人</h3>
            </div>
        </div>
        <s:if test="%{#session.teamDeve.staffs.size()>0}">
            <div class="row">
                <div class="col-md-12">
                    <table class="table">
                        <tr><th>队员ID</th><th>队员昵称</th><th>队员姓名</th><th>是否删除队员</th></tr>
                        <s:iterator value="#session.teamDeve.staffs">
                            <tr>
                                <td><s:property value="id"/></td>
                                <td><s:property value="account"/></td>
                                <td><s:property value="name"/></td>
                                <td>
                                    <s:form action="deleteStaff" method="POST">
                                        <s:hidden name="teamDeve.id" value="%{#session.teamDeve.id}"/>
                                        <s:hidden name="indiDeve.id" value="%{id}"/>
                                        <s:submit value="删除" class="btn btn-default"/>
                                    </s:form>
                                </td>
                            </tr>
                        </s:iterator>
                    </table>
                </div>
            </div>
        </s:if>
        <div class="row"><div class="col-md-12" style="text-align: center">邀请新成员在此输入ID</div></div>
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <form action="teamDeveFindIndi" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="请输入个人ID" name="indiDeve.id">
                    </div>
                    <button type="submit" class="btn btn-default" style="width: 100%">查找</button>
                </form>
            </div>
        </div>
    </div>
</div>
</div>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
