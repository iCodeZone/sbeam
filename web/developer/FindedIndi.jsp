<%@ page import="sbeam.po.developer.individual.IndividualDeveloper" %>
<%@ page import="sbeam.po.developer.team.TeamDeveloper" %><%--
  Created by IntelliJ IDEA.
  User: LXY
  Date: 2018/12/26
  Time: 13:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<html>
<head>
    <title>Indi</title>
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
            position: absolute;left: 30%; top: 20%;
            height: 40%;
            width: 40%;
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
<div id="main">
    <div class="container-fluid">
        <s:if test="%{#session.indiDeve==null}">
            <div class="row" style="margin-top: 5%"><div class="cok-md-12" style="text-align: center"><h3>对不起，查无此人，请查证后重试</h3></div></div>
            <div class="row" style="margin-top: 5%"><div class="cok-md-12" style="text-align: center"><em><a href="/sbeam/developer/TeamDeveLoginSuccessTeam.jsp">点击返回</a></em></div></div>
        </s:if>
        <s:else>
            <div class="row"><div class="cok-md-12" style="text-align: center"><h3>找到以下个人</h3></div></div>
            <div class="row"><div class="col-md-offset-2 col-md-4" style="text-align: center">开发者编号</div><div class="col-md-4" style="text-align: center">开发者昵称</div></div>
            <div class="row"><div class="col-md-offset-2 col-md-4" style="text-align: center"><s:property value="#session.indiDeve.id"/></div><div class="col-md-4" style="text-align: center"><s:property value="#session.indiDeve.account"/></div></div>
            <div class="row" style="margin-top: 5%"><div class="col-md-12" style="text-align: center"><em>是否邀请TA？</em></div></div>
            <div class="row">
                <div class="col-md-offset-2 col-md-4" style="text-align: center">
                    <form action="teamDeveInviteIndi" method="post">
                        <div class="form-group">
                            <input type="hidden" class="form-control" name="indiDeve.id" value="<%=((IndividualDeveloper)session.getAttribute("indiDeve")).getId()%>">
                        </div>
                        <div class="form-group">
                            <input type="hidden" class="form-control" name="teamDeve.name" value="<%=((TeamDeveloper)session.getAttribute("teamDeve")).getName()%>">
                        </div>
                        <div class="form-group">
                            <input type="hidden" class="form-control" name="teamDeve.id" value="<%=((TeamDeveloper)session.getAttribute("teamDeve")).getId()%>">
                        </div>
                        <button type="submit" class="btn btn-default" style="width: 100%">邀请</button>
                    </form>
                </div>
                <div class="col-md-4" style="text-align: center">
                    <a class="btn btn-default" href="/sbeam/developer/TeamDeveLoginSuccessTeam.jsp" style="width: 100%;margin-top: 15px;">不邀请</a>
                </div>
            </div>
        </s:else>
    </div>
</div>
</div>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
