<%@ page import="sbeam.po.developer.team.TeamDeveloper" %><%--
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
    <title>AlterIndiData</title>
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
            position: absolute;left: 30%; top: 10%;
            height: 75%;
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
            <div class="col-md-12" style="text-align: center"><h3>请修改您需要修改的字段</h3></div>
        </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-1">
                <form action="alterTeamData" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-5 control-label">团队ID:</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="teamDeve.id" value="<%=((TeamDeveloper)session.getAttribute("teamDeve")).getId()%>" readonly style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">团队名称:</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="teamDeve.name" value="<%=((TeamDeveloper)session.getAttribute("teamDeve")).getName()%>" readonly style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">密码:</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" name="teamDeve.password" value="<%=((TeamDeveloper)session.getAttribute("teamDeve")).getPassword()%>" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">地址:</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="teamDeve.address" value="<%=((TeamDeveloper)session.getAttribute("teamDeve")).getAddress()%>" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">网站:</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="teamDeve.website" value="<%=((TeamDeveloper)session.getAttribute("teamDeve")).getWebsite()%>"  style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">银行卡号:</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="teamDeve.bankcard" value="<%=((TeamDeveloper)session.getAttribute("teamDeve")).getBankcard()%>" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-6">
                            <button type="submit" class="btn btn-default">提交</button>
                        </div>
                        <div class="col-sm-3">
                            <button type="reset" class="btn btn-default">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-offset-2 col-md-8" style="text-align: center">
                <s:if test="%{#session.tip!=null}">
                    <div class="col-md-12"><div class="alert alert-info" role="alert"><s:property value="#session.tip"/> </div></div>
                    <%
                        session.removeAttribute("tip");
                    %>
                </s:if>
            </div>
            <div class="col-md-2" style="text-align: right"><a href="/sbeam/developer/TeamDeveLoginSuccess.jsp">返回</a></div>
        </div>
    </div>
</div>
</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
