<%@ page import="java.util.List" %>
<%@ page import="sbeam.po.game.GameType" %><%--
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
    <title>UpdateGame</title>
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
            width: 50%;
            height: 70%;
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
        <s:if test="%{(#session.type==1 && #session.indiDeve.check!=1) || (#session.type==2 && #session.teamDeve.check!=1)}">
            <div class="row" style="padding-bottom: 10px">
                <div class="col-md-12" style="text-align: center">
                    <h3>对不起，您的身份还未核验，核验后才能上传游戏，请静待工作人员核验通知，谢谢！</h3>
                </div>
            </div>
        </s:if>
        <s:else>
            <div class="row"><div class="col-md-12" style="text-align: center"><h3>欢迎上传您的新游戏</h3></div></div>
            <div class="row">
                <div class="col-md-offset-2 col-md-8">
                    <form action="gameUpload" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label>游戏名称(一经提交无法修改)</label>
                            <input type="text" class="form-control" name="game.name">
                        </div>
                        <div class="form-group">
                            <label>游戏价格(请慎重考虑，无法修改)</label>
                            <input type="text" class="form-control" name="game.developerPrice">
                        </div>
                        <div class="form-group">
                            <label>请选择游戏类型</label><br>
                            <%
                                List<GameType> types = (List<GameType>)session.getAttribute("types");
                                for(int i=0;i<types.size();i++){
                            %>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="slecttypes" value="<%=types.get(i).getId()%>"><%=types.get(i).getName()%>
                            </label>
                            <%}%>
                        </div>
                        <div class="form-group">
                            <label>选择游戏安装包(.zip/.exe)</label>
                            <input type="file" name="upload">
                        </div>
                        <div class="form-group">
                            <label>选择游戏介绍文件(.txt)</label>
                            <input type="file" name="upload">
                        </div>
                        <em><label>PS.图片将按顺序自动更名为1.png,2.png...</label></em>
                        <div class="form-group">
                            <label>选择游戏截图(.png)该图将作为宣传图片展示！</label>
                            <input type="file" name="upload">
                        </div>
                        <div class="form-group">
                            <label>选择游戏截图(.png)</label>
                            <input type="file" name="upload">
                        </div>
                        <div class="form-group">
                            <label>选择游戏截图(.png)</label>
                            <input type="file" name="upload">
                        </div>
                        <div class="form-group">
                            <label>选择游戏截图(.png)</label>
                            <input type="file" name="upload">
                        </div>
                        <div class="form-group">
                            <label>选择游戏视频文件(.mp4)</label>
                            <input type="file" name="upload">
                        </div>
                        <button type="submit" class="btn btn-default" style="width: 100%">开始上传</button>
                    </form>
                </div>
            </div>
        </s:else>
        <div class="row" style="padding-bottom: 10px"><div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/LoginSuccessGame.jsp" class="btn btn-default">返回</a></div></div>
    </div>
</div>
</div>
</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
