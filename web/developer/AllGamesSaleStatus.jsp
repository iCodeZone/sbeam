<%@ page import="java.util.List" %>
<%@ page import="sbeam.po.order.Order" %>
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
<%@ taglib prefix="S" uri="/struts-tags" %>
<html>
<head>
    <title>AllGamesSaleStatus</title>
    <s:head theme="xhtml"/>
    <sx:head parseContent="true" extraLocales="utf-8"/>
    <link rel="stylesheet" href="lib/bootstrap.css"/>
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
        <s:if test="%{#session.allorders.size()!=0 && #session.allorders!=null}">
            <div class="row">
                <div class="col-md-12" style="text-align: center"><h3>您在过去<s:property value="days"/>天内的订单状态如下： </h3></div>
            </div>
            <div class="row">
                <div class="col-md-offset-2 col-md-8">
                    在过去的<s:property value="days"/>天内，交易总数为<s:property value="#session.allorders.size()"/>单，
                    <%
                        List orders = (List)session.getAttribute("allorders");
                        int successNum=0;
                        int failNum=0;
                        int waitNum=0;
                        //统计成功单数和失败单数
                        for(int i=0;i<orders.size();i++){
                            if(((Order)orders.get(i)).getState()==1){
                                failNum+=1;
                            }
                            else if(((Order)orders.get(i)).getState()==0){
                                waitNum+=1;
                            }
                            else if(((Order)orders.get(i)).getState()==2){
                                successNum+=1;
                            }
                        }
                        out.print("交易成功单数为"+successNum+"单，交易失败"+failNum+"单，待支付"+waitNum +
                                "单，总成功交易额为"+session.getAttribute("sumprise"));
                    %>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <table class="table">
                        <tr>
                            <th>订单编号</th><th>订单日期</th><th>订单状态</th><th>游戏名称</th>
                        </tr>
                        <%
                            int i=0;
                        %>
                        <s:iterator value="#session.allorders">
                            <tr>
                                <td><s:property value="id"/> </td>
                                <td><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((Order) orders.get(i)).getDate())%> </td>
                                <td><s:property value="%{state==0?'待付款':state==1?'退款':'已付款'}"/> </td>
                                <td><s:property value="game.name"/> </td>
                            </tr>
                            <%i++;%>
                        </s:iterator>
                    </table>
                </div>
            </div>
            <%
                session.removeAttribute("sumprise");
                session.removeAttribute("allorders");
            %>
        </s:if>
        <div class="row" style="padding-bottom: 10px">
            <div class="col-md-12" style="text-align: center">
                <a href="/sbeam/developer/LoginSuccessGame.jsp" class="btn btn-default">返回</a>
            </div>
        </div>
    </div>
</div>
</div>
</body>
<script src="lib/background.js"/>
<script src="lib/bootstrap.js"></script>
</html>
