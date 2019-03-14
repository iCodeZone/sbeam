<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="sbeam.po.game.Game" %>
<%@ page import="java.io.File" %><%--
  Created by IntelliJ IDEA.
  User: huayifan
  Date: 2019/1/4
  Time: 23:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>游戏视频</title>
    <style>
        .m {
            width: 500px;
            height: 300px;
        }

        #video {
            width: 300px;
            height: 500px;
        }

        video {
            position: absolute;
            top: 0px;
            right: 0px;
            bottom: 0px;
            left: 0px;
            max-height: 300px;
            max-width: 500px;
            margin: auto;
        }
    </style>
</head>
<body>
<%
    Game game = (Game) session.getAttribute("theGame");
    String address = game.getDir();
    String s = "/sbeam";
    address = s + address;
    address += "/video/";
    //用来获取文件夹中的视频
    String realPath = ServletActionContext.getServletContext().getRealPath(game.getDir() + "/video");
    File text = new File(realPath);
    String[] video = text.list();
    if (text.exists() && video.length != 0) {
        address = address + video[0];
    }
%>
<script src="ckplayer.js" type="text/javascript"></script>
<div class="m">
    <div id="video" style="width:500px;height:300px;"></div>
    <script type="text/javascript">
        var location = "<%=address%>";
        var videoObject = {
            container: '#video',//“#”代表容器的ID，“.”或“”代表容器的class
            variable: 'player',//该属性必需设置，值等于下面的new chplayer()的对象
            flashplayer: false,//如果强制使用flashplayer则设置成true
            allowFullScreen: false,//是否支持全屏
            video: {
                file: '${address }',//视频地址
                type: 'video/mp4'
            }
        };
        var player = new ckplayer(videoObject);
    </script>
</div>
</body>
</html>
