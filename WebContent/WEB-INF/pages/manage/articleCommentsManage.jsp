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
<title>文章评论管理</title>


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
<script src="<%=basePath%>static/js/commentManage.js"></script>
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
					<li><a href="<%=basePath%>manage/articleTypesManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 文章类别管理
					</a></li>
					<li><a href="<%=basePath%>manage/articleLabelsManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 文章标签管理
					</a></li>
					<li class="active"><a
						href="<%=basePath%>manage/articleCommentsManage"> <i
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
								<form class="form-horizontal" action="<%=basePath%>manage/articleCommentsManage" method="get">
									<div class="col-lg-5 form-group">
										<label class="col-lg-4 control-label">文章标题</label>
										<div class="col-lg-8">
											<label for="possible_title"></label><input class="form-control"
												id="possible_title" name="possible_title" type="text" value="${possible_title }"/> <label
												class="control-label" style="display: none;"></label>
										</div>
									</div>

									<div class="col-lg-5 form-group">
										<label class="col-lg-4 control-label">评论用户</label>
										<div class="col-lg-8">
											<label for="autho"></label><input class="form-control"
												id="possible_commenter" name="possible_commenter" type="text" value="${possible_commenter }"> <label
												class="control-label" style="display: none;"></label>
										</div>
									</div>


									<div class="col-lg-2 form-group">
										<div class="form-group" style="float: right;">
											<button type="submit" class="btn btn-primary">查询</button>
										</div>
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
									<th>文章标题</th>
									<th>评论用户</th>
									<th>评论状态</th>
									<th>操作</th>

								</tr>
							</thead>


							<tbody>
								<c:if test="${pageInfo.list != null}">
									<c:forEach items="${pageInfo.list }" var="comment">
										<tr>
											<td>${comment.article_title }</td>
											<td>${comment.commenter_username }</td>
											<td>
												<c:if test="${comment.status == 0 }">
													未审核
												</c:if>
												<c:if test="${comment.status == 1 }">
													审核通过
												</c:if>
											</td>
											<td>
												<button type="button" class="btn btn-info btn-xs" 
													data-toggle="modal" data-target="#findCommentModal"
													onclick="getCommentById(${comment.id})">
													查看
												</button>
												<button type="button" class="btn btn-success btn-xs" onclick="publishComment(${comment.id})">发布</button>
												<button type="button" class="btn btn-warning btn-xs" onclick="revokeComment(${comment.id})">撤销</button>
												<button type="button" class="btn btn-danger btn-xs" onclick="deleteComment(${comment.id})">删除</button>
											</td>
										<tr>
									</c:forEach>
								</c:if>
								<c:if test="${pageInfo.list == null}">
									<td>暂无数据</td>
									<td>暂无数据</td>
									<td>暂无数据</td>
									<td>
										<button type="button" class="btn btn-info btn-xs"
											data-toggle="modal" data-target="#findCommentModal">
											查看</button>
										<button type="button" class="btn btn-success btn-xs">发布</button>
										<button type="button" class="btn btn-warning btn-xs">撤销</button>
										<button type="button" class="btn btn-danger btn-xs">删除</button>
									</td>
								</c:if>
							</tbody>
						</table>
						<!-- 分页 -->
						<script type="text/javascript">
							function page(pageNum) {
								window.location.href = "<%=basePath%>manage/articleCommentsManage?pageNum="
										+ pageNum
										+ "&possible_title=${possible_title}&possible_commenter=${possible_commenter}";
							}
						</script>
						<jsp:include page="../public/page.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-------------------------查看评论模态框------------------------------------->
	<form class="form-horizontal">
		<!-- 保证样式书评不混乱 -->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="findCommentModal" tabindex="-1"
			role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="ModalLabel">用户评论</h4>
					</div>

					<div class="modal-body">
						<!--正文-->
						<div class="form-group">
							<label class="col-sm-3 control-label">文章标题</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="comment_articleTitle" readonly="readonly" value=''>
								<label class="control-label" for="comment_articleTitle" style="display: none;"></label>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-3 control-label">评论用户</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="comment_username" readonly="readonly"  value=''> 
								<label class="control-label" for="comment_username" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">评论时间</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="comment_submitDate" readonly="readonly"  value=''> 
								<label class="control-label" for="comment_submitDate" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">发布时间</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="comment_publishDate" readonly="readonly"  value=''> 
								<label class="control-label" for="comment_publishDate" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">评论状态</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="comment_status" readonly="readonly" value=''> 
								<label class="control-label" for="comment_status" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">评论内容</label>
							<div class="col-sm-7">
								<textarea rows="3" class="form-control" id="comment_content" readonly="readonly" value=''></textarea>
								<label class="control-label" for="comment_content" style="display: none;"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">审核人员</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="comment_checkerUsername" readonly="readonly" value=''> 
								<label class="control-label" for="comment_checker" style="display: none;"></label>
							</div>
						</div>
						<!--正文-->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
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