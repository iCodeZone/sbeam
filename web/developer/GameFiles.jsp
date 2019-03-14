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
    <title>GameList</title>
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
        <s:if test="#session.tip!=null">
            <div class="row" style="margin-top: 10px">
                <div class="col-md-12" style="text-align: center"><div class="alert alert-info" role="alert"><s:property value="#session.tip"/></div></div>
                <%
                    session.removeAttribute("tip");
                %>
            </div>
        </s:if>
        <s:if test="%{#session.files.size!=0}">
            <div class="row">
                <div class="col-md-12" style="text-align: center"><h3><strong>游戏<s:property value="#session.game.name"/>的文件列表如下</strong></h3></div>
            </div>
            <s:iterator value="#session.files" status="st" >
                <div class="row">
                    <div class="col-md-offset-2 col-md-4" style="text-align: center">
                        <s:property value="getName()"/>
                    </div>
                    <div class="col-md-4" style="text-align: center">
                        <s:form action="delGameFile" method="POST">
                            <s:hidden name="index" value="%{#st.index}"/>
                            <s:submit value="点击删除文件" class="btn btn-default"/>
                        </s:form>
                    </div>
                </div>
            </s:iterator>
        </s:if>
        <s:else>
            <div class="row">
                <div class="col-md-12" style="text-align: center"><h3><strong>该游戏并没有任何相关文件存在哦！</strong></h3></div>
            </div>
        </s:else>
        <div class="row">
            <div class="col-md-12"><hr/></div>
        </div>
        <div class="row">
            <div class="col-md-12" style="text-align: center"><em>您可以选择一个新的文件上传，可以是视频，可以是描述文件或者截图</em></div>
        </div>
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <form action="uploadNewGameFile" method="POST" enctype="multipart/form-data" class="form">
                    <div class="form-group">
                        <input type="hidden" name="game.id" value="<%=((Game)session.getAttribute("game")).getId()%>">
                    </div>
                    <div class="form-group">
                        <input type="file" name="upload">
                    </div>
                    <button type="submit" class="btn btn-default" style="width: 100%">上传</button>
                </form>
            </div>
        </div>
        <div class="row" style="padding-bottom: 10px">
            <div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/GameList.jsp" class="btn btn-default">返回</a></div>
        </div>
    </div>
</div>
</div>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
