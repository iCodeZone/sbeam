<%@ page import="java.util.List" %>
<%@ page import="sbeam.po.game.Game" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
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
            position: absolute;left: 10%; top: 10%;
            height: 60%;
            width: 80%;
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
        <s:if test="%{#session.tip!=null}">
            <div class="row" style="margin-top: 10px">
                <div class="col-md-12" style="text-align: center"><div class="alert alert-info" role="alert"><s:property value="#session.tip"/></div></div>
                <%
                    session.removeAttribute("tip");
                %>
            </div>
        </s:if>
        <s:if test="%{#session.games.size()==0}">
            <div class="row">
                <div class="col-md-12" style="text-align: center"><strong><h3>对不起，您还未上传过任何一款游戏！</h3></strong></div>
            </div>
        </s:if>
        <s:else>
            <div class="row">
                <div class="col-md-12" style="text-align: center"><strong><h3>以下为您上传过的所有游戏</h3></strong></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <table class="table">
                        <tr>
                            <th><em>游戏id</em></th>
                            <th><em>游戏名</em></th>
                            <th><em>上传日期</em></th>
                            <th><em>审核状态</em></th>
                            <th><em>查看游戏详情</em></th>
                            <th><em>管理相关文件</em></th>
                            <th><em>上传游戏新版本</em></th>
                            <th><em>删除游戏</em></th>
                        </tr>
                        <%
                            List<Game> games = (List<Game>)session.getAttribute("games");
                            int i=0;
                        %>
                        <s:iterator value="#session.games">
                            <tr>
                                <td><s:property value="id"/> </td>
                                <td><s:property value="name"/> </td>
                                <td><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(games.get(i).getUpdatedate())%> </td>
                                <td><!--审核状态-->
                                    <s:if test="%{check==true}">
                                        于<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(games.get(i).getCtime())%>通过审核
                                    </s:if>
                                    <s:else>
                                        <s:if test="%{check==null}">
                                            还未审核，请耐心等待
                                        </s:if>
                                        <s:else>
                                            审核未通过，详情请查看消息！
                                        </s:else>
                                    </s:else>
                                </td>
                                <td><!--查看游戏详情-->
                                    <s:form action="seeGameDetails" method="POST">
                                        <s:hidden name="game.id" value="%{id}"/>
                                        <s:submit value="查看详情" class="btn btn-default"/>
                                    </s:form>
                                </td>
                                <td><!--管理相关文件-->
                                    <s:form action="gameFiles" method="POST">
                                        <s:hidden name="game.id" value="%{id}"/>
                                        <s:submit value="管理相关文件" class="btn btn-default"/>
                                    </s:form>
                                </td>
                                <td><!--上传游戏新版本-->
                                    <s:form action="PreUploadNewVersion" method="POST">
                                        <s:hidden name="game.id" value="%{id}"/>
                                        <s:submit value="上传新版本" class="btn btn-default"/>
                                    </s:form>
                                </td>
                                <td><!--删除游戏-->
                                    <s:form action="delGame" method="POST">
                                        <s:hidden name="game.id" value="%{id}"/>
                                        <s:submit value="删除游戏" class="btn btn-default"/>
                                    </s:form>
                                </td>
                            </tr>
                            <%i++;%>
                        </s:iterator>
                    </table>
                </div>
            </div>
        </s:else>
        <div class="row" style="padding-bottom: 10px">
            <div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/LoginSuccessGame.jsp" class="btn btn-default">返回</a></div>
        </div>
    </div>
</div>
</div>
</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
