<%@ page import="sbeam.po.ticket.Ticket" %>
<%@ page import="java.util.List" %>
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
            height: 80%;
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
        <div class="row"><div class="col-md-12" style="text-align: center"><h3>所有工单</h3></div></div>
        <s:if test="#session.tickets.size()>0">
            <div class="row">
                <div class="col-md-12">
                    <table class="table">
                        <tr>
                            <th>编号</th>
                            <th>类型</th>
                            <th>具体内容</th>
                            <th>处理状态</th>
                            <th>反馈时间</th>
                            <th>查看详情</th>
                        </tr>
                        <%
                            List<Ticket> tickets = (List<Ticket>)session.getAttribute("tickets");
                            int i =0;
                        %>
                        <s:iterator value="#session.tickets" status="st">
                            <tr>
                                <td><s:property value="pid"/></td>
                                <td><s:property value="%{type==1?'简单问题':type==2?'bug问题':type==3?'侵权问题':'异常问题'}"/></td>
                                <td><s:property value="pcontent"/> </td>
                                <td><s:property value="%{pstate==0?'待处理':'已处理'}"/> </td>
                                <td><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tickets.get(i).getPutime())%> </td>
                                <td>
                                    <s:form action="preProblemDetails" method="POST">
                                        <s:hidden name="index" value="%{#st.index}"/>
                                        <s:submit value="查看详情" class="btn btn-default"/>
                                    </s:form>
                                </td>
                            </tr>
                            <%i++;%>
                        </s:iterator>
                    </table>
                </div>
            </div>
        </s:if>
        <s:else>
            <div class="row"><div class="col-md-12" style="text-align: center"><h3>您还没有发过工单哦！</h3></div></div>
        </s:else>
        <div class="row" style="padding-bottom: 10px"><div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/LoginSuccessProblem.jsp" class="btn btn-default">返回</a></div></div>
    </div>
</div>
</div>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
