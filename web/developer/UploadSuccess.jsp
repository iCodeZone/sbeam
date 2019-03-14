<%--
  Created by IntelliJ IDEA.
  User: LXY
  Date: 2018/12/26
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<html>
<head>
    <title>UploadSuccess</title>
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
        <div class="row" style="margin-top: 10px">
            <div class="col-md-12" style="text-align: center"><div class="alert alert-info" role="alert"><s:property value="#session.tip"/></div></div>
            <%
                session.removeAttribute("tip");
            %>
        </div>
        <div class="row" style="margin-top: 5%">
            <div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/LoginSuccessGame.jsp">����</a></div>
        </div>
    </div>
</div>
</body>
<script src="lib/background.js"/>
<script src="lib/bootstrap.js"></script>
</html>
