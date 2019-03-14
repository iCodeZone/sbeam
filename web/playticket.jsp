<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="sbeam.po.ticket.Ticket" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>展示工单</title>
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
        #play{
            position: absolute;
            left: 200px;
            top : 0px;
            width: 800px;
        }
        #state{
            width: 100px;
        }
        #type{
            width: 100px;
        }
        #time{
            width: 100px;
        }
        #fk{
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

        this.draw = function() {
            ctx.strokeStyle = "#ccc";
            ctx.beginPath();
            ctx.moveTo(this.a.x, this.a.y);
            ctx.lineTo(this.b.x, this.b.y);
            ctx.stroke();
        }

        this.update = function() {
            if (this.flag == "v") {
                this.a.x += this.va;
                this.b.x += this.vb;
            } else if (flag == "h") {
                this.a.y += this.va;
                this.b.y += this.vb;
            }

            this.edges();
        }

        this.edges = function() {
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

    setTimeout(function() {
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
                订单编号
                </label>
                </font>
            </td>
            <td>
                <label class="form-group">
                用户编号
                </label>
            </td>
            <td>
                <label class="form-group">
                具体内容
                </label>
            </td>
            <td id="state">
                <label class="form-group">
                状态
                </label>
            </td>
            <td>
                <label class="form-group">
                反馈时间
                </label>
            </td>
            <td id="time">
                <label class="form-group">
                结束时间
                </label>
            </td>
            <td id="fk">
                <label class="form-group">
                反馈处理结果
                </label>
            </td>
            <td id="timed">
                <label class="form-group">
                客服ID
                </label>
            </td>
            <td id="type">
                <label class="form-group">
                工单类型
                </label>
            </td>
        </tr>
        <%
            List<Ticket> list=(List)session.getAttribute("tickets");
            for(int i = 0 ; i < list.size() ; i++) {%>
        <tr>
            <td>
                <label class="form-group">
                <% out.println(list.get(i).getPid());%>
                </label>
            </td>
            <td>
                <label class="form-group">
                <% out.println(list.get(i).getPfid());%>
                </label>
            </td>
            <td>
                <label class="form-group">
                <% out.println(list.get(i).getPcontent());%>
                </label>
            </td>
            <td>
                <label class="form-group">
                <% if(list.get(i).getPstate()==0)
                    out.println("未处理");
                else
                    out.println("已处理");
                %>
                </label>
            </td>
            <td>
                <label class="form-group">
                <% out.println(list.get(i).getPutime());%>
                </label>
            </td>
            <td>
                <label class="form-group">
                <%
                    if(list.get(i).getPetime()==null)
                    out.println(" ");
                    else
                        out.println(list.get(i).getPetime());
                %>
                </label>
            </td>
            <td>
                <label class="form-group">
                <%
                    if(list.get(i).getPremes()==null)
                        out.println("请耐心等待");
                    else
                    out.println(list.get(i).getPremes());
                %>
                </label>
            </td>
            <td>
                <label class="form-group">
                <%
                    if(list.get(i).getSid()==null)
                    out.println(" ");
                else
                    out.println(list.get(i).getSid());
                %>
                </label>
            </td>
            <td>
                <label class="form-group">
                <%
                    if(list.get(i).getType()==1)
                    out.println("简单问题");
                    else if(list.get(i).getType()==2)
                        out.println("bug问题");
                    else if(list.get(i).getType()==2)
                        out.println("侵权问题");
                    else
                        out.println("异常问题");
                %>
                </label>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</body>
</html>
