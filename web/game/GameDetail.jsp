<%@ page language="java" import="org.apache.struts2.ServletActionContext" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="sbeam.po.game.Game" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>游戏详情</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <link rel="stylesheet" href="/sbeam/Source/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="/sbeam/Source/bootstrap-3.3.7-dist/css/bootstrap.min.css">
</head>
<style>
    body {
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    #main {
        width: 700px;
        height: 500px;
        box-shadow: 2px 1px 10px 1px;
        background-color: rgba(246, 246, 247, 0.85);
        border-radius: 5px;
        position: absolute;
    }

    #content {
        display: flex;
        margin-top: 350px;
    }

    #label {
        width: 40px;
        border-radius: 5px;
        color: rgb(37, 191, 241);
        text-align: center;
        background-color: rgb(234, 248, 251);
    }

    #img {
        border-radius: 5px;
        width: 700px;
        height: 350px;
        margin: 0 auto;
        position: absolute;
        top: 0;
    }

    #back a {
        width: 700px;
        position: absolute;
        bottom: 0;
    }
</style>
<body>
<%
    //得到图片的地址
    Game game = (Game) session.getAttribute("theGame");
    String address = game.getDir();
    String s = "/sbeam";
    address = s + address;
    address += "/pictures/";
    //用来获取文件夹中有几张图片
    String realPath = ServletActionContext.getServletContext().getRealPath(game.getDir() + "/pictures");
    File text = new File(realPath);
    int num = 0;
    String[] pic = text.list();
    if (text.exists()) {
        num = text.listFiles().length;
    }
    for (int i = 0; i < num; i++) {
        pic[i] = address + pic[i];
    }
    if (num == 0) {
        pic = new String[5];
        pic[0] = "";
    }
%>
<div id="main">
    <div id="content">
        <div><img src="/sbeam/Source/logo.png" width="78px" height="84px"></div>
        <div>
            <s:property value="#session.theGame.name"/><br/>
            <%
                double mallPrice = game.getMallPrice();
                double discount = game.getDiscountPrice();
                if (mallPrice != discount) {
            %>
            <div>
                <td>原价：<s:property value="%{#session.theGame.mallPrice}"/></td>
                <td>折扣价：<s:property value="%{#session.theGame.discountPrice}"/></td>
                <%} else {%>
                <td colspan="2">价格：<s:property value="%{#session.theGame.mallPrice}"/></td>
                <%}%></div>
            <div>游戏简介：
                <%
                    String RealPath = ServletActionContext.getServletContext().getRealPath(game.getDir() + "/describe/describe.txt");
                    File file = new File(RealPath);
                    try (FileReader reader = new FileReader(RealPath);
                         BufferedReader br = new BufferedReader(reader)
                    ) {
                        String line;
                        while ((line = br.readLine()) != null) {
                            //一次读入一行数据
                            System.out.println(line);
                            out.print(line);
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                %></div>
            <div>
                <table>
                    <tr>
                        <td><s:form action="buy" method="POST">
                            <s:hidden value="%{#session.theGame.id}" name="gid"/>
                            <button type="submit" class="btn btn-info">购买</button>
                        </s:form></td>
                        <td><s:form method="POST">
                            <a class="btn btn-info" href="/sbeam/user/evaluate/addEvaluate.jsp" role="button">评价</a>
                        </s:form></td>
                        <td><s:form method="POST">
                            <a class="btn btn-info" href="/sbeam/game/GameCDPlayer.jsp" role="button">游戏视频</a>
                        </s:form></td>
                        <td><s:form action="getGameEvaluate" method="POST">
                            <s:hidden name="gameId" value="%{#session.theGame.id}"/>
                            <button type="submit" class="btn btn-info">全部评价</button>
                        </s:form></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div id="img">
        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                <%for (int i = 1; i < num; i++) {%>
                <li data-target="#carousel-example-generic" data-slide-to="<%=i%>"></li>
                <%}%>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="<%=pic[0]%>" style="width:700px;height:350px">
                </div>
                <%for (int i = 1; i < num; i++) {%>
                <div class="item">
                    <img src="<%=pic[i]%>" style="width:700px;height:350px">
                </div>
                <%}%>
                <!-- Controls -->
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>
    <div id="back"><a class="btn btn-info" href="getAllGame">返回上一页</a></div>
</div>

<script src="/sbeam/Source/jquery-3.3.1.js"></script>
<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</body>
</html>
