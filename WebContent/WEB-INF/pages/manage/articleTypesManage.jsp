<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="<%=basePath%>static/images/favicon.ico" rel="shortcut icon" />
<title>文章类别管理</title>

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
<script src="<%=basePath%>static/js/articleTypesManage.js"></script>
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
					<li><a href="<%=basePath%>manage/userManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 用户管理
					</a></li>
					<li class="active"><a
						href="<%=basePath%>manage/articleTypesManage"> <i
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
								<form class="form-horizontal" action="<%=basePath%>manage/articleTypesManage" method="get">
									<div class="col-lg-6 form-group">
										<label class="col-lg-4 control-label">文章类别名称</label>
										<div class="col-lg-8">
											<label for="possible_names"></label>
											<input class="form-control"
												id="possible_names" name="possible_names" type="text" value="${possible_names }" /> 
												<label
												class="control-label" style="display: none;"></label>
										</div>
									</div>

									<div class="col-lg-3">
										<button type="submit" class="btn btn-primary"
											id="query" style="float: right;">查询</button>
									</div>
									<div class="col-lg-3">
										<button type="button"  class="btn btn-primary" data-toggle="modal" data-target="#type_add">添加</button>
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
									<th>分类名称</th>
									<th>分类描述</th>
									<th>操作</th>
								</tr>
							</thead>


							<tbody>
								<c:if test="${pageInfo.list != null }">
									<c:forEach items="${pageInfo.list }" var="type">
										<tr>
											<td><c:if test="${type.name != null }">
													${type.name}
												</c:if> <c:if test="${type.name == null || type.name == '' }">
													暂无数据
												</c:if></td>
											<td><c:if test="${type.describe != null }">
													${type.describe }
												</c:if> <c:if test="${type.describe == null || type.describe == '' }">
													暂无描述
												</c:if></td>
											<td>
												<button type="button" class="btn btn-warning btn-xs"
													data-toggle="modal" data-target="#type_update"
													onclick="getTypeById(${type.id})">修改</button>
												<button type="button" class="btn btn-danger btn-xs"
													onclick="deleteTypeById(${type.id})">删除</button>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${pageInfo.list == null }">
									<tr>
										<td>暂无数据</td>
										<td>暂无数据</td>
										<td>
											<button type="button" class="btn btn-warning btn-xs"
												data-toggle="modal" data-target="#type_update">修改</button>
											<button type="button" class="btn btn-danger btn-xs">删除</button>
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<script type="text/javascript">
							function page(pageNum) {
								window.location.href = "<%=basePath%>manage/articleTypesManage?pageNum="
										+ pageNum
										+ "&possible_names=${possible_names}";
							}
						</script>
						<jsp:include page="../public/page.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-------------------------分类添加模态框------------------------------------->
	<form class="form-horizontal">
		<!-- 保证样式书评不混乱 -->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="type_add" tabindex="-1" role="dialog"
			aria-labelledby="ModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="ModalLabel">添加分类</h4>
					</div>

					<div class="modal-body">
						<!--正文-->
						<div class="form-group">
							<label class="col-sm-3 control-label">分类名称</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="add_typeName"
									placeholder="请输入分类名称名称" value=''> <label
									class="control-label" for="add_typeName"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">分类描述</label>
							<div class="col-sm-7">
								<textarea rows="3" class="form-control" id="add_typeDesc"
									placeholder="请输入分类描述" value=''></textarea>
								<label class="control-label" for="add_typeDesc"
									style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="add_type">
							添加</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>
	
	<!-------------------------分类修改模态框------------------------------------->
	<form class="form-horizontal">
		<!-- 保证样式书评不混乱 -->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="type_update" tabindex="-1" role="dialog"
			aria-labelledby="ModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="ModalLabel">修改分类</h4>
					</div>

					<div class="modal-body">
						<!--正文-->
						<div class="form-group">
							<label class="col-sm-3 control-label">分类名称</label>
							<div class="col-sm-7">
								<input type="hidden" id="update_typeId" value="">
								<input type="text" class="form-control" id="update_typeName"
									placeholder="请输入分类名称名称" value=""> <label
									class="control-label" for="update_typeName"
									style="display: none;"></label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">分类描述</label>
							<div class="col-sm-7">
								<textarea rows="3" class="form-control" id="update_typeDesc"
									placeholder="请输入分类描述" value=""></textarea>
								<label class="control-label" for="update_typeDesc"
									style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="button" class="btn btn-primary" id="update_type">
							修改</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</form>
	
	<!-- 底部 -->
	<jsp:include page="../public/footer.jsp"></jsp:include>
</body>
</html>