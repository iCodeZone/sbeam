<%@ page import="sbeam.po.developer.individual.IndividualDeveloper" %><%--
  Created by IntelliJ IDEA.
  User: LXY
  Date: 2018/12/26
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
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
            position: absolute;left: 25%; top: 10%;
            /*height: 60%;*/
            width: 50%;
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
                    <li role="presentation"><a href="/sbeam/developer/IndiDeveLoginSuccess.jsp">个人资料</a></li>
                    <li role="presentation" class="active"><a href="/sbeam/developer/IndiDeveLoginSuccessTeam.jsp">我的团队</a></li>
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
            <s:if test="%{#session.indiDeve.team==null}">
                <div class="row"><div class="col-md-12" style="text-align: center"><h4><strong>您还未加入团队，欲加入请输入团队ID</strong></h4></div></div>
                <div class="row">
                    <div class="col-md-offset-2 col-md-8">
                        <form action="indiDeveFindTeam" method="post">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="请输入团队ID" name="teamDeve.id">
                            </div>
                            <button type="submit" class="btn btn-default" style="width: 100%">查找</button>
                        </form>
                    </div>
                </div>
            </s:if>
            <s:else>
                <div class="row"><div class="col-md-12" style="text-align: center"><h4><strong>您已加入团队</strong></h4></div></div>
                <div class="row"><div class="col-md-6" style="text-align: right"><strong>ID:</strong></div><div class="col-md-6"><s:property value="#session.indiDeve.team.id"/></div></div>
                <div class="row"><div class="col-md-6" style="text-align: right"><strong>名称:</strong></div><div class="col-md-6"><s:property value="#session.indiDeve.team.name"/></div></div>
                <div class="row"><div class="col-md-6" style="text-align: right"><strong>成员:</strong></div>
                    <div class="col-md-4">
                        <table class="table">
                            <tr>
                                <th style="text-align: center"><em>ID</em></th>
                                <th style="text-align: center"><em>昵称</em></th>
                            </tr>
                        <s:iterator value="%{#session.indiDeve.team.staffs}">
                            <tr>
                                <td style="text-align: center"><s:property value="id"/></td>
                                <td style="text-align: center"><s:property value="account"/></td>
                            </tr>
                        </s:iterator>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-offset-4 col-md-4">
                        <form action="quitTeam" method="post">
                            <div class="form-group">
                                <input type="hidden" class="form-control" name="indiDeve.id" value="<%=((IndividualDeveloper)session.getAttribute("indiDeve")).getId()%>">
                            </div>
                            <button type="submit" class="btn btn-default" style="width: 100%">退出团队</button>
                        </form>
                    </div>
                </div>
            </s:else>
        </div>
    </div>
</div>


<%--
<s:if test="%{#session.indiDeve.team==null}">
    您还未加入团队，欲加入请输入团队ID
    <s:form action="indiDeveFindTeam" method="POST">
        <s:textfield name="teamDeve.id"/>
        <s:submit value="搜索"/>
    </s:form>
</s:if>
<s:else>
    您所在的团队名为：
    <s:property value="#session.indiDeve.team.name"/>
    <s:form action="quitTeam" method="POST">
        <s:hidden name="indiDeve.id" value="%{#session.indiDeve.id}"/>
        <s:submit value="退出团队"/>
    </s:form>
</s:else>
<br/>
--%>
</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
