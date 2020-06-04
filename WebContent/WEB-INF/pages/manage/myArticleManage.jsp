<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>文章管理</title>

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

<script src="<%=basePath%>static/js/myArticleManage.js"></script>
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
					<li class="active"><a
						href="<%=basePath%>manage/myArticleManage"> <i
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
									action="<%=basePath%>manage/myArticleManage" method="post">
									<div class="col-lg-5 form-group">
										<label class="col-lg-4 control-label">文章标题</label>
										<div class="col-lg-8">
											<label for="articleTitle"></label><input class="form-control"
												id="possible_title" name="possible_title" type="text" value="${possible_title}"/> <label
												class="control-label" style="display: none;"></label>
										</div>
									</div>

									<div class="col-lg-5 form-group">
										<label class="col-lg-4 control-label">文章分类</label>
										<div class="col-lg-8">
											<label for="possible_title"></label>
											<c:if test="${types != null }">
												<select class="form-control" id="possible_type"
													name="possible_type">
													<c:forEach items="${types }" var="type">
														<c:if test="${possible_type == type.id}">
															<option value="${type.id }" selected="selected">${type.name }</option>
														</c:if>
														<c:if test="${possible_type != type.id}">
															<option value="${type.id }">${type.name }</option>
														</c:if>
													</c:forEach>
												</select>
											</c:if>
										</div>
									</div>
									<div class="col-lg-2 form-group">
										<button type="submit" class="btn btn-primary ">查询</button>
										<button type="button" class="btn btn-primary "
											id="createArticle">添加</button>
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
									<th>文章类型</th>
									<th>创建时间</th>
									<th>文章状态</th>
									<th>审核人员</th>
									<th>操作</th>
								</tr>
							</thead>


							<tbody>
								<c:if test="${pageInfo.list != null }">
									<c:forEach items="${pageInfo.list }" var="article">
										<tr>
											<td>${article.title }</td>
											<td>${article.type_name }</td>
											<td><fmt:formatDate value="${article.createDate }" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
											<td>
												<c:choose>
													<c:when test="${article.status == 0 }">未完成</c:when>
													<c:when test="${article.status == 1 }">未审核</c:when>
													<c:otherwise>已发布</c:otherwise>
												</c:choose>
											</td>
											<td>
												<c:if test="${article.checker_id != null }">${article.checker_username}</c:if>
												<c:if test="${article.checker_id == null }">暂未审核</c:if>
											</td>
											<td>
												<button type="button" class="btn btn-info btn-xs" onclick="showArticle(${article.id})">查看</button>
												<button type="button" class="btn btn-danger btn-xs" onclick="deleteArticle(${article.id})">删除</button>
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
										<button type="button" class="btn btn-info btn-xs"
											data-toggle="modal" data-target="#findModal"
											onclick="getBookInfo()">查看</button>
										<button type="button" class="btn btn-danger btn-xs"
											onclick="addBookNum()" data-toggle="modal"
											data-target="#addNumModal">删除</button>
									</td>
								</c:if>
							</tbody>
						</table>
						<!-- 分页 -->
						<script type="text/javascript">
							function page(pageNum) {
								window.location.href = "<%=basePath%>manage/myArticleManage?pageNum="
										+ pageNum
										+ "&possible_title=${possible_title}&possible_type=${possible_type}";
							}
						</script>
						<jsp:include page="../public/page.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 底部 -->
	<jsp:include page="../public/footer.jsp"></jsp:include>
</body>
</html>