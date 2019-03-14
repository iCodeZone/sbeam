<%--
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
    <title>Problem</title>
    <s:head theme="xhtml"/>
    <sx:head parseContent="true" extraLocales="utf-8"/>
    <link rel="stylesheet" href="/sbeam/developer/lib/bootstrap.css"/>
    <style type="text/css">
        html, body {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 120%;
            /*overflow: hidden;*/
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
        <div class="row"><div class="col-md-12" style="text-align: center"><h3>工单</h3></div></div>
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <form action="submitProblem" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>请选择问题类型</label><br/>
                        <label class="radio-inline">
                            <input type="radio" name="ticket.type" value="1"> 简单问题
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="ticket.type" value="2"> bug问题
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="ticket.type" value="3"> 侵权问题
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="ticket.type" value="4"> 异常问题
                        </label>
                    </div>
                    <div class="form-group">
                        <label>请输入问题描述</label>
                        <!--<input type="" name="ticket.pcontent" class="form-control">-->
                        <textarea name="ticket.pcontent" class="form-control"></textarea>
                    </div>
                    <div class="form-group">
                        <label>有截图的话请上传</label>
                        <input type="file" name="upload">
                    </div>
                    <button type="submit" class="btn btn-default" style="width: 100%">提交</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
<script src="/sbeam/developer/lib/background.js"/>
<script src="/sbeam/developer/lib/bootstrap.js"></script>
</html>
