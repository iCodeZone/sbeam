<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="sbeam.po.user.Customer" %>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>
    
      <title>购买界面</title>
   </head>
  
     <body>
           <s:form action="buy" method="post">
               <s:submit value="购买"/>
           </s:form>
    </body>
</html>
