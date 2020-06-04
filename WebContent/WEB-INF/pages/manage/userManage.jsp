<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="<%=basePath%>static/images/favicon.ico" rel="shortcut icon" />
<title>用户管理</title>

<!-- bootstrap css -->
<link rel="stylesheet"
	href="<%=basePath%>static/bootstrap/css/bootstrap.css" />
<link rel="stylesheet"
	href="<%=basePath%>static/bootstrap/css/bootstrap-theme.css" />
<link rel="stylesheet"
	href="<%=basePath%>static/bootstrap/css/bootstrap-admin-theme.css" />
<!-- jquery -->
<script src="<%=basePath%>static/js/jquery/jquery-3.4.1.js"></script>
<!-- bootstrap js -->
<script src="<%=basePath%>static/bootstrap/js/bootstrap.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap-dropdown.min.js"></script>

<script src="<%=basePath%>static/js/userManage.js"></script>
</head>
<body>
	<!-- 导航 -->
	<jsp:include page="../public/header.jsp"></jsp:include>

	<!-- 容器 -->
	<div class="container">
		<div class="row">
			<!-- 左侧菜单 -->
			<div class="col-md-2 bootstrap-admin-col-left">
				<ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
					<li><a href="<%=basePath%>"> <i
							class="glyphicon glyphicon-chevron-right"></i> 文章
					</a></li>
					<li><a href="<%=basePath%>manage/myArticleManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 我的文章
					</a></li>
					<li><a href="<%=basePath%>manage/articleManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 文章管理
					</a></li>
					<li class="active"><a href="<%=basePath%>manage/userManage">
							<i class="glyphicon glyphicon-chevron-right"></i> 用户管理
					</a></li>
					<li><a href="<%=basePath%>manage/articleTypesManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 文章类别管理
					</a></li>
					<li><a href="<%=basePath%>manage/articleLabelsManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 文章标签管理
					</a></li>
					<li><a href="<%=basePath%>manage/articleCommentsManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 文章评论管理
					</a></li>
				</ul>
			</div>
			<div class="col-md-10">
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default bootstrap-admin-no-table-panel">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">查询</div>
							</div>
							<div
								class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">
								<form class="form-horizontal"
									action="<%=basePath%>manage/userManage" method="get">
									<div class="col-lg-4 form-group">
										<label class="col-lg-4 control-label">用户名</label>
										<div class="col-lg-8">
											<label for="possible_username"></label><input
												class="form-control" id="possible_username"
												name="possible_username" type="text" /> <label
												class="control-label" style="display: none;"></label>
										</div>
									</div>

									<div class="col-lg-4 form-group">
										<label class="col-lg-4 control-label">昵称</label>
										<div class="col-lg-8">
											<label for="possible_nickname"></label><input
												class="form-control" id="possible_nickname"
												name="possible_nickname" type="text" value=""> <label
												class="control-label" style="display: none;"></label>
										</div>
									</div>

									<div class="col-lg-2">
										<button type="submit" class="btn btn-primary"
											style="float: right;">查询</button>
									</div>
									<div class="col-lg-2">
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#user_add">添加</button>
									</div>

								</form>
							</div>
						</div>
					</div>
				</div>


				<div class="row">
					<div class="col-lg-12">
						<table id="data_list" class="table table-hover table-bordered"
							cellspacing="0" width="100%">
							<thead>
								<tr>
									<th>用户名</th>
									<th>昵称</th>
									<th>邮箱</th>
									<th>联系号码</th>
									<th>入站时间</th>
									<th>操作</th>

								</tr>
							</thead>


							<tbody>

								<c:if test="${pageInfo.list != null }">
									<c:forEach items="${pageInfo.list }" var="user">
										<tr>
											<td>${user.username }</td>
											<td>${user.nickname }</td>
											<td>${user.email }</td>
											<td>${user.mobile_num }</td>
											<td><fmt:formatDate value="${user.register_date }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
											<td>
												<button type="button" class="btn btn-warning btn-xs"
													onclick="getUserById(${user.id})" data-toggle="modal"
													data-target="#user_update">修改</button>
												<button type="button" class="btn btn-danger btn-xs"
													onclick="deleteUserById(${user.id})">删除</button>
												<button type="button" class="btn btn-success btn-xs"
													data-toggle="modal" data-target="#userpower_set" onclick="getAuthorizationById(${user.id})">权限</button>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${pageInfo.list == null }">
									<td>暂无数据</td>
									<td>暂无数据</td>
									<td>暂无数据</td>
									<td>暂无数据</td>
									<td>暂无数据</td>
									<td>
										<button type="button" class="btn btn-warning btn-xs">修改</button>
										<button type="button" class="btn btn-danger btn-xs"
											data-toggle="modal" data-target="#addNumModal">删除</button>
										<button type="button" class="btn btn-success btn-xs"
											data-toggle="modal" data-target="#updateModal"
											id="btn_update">权限</button>
									</td>
								</c:if>
							</tbody>
						</table>
						<!-- 分页 -->
						<script type="text/javascript">
							function page(pageNum) {
								window.location.href = "<%=basePath%>manage/userManage?pageNum="
										+ pageNum
										+ "&possible_username=${possible_username}&possible_nickname=${possible_nickname}";
							}
						</script>
						<jsp:include page="../public/page.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-------------------------添加用户模态框------------------------------------->
	<form class="form-horizontal">
		<!--保证样式水平不混乱-->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="user_add" tabindex="-1" role="dialog"
			aria-labelledby="ModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="ModalLabel">添加用户</h4>
					</div>

					<div class="modal-body">

						<!--正文-->
						<div class="form-group">
							<label class="col-sm-3 control-label">用户名</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="add_username"
									placeholder="长度6~12,以字母开头,不应包含特殊字符" value=''> <label
									class="control-label" for="add_username" style="display: none;"></label>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-3 control-label">昵称</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="add_nickname"
									placeholder="请输入您的昵称" value=''> <label
									class="control-label" for="add_nickname" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" id="add_password"
									placeholder="请输入新密码"> <label class="control-label"
									for="add_password" style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">确认密码</label>
							<div class="col-sm-7">
								<input type="password" class="form-control" id="add_confirmPwd"
									placeholder="请输入确认密码"> <label class="control-label"
									for="add_confirmPwd" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">联系号码</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="add_phone"
									placeholder="请输入您的联系号码" value=''> <label
									class="control-label" for="add_phone" style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">邮箱</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="add_email"
									placeholder="请输入您的邮箱" value=''> <label
									class="control-label" for="add_email" style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="add_user">添加</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>

	<!-------------------------修改个人信息模态框------------------------------------->
	<form class="form-horizontal">
		<!--保证样式水平不混乱-->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="user_update" tabindex="-1" role="dialog"
			aria-labelledby="ModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="ModalLabel">修改</h4>
					</div>

					<div class="modal-body">

						<!--正文-->
						<div class="form-group">

							<label class="col-sm-3 control-label">用户名</label>
							<div class="col-sm-7">
								<input type="hidden" id="user_update_id" value=""> <input
									type="text" class="form-control" id="update_username"
									readonly="readonly" value=""> <label
									class="control-label" for="update_username"
									style="display: none;"></label>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-3 control-label">昵称</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="update_nickname"
									placeholder="请输入您的昵称" value=""> <label
									class="control-label" for="update_nickname"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">联系号码</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="update_phone"
									placeholder="请输入您的联系号码" value=""> <label
									class="control-label" for="update_phone" style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">邮箱</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="update_email"
									placeholder="请输入您的邮箱" value=""> <label
									class="control-label" for="info_email" style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="update_user">修改</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>

	<!-- 权限模态框（Modal） -->
	<form class="form-horizontal">
		<!--保证样式水平不混乱-->
		<div class="modal fade" id="userpower_set" tabindex="-1" role="dialog"
			aria-labelledby="powerModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="powerModalLabel">设置用户权限</h4>
					</div>
					<div class="modal-body">

						<!---------------------权限表单-------------------->

						<div class="form-group">
							<label class="col-sm-3 control-label">写作权限</label>
							<div class="col-sm-7">
								<input type="hidden" id="userpower_set_id"> 
								<input type="checkbox" name="power" id="write" value="write">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">评论权限</label>
							<div class="col-sm-7">
								<input type="checkbox" name="power" id="comment" value="comment">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">标签管理权限</label>
							<div class="col-sm-7">
								<input type="checkbox" name="power" id="labelSet"
									value="labelSet">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">分类管理权限</label>
							<div class="col-sm-7">
								<input type="checkbox" name="power" id="typeSet"
									value="typeSet">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">文章管理权限</label>
							<div class="col-sm-7">
								<input type="checkbox" name="power" id="articleSet" value="articleSet">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">评论管理权限</label>
							<div class="col-sm-7">
								<input type="checkbox" name="power" id="commentSet"
									value="commentSet">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">用户管理权限</label>
							<div class="col-sm-7">
								<input type="checkbox" name="power" id="userSet" value="userSet">
							</div>
						</div>


						<!---------------------表单-------------------->

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="set_userpower">
							设置</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>

	</form>
	<!-------------------------------------------------------------->
	<!-- 底部 -->
	<jsp:include page="../public/footer.jsp"></jsp:include>
</body>
</html>