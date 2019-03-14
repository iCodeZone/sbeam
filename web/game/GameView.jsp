<%@ page import="sbeam.po.game.Game" %>
<%@ page import="sbeam.po.game.GameType" %>
<%@ page import="java.util.List" %>
<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!doctype html>
<html>
<head>
    <s:head theme="xhtml"/>
    <meta charset="utf-8">
    <title>全部游戏</title>
    <link type="text/css" rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">

    <style>
        body {
            background-color: #eee;
            /*overflow: hidden;*/
            height: 150%;
        }

        html {
            height: 150%;
        }

        canvas {
            background-color: #eee;
            display: block;
            margin: 0 auto;
            z-index: -1;
            height: 150%;
        }

        #login {
            position: absolute;
            left: 100px;
            top: 100px;
            width: 400px;
        }

        #point {
            width: 500px;
        }

    </style>
</head>
<s:fielderror/>
<s:actionerror/>
<body>

<canvas id="canvas"></canvas>
<!-- 背景 -->
<script>
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var cw = canvas.width = window.innerWidth,
        cx = cw / 2;
    var ch = canvas.height = window.innerHeight,
        cy = ch / 2;

    ctx.fillStyle = "#000";
    var linesNum = 16;
    var linesRy = [];
    var requestId = null;

    function Line(flag) {
        this.flag = flag;
        this.a = {};
        this.b = {};
        if (flag == "v") {
            this.a.y = 0;
            this.b.y = ch;
            this.a.x = randomIntFromInterval(0, ch);
            this.b.x = randomIntFromInterval(0, ch);
        } else if (flag == "h") {
            this.a.x = 0;
            this.b.x = cw;
            this.a.y = randomIntFromInterval(0, cw);
            this.b.y = randomIntFromInterval(0, cw);
        }
        this.va = randomIntFromInterval(25, 100) / 100;
        this.vb = randomIntFromInterval(25, 100) / 100;

        this.draw = function () {
            ctx.strokeStyle = "#ccc";
            ctx.beginPath();
            ctx.moveTo(this.a.x, this.a.y);
            ctx.lineTo(this.b.x, this.b.y);
            ctx.stroke();
        }

        this.update = function () {
            if (this.flag == "v") {
                this.a.x += this.va;
                this.b.x += this.vb;
            } else if (flag == "h") {
                this.a.y += this.va;
                this.b.y += this.vb;
            }

            this.edges();
        }

        this.edges = function () {
            if (this.flag == "v") {
                if (this.a.x < 0 || this.a.x > cw) {
                    this.va *= -1;
                }
                if (this.b.x < 0 || this.b.x > cw) {
                    this.vb *= -1;
                }
            } else if (flag == "h") {
                if (this.a.y < 0 || this.a.y > ch) {
                    this.va *= -1;
                }
                if (this.b.y < 0 || this.b.y > ch) {
                    this.vb *= -1;
                }
            }
        }

    }

    for (var i = 0; i < linesNum; i++) {
        var flag = i % 2 == 0 ? "h" : "v";
        var l = new Line(flag);
        linesRy.push(l);
    }

    function Draw() {
        requestId = window.requestAnimationFrame(Draw);
        ctx.clearRect(0, 0, cw, ch);

        for (var i = 0; i < linesRy.length; i++) {
            var l = linesRy[i];
            l.draw();
            l.update();
        }
        for (var i = 0; i < linesRy.length; i++) {
            var l = linesRy[i];
            for (var j = i + 1; j < linesRy.length; j++) {
                var l1 = linesRy[j]
                Intersect2lines(l, l1);
            }
        }
    }

    function Init() {
        linesRy.length = 0;
        for (var i = 0; i < linesNum; i++) {
            var flag = i % 2 == 0 ? "h" : "v";
            var l = new Line(flag);
            linesRy.push(l);
        }

        if (requestId) {
            window.cancelAnimationFrame(requestId);
            requestId = null;
        }

        cw = canvas.width = window.innerWidth,
            cx = cw / 2;
        ch = canvas.height = window.innerHeight,
            cy = ch / 2;

        Draw();
    };

    setTimeout(function () {
        Init();

        addEventListener('resize', Init, false);
    }, 15);

    function Intersect2lines(l1, l2) {
        var p1 = l1.a,
            p2 = l1.b,
            p3 = l2.a,
            p4 = l2.b;
        var denominator = (p4.y - p3.y) * (p2.x - p1.x) - (p4.x - p3.x) * (p2.y - p1.y);
        var ua = ((p4.x - p3.x) * (p1.y - p3.y) - (p4.y - p3.y) * (p1.x - p3.x)) / denominator;
        var ub = ((p2.x - p1.x) * (p1.y - p3.y) - (p2.y - p1.y) * (p1.x - p3.x)) / denominator;
        var x = p1.x + ua * (p2.x - p1.x);
        var y = p1.y + ua * (p2.y - p1.y);
        if (ua > 0 && ub > 0) {
            markPoint({
                x: x,
                y: y
            })
        }
    }

    function markPoint(p) {
        ctx.beginPath();
        ctx.arc(p.x, p.y, 2, 0, 2 * Math.PI);
        ctx.fill();
    }

    function randomIntFromInterval(mn, mx) {
        return ~~(Math.random() * (mx - mn + 1) + mn);
    }</script>
