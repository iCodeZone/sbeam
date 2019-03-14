<%--
  Created by IntelliJ IDEA.
  User: LXY
  Date: 2018/12/26
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=gb2312" language="java" %>
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
            height: 70%;
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
                    <li role="presentation" class="active"><a href="/sbeam/developer/IndiDeveLoginSuccess.jsp">��������</a></li>
                    <li role="presentation"><a href="/sbeam/developer/IndiDeveLoginSuccessTeam.jsp">�ҵ��Ŷ�</a></li>
                    <li role="presentation"><a href="getMessagesAgain">�ҵ���Ϣ(<s:property value="%{#session.messages==null?0:#session.messages.size()}"/>��)</a></li>
                    <li role="presentation"><a href="/sbeam/developer/LoginSuccessGame.jsp">�ҵ���Ϸ</a></li>
                    <li role="presentation"><a href="/sbeam/developer/LoginSuccessProblem.jsp">����</a></li>
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
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>ID��</em></strong></div>
            <div class="col-md-6"><s:property value="#session.indiDeve.id" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>�ǳƣ�</em></strong></div>
            <div class="col-md-6"><s:property value="#session.indiDeve.account" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>��ʵ������</em></strong></div>
            <div class="col-md-6"><s:property value="#session.indiDeve.name" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>���֤�ţ�</em></strong></div>
            <div class="col-md-6"><s:property value="#session.indiDeve.idnumber" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>���п��ţ�</em></strong></div>
            <div class="col-md-6"><s:property value="#session.indiDeve.bankcard" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-2 col-md-offset-4" style="text-align: right"><strong><em>���״̬��</em></strong></div>
            <div class="col-md-6"><s:property value="%{#session.indiDeve.check==null?'δ���':#session.indiDeve.check==false?'δͨ��':'��ͨ��'}" /></div>
        </div>
        <div class="row" style="margin-top: 2%">
            <div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/AlterIndiData.jsp">�޸ĸ�������</a></div>
        </div>
    </div>
</div>
</div>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
