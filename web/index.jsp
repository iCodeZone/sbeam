<%@ page import="java.io.File" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.struts2.ServletActionContext" %><%--
  Created by IntelliJ IDEA.
  User: LXY
  Date: 2018/12/18
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<html>
  <head>
    <title>AllLogin</title>
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
        position: absolute;left: 30%; top: 25%;
        /*height: 36%;*/
        width: 40%;
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
      <div class="row" style="margin-top: 10%">
        <div class="col-md-12" style="text-align: center"><strong><h4>Hello World!</h4></strong></div>
        <%
          session.invalidate();
        %>
      </div>
      <div class="row" style="margin-top: 3%">
        <div class="col-md-12" style="text-align: center"><a href="/sbeam/customer/login.jsp">客户登录</a></div>
      </div>
      <div class="row" style="margin-top: 3%">
        <div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/indiDeveLogin.jsp">个人开发者登录</a></div>
      </div>
      <div class="row" style="margin-top: 3%">
        <div class="col-md-12" style="text-align: center"><a href="/sbeam/developer/teamDeveLogin.jsp">团队开发者登录</a></div>
      </div>
      <div class="row" style="margin-top: 3%;padding-bottom: 5px;">
        <div class="col-md-12" style="text-align: center"><a href="/sbeam/AdminStaffLogin.jsp">工作人员登录</a></div>
      </div>

    </div>
  </div>
  </body>
  <script src="/sbeam/developer/lib/background.js"/>
  <script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
