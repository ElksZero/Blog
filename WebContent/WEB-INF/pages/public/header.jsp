<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首部导航</title>
<script src="<%=basePath%>static/js/user.js"></script>
</head>
<body class="bootstrap-admin-with-small-navbar">
	<!-- 用于获取相对路径uri -->
	<input type="hidden" value="<%=basePath%>" id="basePath">
	<!-- 导航 -->
	<nav
		class="navbar navbar-inverse  navbar-fixed-top bootstrap-admin-navbar bootstrap-admin-navbar-under-small"
		role="navigation">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="collapse navbar-collapse main-navbar-collapse"
					style="color: #D9D9D9;">
					<a class="navbar-brand" href="<%= basePath %>"><strong>雪殇泪雨Blog后台管理</strong></a>
					<c:if test="${userVo != null }">
						<!-- 右上角登录状态与用户信息 -->
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown"><a href="#" role="button"
								class="dropdown-toggle" data-hover="dropdown"> <i
									class="glyphicon glyphicon-user"></i> ${userVo.nickname } <i class="caret"></i></a>
								<ul class="dropdown-menu">
									<li><a href="#user_updateinfo" data-toggle="modal">个人资料</a></li>
									<li role="presentation" class="divider"></li>
									<li><a href="#user_updatepwd" data-toggle="modal">修改密码</a></li>
									<li role="presentation" class="divider"></li>
									<!-- href="#identifier"  来指定要切换的特定的模态框（带有 id="identifier"）。-->
									<li><a id="logout">退出</a></li>
								</ul></li>
						</ul>
					</c:if>
					<c:if test="${userVo == null }">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#user_login" data-toggle="modal">登录</a></li>
							<li><a href="#user_register" data-toggle="modal">注册</a></li>
						</ul>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	</nav>

	<c:if test="${userVo == null }">
	<!-------------------------登录模态框------------------------------------->
	<form class="form-horizontal">
		<!-- 保证样式书评不混乱 -->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="user_login" tabindex="-1" role="dialog"
			aria-labelledby="ModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="ModalLabel">用户登录</h4>
					</div>

					<div class="modal-body">
						<!--正文-->
						<div class="form-group">
							<label class="col-sm-3 control-label">用户名</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="login_username"
									placeholder="请输入您的用户名" value=''> <label
									class="control-label" for="login_username"
									style="display: none;"></label>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-3 control-label">密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" id="login_password"
									placeholder="请输入您的密码" value=''> <label
									class="control-label" for="login_password"
									style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="login">
							登录</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>

	<!-------------------------注册模态框------------------------------------->
	<form class="form-horizontal">
		<!--保证样式水平不混乱-->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="user_register" tabindex="-1" role="dialog"
			aria-labelledby="ModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="ModalLabel">新用户注册</h4>
					</div>

					<div class="modal-body">

						<!--正文-->
						<div class="form-group">
							<label class="col-sm-3 control-label">用户名</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="register_username"
									placeholder="长度6~12,以字母开头,不应包含特殊字符" value=''> <label
									class="control-label" for="register_username"
									style="display: none;"></label>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-3 control-label">昵称</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="register_nickname"
									placeholder="请输入您的昵称" value=''> <label
									class="control-label" for="register_nickname"
									style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control"
									id="register_password" placeholder="请输入新密码"> <label
									class="control-label" for="register_password"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">确认密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control"
									id="register_confirmPwd" placeholder="请输入确认密码"> <label
									class="control-label" for="user_confirmPwd"
									style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">联系号码</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="register_phone"
									placeholder="请输入您的联系号码" value=''> <label
									class="control-label" for="register_phone"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">邮箱</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="register_email"
									placeholder="请输入您的邮箱" value=''> <label
									class="control-label" for="register_email"
									style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="register">注册</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>
	</c:if>
	<c:if test="${userVo != null }">
	<!-------------------------个人资料模态框------------------------------------->
	<form class="form-horizontal">
		<!--保证样式水平不混乱-->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="user_updateinfo" tabindex="-1"
			role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="ModalLabel">个人资料</h4>
					</div>

					<div class="modal-body">

						<!--正文-->
						<div class="form-group">
							
							<label class="col-sm-3 control-label">用户名</label>
							<div class="col-sm-7">
								<input type="hidden" id="user_updateinfo_id" value="${userVo.id }">
								<input type="text" class="form-control" id="info_username"
									readonly="readonly" value="${userVo.username }"> <label
									class="control-label" for="info_username"
									style="display: none;"></label>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-3 control-label">昵称</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="info_nickname"
									placeholder="请输入您的昵称" value="${userVo.nickname }"> <label
									class="control-label" for="info_nickname"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">联系号码</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="info_phone"
									placeholder="请输入您的联系号码" value="${userVo.mobile_num }"> <label
									class="control-label" for="info_phone" style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">邮箱</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="info_email"
									placeholder="请输入您的邮箱" value="${userVo.email }"> <label
									class="control-label" for="info_email" style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="update_userInfo">修改</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>



	<!------------------------------修改密码模糊框-------------------------------->
	<form class="form-horizontal">
		<!--保证样式水平不混乱-->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="user_updatepwd" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">修改密码</h4>
					</div>

					<div class="modal-body">

						<!--正文-->
						<div class="form-group">
							<label class="col-sm-3 control-label">原密码</label>
							<div class="col-sm-7">
								<input type="hidden" id="user_updatepwd_id" value="${userVo.id }">
								<input type="password" class="form-control" id="user_oldPwd"
									placeholder="请输入原密码"> <label class="control-label"
									for="user_oldPwd" style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">新密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" id="user_newPwd"
									placeholder="请输入新密码"> <label class="control-label"
									for="user_newPwd" style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">确认密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" id="user_confirmPwd"
									placeholder="请输入确认密码"> <label class="control-label"
									for="user_confirmPwd" style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="update_userpwd">
							修改</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>
	</c:if>
	<!-- 提示信息的模态框 -->
	<div class="modal fade" id="modal_info" tabindex="-1" role="dialog"
		aria-labelledby="addModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="infoModalLabel">提示</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12" id="div_info"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="btn_info_close"
						data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>