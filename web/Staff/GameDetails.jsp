<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"  %>
<%@ page import="sbeam.po.game.Game" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <title>游戏详情</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" href="/sbeam/Source/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="/sbeam/Source/bootstrap-3.3.7-dist/css/bootstrap.min.css">
  </head>
  <style>
  	body{
  		margin:0;
  		padding:0;
  		display:flex;
  		justify-content: center;
  		align-items:center;
  	}
  	#main{
  		width:700px;
  		height:500px;
  		box-shadow:2px 1px 10px 1px;
  		background-color:rgba(246,246,247,0.85);
  		border-radius:5px;
  		position:absolute;
  	}
  	#content{
  		display:flex;
  		margin-top:350px;
  		width:700px;
  		position:absolute;
  	}
  	#deve{
  		position:absolute;
  		bottom:20px;
  	}
  	#label{
  		 width:40px;
  		 border-radius:5px;
  		 color:rgb(37,191,241);
  		 text-align:center;
  		 background-color:rgb(234,248,251);
  		 position:absolute;
  		 bottom:0;
  	}
  	#download{
  		position:absolute;
		right:0;
		bottom:0;
  	}
  	#describe{
  		width:300px;
  		font-size:10px;
  		margin-left:100px;
  	}
  	#img{
  		border-radius:5px;
  		width:700px;
  		height:350px;
  		margin:0 auto;
  		position:absolute;
		top:0;
  	}
  	#back a{
  		width:700px;
		position:absolute;
		bottom:0;
  	}
  </style>
  <body>
  	<%
  	//得到图片的地址
  	Game game = (Game)session.getAttribute("Game");
	String address=game.getDir();
	String s="/sbeam";
	address= s+address;
	address+="/pictures/";
	//用来获取文件夹中有几张图片
  	String realPath = ServletActionContext.getServletContext().getRealPath(game.getDir()+"/pictures");
    File text = new File(realPath);
    int len=0;
    len = text.listFiles().length;
    %>
	<div id="main">
		<div id="content">
			<div><img src="/sbeam/Source/logo.png" width="84px" height="84px"></div>
			<div>
				<div><h4><s:property value="#session.Game.name" /></h4></div>
				<s:if test="#session.Game.type">
					<div id="deve">开发者团队：<s:property value="#session.developer.name" /></div>
				</s:if>
				<s:else>
					<div id="deve">开发者：<s:property value="#session.developer.name" /></div>
				</s:else>
				<s:iterator value="#session.Game.types">
					<div id="label"><s:property value="name" /></div>
				</s:iterator>
			</div>
			<div id="describe">
				游戏简介：
				<%
				String RealPath = ServletActionContext.getServletContext().getRealPath(game.getDir()+"/describe/describe.txt");
				File file = new File(RealPath);
					System.out.println(file);
				try(FileReader reader = new FileReader(RealPath);
					BufferedReader br = new BufferedReader(reader)
				){
					String line;
					while((line = br.readLine()) != null){
						//一次读入一行数据
						System.out.println(line);
						out.print(line);
					}
				}catch (IOException e){
					e.printStackTrace();
				}
				 %>
			</div>
			<div id="download">
				<form action="downloadGame" method="post">
					<s:hidden name="game.id" value="%{#session.Game.id}"/>
					<s:hidden name="game.dir" value="%{#session.Game.dir}"/>
					<s:submit value="下载游戏"  class="btn btn-primary"/>
				</form>
				<a href="checkGameContentSuccess" class="btn btn-success">审核通过</a>
				<a href="checkGameContentFail" class="btn btn-warning">审核失败</a>
			</div>
		</div>

		<div id="img">
			<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
		  		<!-- Indicators -->
		  		<ol class="carousel-indicators">
		  		<%for(int i=0;i<len;i++){
		  			if(i==0){ %>
		    		<li data-target="#carousel-example-generic" data-slide-to="<%=i %>" class="active"></li>
		    		<%}
		    		else{ %>
		    		<li data-target="#carousel-example-generic" data-slide-to="<%=i %>"></li>
		    		<%}
		  		} %>
		  		</ol>
		  		<!-- Wrapper for slides -->
		  		<div class="carousel-inner" role="listbox">
		  			<%for(int i=0;i<len;i++){
		  			if(i==0){%>
		    		<div class="item active">
		      			<img src="<%=address %><%=i+1 %>.png" style="width:700px;height:350px">
		    		</div>
		    		<%}
		    		else {%>
		    		<div class="item">
		      			<img src="<%=address %><%=i+1 %>.png" style="width:700px;height:350px">
		    		</div>
		    		<%}
		    		} %>
			  		<!-- Controls -->
			  		<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
			    		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			    		<span class="sr-only">Previous</span>
			  		</a>
			  		<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
			    		<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			    		<span class="sr-only">Next</span>
			  		</a>
				</div>
			</div>
		</div>
		<div id="back"><a class="btn btn-info"  href="/sbeam/Staff/CheckGame.jsp">返回上一页</a></div>
	</div>

	<script src="/sbeam/Source/jquery-3.3.1.js"></script>
	<script src="/sbeam/Source/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
  </body>
</html>
