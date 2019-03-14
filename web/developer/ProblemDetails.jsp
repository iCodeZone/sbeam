<%@ page import="java.util.List" %>
<%@ page import="sbeam.po.ticket.Ticket" %><%--
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
    <title>TicketsPage</title>
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
        <div class="row"><div class="col-md-12" style="text-align: center"><h3>工单详情</h3></div></div>
        <%
            List tickets = (List)session.getAttribute("tickets");
            Ticket ticket = (Ticket) tickets.get((int)request.getAttribute("index"));
            String src = "/sbeam";
            src += ticket.getPphotoaddr();


        %>
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <table class="table">
                    <tr>
                        <th>编号:</th>
                        <td><%out.println(ticket.getPid());%></td>
                    </tr>
                    <tr>
                        <th>类型:</th>
                        <td>
                            <%int type = ticket.getType();
                            if(type==1){
                                out.println("简单问题");
                            }
                            else if(type==2){
                                out.println("bug问题");
                            }
                            else if(type==3){
                                out.println("侵权问题");
                            }
                            else{
                                out.println("异常问题");
                            }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <th>具体内容:</th>
                        <td><%out.println(ticket.getPcontent());%></td>
                    </tr>
                    <tr>
                        <th>处理状态:</th>
                        <td>
                            <%int state = ticket.getPstate();
                                if (state==0){
                                    out.println("待处理");
                                }
                                else{
                                    out.println("已处理");
                                }
                            %>
                        </td>
                    </tr>
                    <tr>
                        <th>反馈时间:</th>
                        <td><%out.println(ticket.getPutime());%></td>
                    </tr>
                </table>
            </div>
        </div>
        <%
            if(ticket.getPphotoaddr()!=null){
        %>
        <div class="row" style="text-align: center">
        <img src="<%=src%>" width="150" height="80"/>
        </div>
        <%}%>
        <div class="row" style="padding-bottom: 10px;margin-top: 5px"><div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/TicketsPage.jsp" class="btn btn-default">返回</a></div></div>
    </div>
</div>
</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
