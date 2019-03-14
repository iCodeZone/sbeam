<%--
  Created by IntelliJ IDEA.
  User: LXY
  Date: 2018/12/26
  Time: 13:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<html>
<head>
    <title>Login</title>
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
            width: 35%;
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
        <div class="row"><div class="col-md-12" style="text-align: center;"><strong><em><h3>欢迎登录Sbeam游戏商城</h3></em></strong></div></div>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <form action="indiDeveLogin" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">请输入ID</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" placeholder="ID" name="indiDeve.id" style="width: 100%;">
                        </div>
                        <%--<s:textfield name="indiDeve.id" label="请输入ID"/>--%>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-4 control-label">请输入密码</label>
                        <div class="col-sm-8">
                            <input type="password" class="form-control" placeholder="密码" name="indiDeve.password" style="width: 100%;">
                        </div>
                        <%--<s:password name="indiDeve.password" label="请输入密码"/>--%>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-5">
                            <button type="submit" class="btn btn-default">登陆</button>
                        </div>
                        <div class="col-sm-5">
                            <button type="reset" class="btn btn-default">重置</button>
                        </div>
                        <%--<s:submit value="登录"/> <s:reset value="重置"/>--%>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <a href="indiDeveRegister.jsp">还没有账号？点此注册</a>
            </div>
        </div>
    </div>
</div>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
<script type="text/javascript">

</script>



</html>
