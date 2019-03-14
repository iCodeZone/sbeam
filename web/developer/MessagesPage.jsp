<%@ page import="java.util.List" %>
<%@ page import="sbeam.po.message.Message" %><%--
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
    <title>MessagePage</title>
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
            overflow-y: hidden;
        }
    </style>
</head>
<body>

<canvas id="world" style="z-index:-1;height: 100%;width: 100%;">
</canvas>
<div style="overflow: hidden">
<div  id="main">
    <div class="container-fluid">
        <div class="row" style="margin-top: 5%">
            <div class="col-md-12">
                <ul class="nav nav-pills">
                    <li role="presentation"><a href="<%=((int)session.getAttribute("type"))==1?"/sbeam/developer/IndiDeveLoginSuccess.jsp":"/sbeam/developer/TeamDeveLoginSuccess.jsp"%>">个人资料</a></li>
                    <li role="presentation"><a href="<%=((int)session.getAttribute("type"))==1?"/sbeam/developer/IndiDeveLoginSuccessTeam.jsp":"/sbeam/developer/TeamDeveLoginSuccessTeam.jsp"%>">我的团队</a></li>
                    <li role="presentation" class="active"><a href="getMessagesAgain">我的消息(<s:property value="%{#session.messages==null?0:#session.messages.size()}"/>条)</a></li>
                    <li role="presentation"><a href="/sbeam/developer/LoginSuccessGame.jsp">我的游戏</a></li>
                    <li role="presentation"><a href="/sbeam/developer/LoginSuccessProblem.jsp">工单</a></li>
                </ul>
            </div>
        </div>
        <s:if test="%{#session.messages!=null && #session.messages.size()!=0}">
            <%
                List messages = (List)session.getAttribute("messages");
                int i = 0;
            %>
            <div class="row" style="margin-top: 10px">
                <div class="col-md-12">
                    <table class="table">
                        <tr>
                            <th width="10%">ID</th>
                            <th width="70%" style="text-align: center">内容</th>
                            <th width="20%" style="text-align: center">点击已读</th>
                        </tr>
                    <s:iterator value="#session.messages" >
                        <tr>
                            <td style="padding-top: 20px;"><s:property value="id"/></td>
                            <td style="padding-top: 20px;">
                                <%
                                    out.print(((Message)messages.get(i)).getContent());
                                %>
                            </td>
                            <td style="padding: 0px 10px;">
                                <form action="confirmMessage" method="post">
                                    <div class="form-group">
                                        <input type="hidden" name="location" value="/developer/MessagesPage.jsp">
                                    </div>
                                    <div class="form-group">
                                        <input type="hidden" name="message.id" value="<%=((Message)messages.get(i)).getId()%>">
                                    </div>
                                    <button type="submit" class="btn btn-default" style="width: 100%">已阅</button>
                                </form>
                            </td>
                        </tr>
                        <%i++;%>
                    </s:iterator>
                    </table>
                </div>
            </div>
        </s:if>

        <s:else>
            <div class="row" style="padding-bottom: 10px">
                <div class="col-md-12" style="text-align: center"><h3>消息列表空空如也！</h3></div>
            </div>
        </s:else>
    </div>
</div>
</div>

</body>
<script src="lib/background.js"/>
<script src="lib/bootstrap.js"></script>
</html>
