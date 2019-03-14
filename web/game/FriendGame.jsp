<%@ page language="java" import="sbeam.po.order.Order" pageEncoding="utf-8" %>
<%@ page import="sbeam.po.user.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <%
        Customer friend = (Customer) session.getAttribute("friend");
    %>
    <title><%=friend.getAccount()%>的游戏</title>
    <link type="text/css" rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css">

    <style>
        body {
            background-color: #eee;
            overflow: hidden;
        }

        canvas {
            background-color: #eee;
            display: block;
            margin: 0 auto;
            z-index: -1;
        }

        #play {
            position: absolute;
            left: 200px;
            top: 0px;
            width: 800px;
        }

        #state {
            width: 100px;
        }

        #type {
            width: 100px;
        }

        #time {
            width: 100px;
        }

        #fk {
            width: 150px;
        }
    </style>
</head>

<body>
<canvas id="canvas"></canvas>

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
    }
</script>
<div id="play">
    <table class="table table-condensed">
        <tr>
            <td>
                <label class="form-group">
                    游戏名称
                </label>
                </font>
            </td>
            <td>
                <label class="form-group">
                    实付
                </label>
            </td>
            <td>
                <label class="form-group">
                    购买时间
                </label>
            </td>
        </tr>
        <%
            Set<Order> lists = (Set<Order>) session.getAttribute("friendGame");
            List<Order> list = new ArrayList<>(lists);
            Collections.sort(list, (o1, o2) -> {
                long temp = o2.getDate().getTime() - o1.getDate().getTime();
                if (temp > 0) return 1;
                else if (temp < 0) return -1;
                else return 0;
            });
            for (int i = 0; i < list.size(); i++) {%>
        <tr>
            <td>
                <label class="form-group">
                    <s:form action="getGameDetail" method="POST">
                        <input type="hidden" name="gameId" value="<%=list.get(i).getGame().getId()%>"/>
                        <button type="submit" class="btn btn-default"><%=list.get(i).getGame().getName()%>
                        </button>
                    </s:form>
                </label>
            </td>
            <td>
                <label class="form-group">
                    <%out.println(list.get(i).getPay());%>
                </label>
            </td>
            <td>
                <label class="form-group">
                    <%out.print(list.get(i).getDate());%>
                </label>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <div align="right">
        <a class="btn btn-default" href="game/GameEvaluate.jsp" role="button">返回上一级</a>
    </div>
</div>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</body>
</html>
