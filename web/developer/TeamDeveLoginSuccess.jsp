<%--
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
                    <li role="presentation" class="active"><a href="/sbeam/developer/TeamDeveLoginSuccess.jsp">个人资料</a></li>
                    <li role="presentation"><a href="/sbeam/developer/TeamDeveLoginSuccessTeam.jsp">我的团队</a></li>
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
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>ID：</em></strong></div>
            <div class="col-md-6"><s:property value="#session.teamDeve.id" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>团队名称：</em></strong></div>
            <div class="col-md-6"><s:property value="#session.teamDeve.name" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>团队地址：</em></strong></div>
            <div class="col-md-6"><s:property value="#session.teamDeve.address" /></div>
        </div>
        <s:if test="%{#session.teamDeve.registmark!=null && #session.teamDeve.registmark!=''}">
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>注册号：</em></strong></div>
            <div class="col-md-6"><s:property value="#session.teamDeve.registmark" /></div>
        </div>
        </s:if>
        <s:if test="%{#session.teamDeve.website!=null && #session.teamDeve.website!=''}">
            <div class="row" style="margin-top: 2%">
                <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>网站：</em></strong></div>
                <div class="col-md-6"><s:property value="#session.teamDeve.website" /></div>
            </div>
        </s:if>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>银行卡号：</em></strong></div>
            <div class="col-md-6"><s:property value="#session.teamDeve.bankcard" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>审核状态：</em></strong></div>
            <div class="col-md-6"><s:property value="%{#session.teamDeve.check==null?'未审核':#session.teamDeve.check==false?'未通过':'已通过'}" /></div>
        </div>
        <div class="row" style="margin-top: 2%;padding-bottom: 5px">
            <div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/AlterTeamData.jsp">修改个人资料</a></div>
        </div>
    </div>
</div>



新的团队有<s:property value="#session.teamDeve.staffs.size()"/>人<br/>
<s:if test="%{#session.teamDeve.staffs.size()>0}">
    <table>
        <tr><td>队员ID</td><td>队员昵称</td><td>队员姓名</td><td>是否删除队员</td></tr>
    <s:iterator value="#session.teamDeve.staffs">
        <tr>
            <td><s:property value="id"/></td>
            <td><s:property value="account"/></td>
            <td><s:property value="name"/></td>
            <td>
                <s:form action="deleteStaff" method="POST">
                    <s:hidden name="teamDeve.id" value="%{#session.teamDeve.id}"/>
                    <s:hidden name="indiDeve.id" value="%{id}"/>
                    <s:submit value="删除"/>
                </s:form>
            </td>
        </tr>
    </s:iterator>
    </table>
</s:if>
<br/>
邀请新成员加入请输入ID：
<s:form action="teamDeveFindIndi" method="POST">
    <s:textfield name="indiDeve.id"/>
    <s:submit value="确定"/>
</s:form>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
