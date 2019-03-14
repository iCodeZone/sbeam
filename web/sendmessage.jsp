<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!doctype html>
<html>
<head>
    <s:head theme="xhtml"/>
    <meta charset="utf-8">
    <title>发送工单</title>
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
        #send{
            position: absolute;
            left: 100px;
            top : 100px;
            width: 400px;
        }
    </style>
</head>
<s:fielderror/>
<s:actionerror/>
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
    }</script>
<div id="send">
    <s:form action="sendticket" method="post" enctype="multipart/form-data">
        <table class="table table-condensed">
            <tr>
                <td>
                    <label for="account">请选择错误类型</label>
                </td>
            </tr>
            <tr>
                <td >
                    <div class="radio">
                        <label>
                            <input type="radio" name="ticket.type"  value="1" checked>
                            简单问题
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <td >
                    <div class="radio">
                        <label>
                            <input type="radio" name="ticket.type"  value="2" checked>
                            bug问题
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <td >
                    <div class="radio">
                        <label>
                            <input type="radio" name="ticket.type"  value="3" checked>
                            侵权问题
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <td >
                    <div class="radio">
                        <label>
                            <input type="radio" name="ticket.type"  value="4" checked>
                            异常问题
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group" >
                        <label for="account">请输入错误详情</label>
                        <input type="text" class="form-control" id="account" placeholder="错误详情" name="ticket.pcontent" >
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group" >
                        <label for="picture">如有需要，可上传图片</label>
                        <input type="file" class="form-control" id="picture" placeholder="昵称" name="upload" >
                    </div>
                </td>
            </tr>
            <tr>
                <td width="100">
                    <button type="submit" class="btn btn-default">发送</button>
                </td>
                <td width="100">
                    <button type="reset" class="btn btn-default">重置</button>
                </td>
                <td>
                    <a  class="btn btn-default" href="loginsuccess.jsp" role="button">返回</a>
                </td>
            </tr>
        </table>
    </s:form>
</div>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</body>
</html>
