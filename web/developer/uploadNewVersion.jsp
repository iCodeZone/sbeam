<%@ page import="sbeam.po.game.Game" %><%--
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
    <title>UploadNewVersion</title>
    <s:head theme="xhtml"/>
    <sx:head parseContent="true" extraLocales="utf-8"/>
    <link rel="stylesheet" href="/sbeam/developer/lib/bootstrap.css"/>
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 120%;
            /*overflow: hidden;*/
            background: #111;
        }
        #main{
            position: absolute;left: 25%; top: 10%;
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
        <div class="row"><div class="col-md-12" style="text-align: center"><h3>上传新版本</h3></div></div>
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <form action="uploadNewVersion" method="post" enctype="multipart/form-data" class="form">
                    <div class="form-group">
                        <input type="hidden" class="form-control" name="game.id" value="<%=((Game)request.getAttribute("game")).getId()%>">
                    </div>
                    <div class="form-group">
                        <label>请选择安装包</label>
                        <input type="file" name="upload">
                    </div>
                    <button type="submit" class="btn btn-default" style="width: 100%">上传</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