<%
    int cnt = 0;
%>
<div id="login">
    <a href="/sbeam/loginsuccess.jsp"><h1 id="point">欢迎来到Sbeam游戏平台</h1></a>
    <table>
        <tr>
            <%
                List<GameType> gameTypes = (List<GameType>) session.getAttribute("gameTypes");
                int ii = 0;
            %>
            <td>
                <s:form action="getAllGame" method="post">
                    <button type="submit" class="btn btn-default">全部游戏</button>
                </s:form>
            </td>
            <s:iterator var="type" value="#session.gameTypes" status="st">
                <td>
                    <s:form class="form-inline" action="getGameByType" method="POST">
                        <s:hidden value="%{#type.id}" name="gameTypeId"/>
                        <button type="submit" class="btn btn-default"><%=gameTypes.get(ii).getName()%>
                        </button>
                    </s:form>
                </td>
                <%ii++;%>
            </s:iterator>
        </tr>
    </table>
    <table>
        <tr width="1000px">
            <td>
                <s:form class="form-inline" action="getGameByWord" method="POST">
                    <div class="form-group">
                        <label for="word"/>
                        <input type="text" class="form-control" id="word" name="word"
                               value="<%=session.getAttribute("keyWord")==null?"":session.getAttribute("keyWord")%>"
                               placeholder="搜索关键字">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </s:form>
            </td>
        </tr>
    </table>
    <table class="table table-condensed">
        <tr align="left">
            <%
                List<Game> allGame = (List<Game>) session.getAttribute("allGame");
                int i = 0;
            %>
            <s:iterator var="game" value="#session.allGame" status="st">
            <td align="right">
                <div class="form-group">
                    <%
                        String dir = allGame.get(i).getDir();
                        dir = "/sbeam" + dir + "/pictures/1.png";
                    %>
                    <s:form action="getGameDetail" method="POST">
                        <input type="hidden" name="gameId" value="<%=allGame.get(i).getId()%>"/>
                        <input type="image" value="" src=<%=dir%>  style="width:400px;height:300px"/><br>
                    </s:form>
                    <s:property value="name"/>
                    <s:property value="discountPrice"/><br>
                    <s:form action="buy" method="POST">
                        <s:hidden value="%{#game.id}" name="gid"/>
                        <button type="submit" class="btn btn-default">购买</button>
                    </s:form>
                    <s:form action="setCollection" method="POST">
                        <s:hidden value="%{#game.id}" name="gameId"/>
                        <s:hidden value="%{#session.userId}" name="loginUser.id"/>
                        <button type="submit" class="btn btn-default">收藏</button>
                    </s:form>
                </div>
                        <%
                    cnt++;
                    if (cnt == 4) {
                        out.print("</td></tr><tr>");
                        cnt = 0;
                    } else {
                        out.print("</td>");
                    }
                %>
                        <%i++;%>
                </s:iterator>
        </tr>
    </table>
</div>
<!-- 引用 -->
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</body>
</html>


