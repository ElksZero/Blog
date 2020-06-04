<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>底部</title>
</head>
<body>
	<br>
	<br>
	<!-- 底部 -->
	<nav class="navbar navbar-inverse navbar-fixed-bottom"> <!--贴在底部，不会消失-->
		<div style="text-align: center; color: #D9D9D9;">版权所有©2020 Elkszero，保留所有权利</div>
		<div style="text-align: center; color: #D9D9D9;">Powered by BootStrap 、 Editor.md 、SSM</div>
	</nav>
</body>
</html>