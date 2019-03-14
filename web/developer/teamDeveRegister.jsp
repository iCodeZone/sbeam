<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>register</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
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
            position: absolute;left: 30%; top: 15%;
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
        <div class="row"><div class="col-md-12" style="text-align: center;"><strong><em><h3>欢迎加入Sbeam游戏商城</h3></em></strong></div></div>
        <div class="row">
            <div class="col-md-10">
                <form action="teamDeveRegister" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-5 control-label">请输入团队名称</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" placeholder="必填" name="teamDeve.name" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">请输入密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" placeholder="必填" name="teamDeve.password" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">请输入团队所在地址</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" placeholder="必填" name="teamDeve.address" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">请输入公司注册编号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="teamDeve.registmark" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">请输入公司网址</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="teamDeve.website" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-5 control-label">请输入银行卡号</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" placeholder="必填" name="teamDeve.bankcard" style="width: 100%;">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-5">
                            <button type="submit" class="btn btn-default">注册</button>
                        </div>
                        <div class="col-sm-4">
                            <button type="reset" class="btn btn-default">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <a href="teamDeveLogin.jsp">已有账号？点此登录</a>
            </div>
        </div>
    </div>
</div>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>

