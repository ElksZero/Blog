<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<html lang="en">
<head>
<meta charset="UTF-8">

<link href="<%=basePath%>static/images/favicon.ico" rel="shortcut icon" />
<title>文章</title>


<!-- bootstrap css -->
<link rel="stylesheet"
	href="<%=basePath%>static/bootstrap/css/bootstrap.css" />
<link rel="stylesheet"
	href="<%=basePath%>static/bootstrap/css/bootstrap-theme.css" />
<link rel="stylesheet"
	href="<%=basePath%>static/bootstrap/css/bootstrap-admin-theme.css" />
<!-- editormd css -->
<link rel="stylesheet"
	href="<%=basePath%>static/EditorMd/css/editormd.css" />
<!-- jquery -->
<script src="<%=basePath%>static/js/jquery/jquery-3.4.1.js"></script>
<!-- bootstrap js -->
<script src="<%=basePath%>static/bootstrap/js/bootstrap.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap-dropdown.min.js"></script>
<!-- editormd js -->
<script src="<%=basePath%>static/EditorMd/js/editormd.js"></script>
<link rel="stylesheet"
	href="<%=basePath%>static/css/article/my-article.css" />
<script type="text/javascript" src="<%=basePath%>static/js/show.js"></script>

<script src="<%=basePath%>static/EditorMd/lib/marked.min.js"></script>
<script src="<%=basePath%>static/EditorMd/lib/prettify.min.js"></script>
<script src="<%=basePath%>static/EditorMd/lib/raphael.min.js"></script>
<script src="<%=basePath%>static/EditorMd/lib/underscore.min.js"></script>
<script src="<%=basePath%>static/EditorMd/lib/sequence-diagram.min.js"></script>
<script src="<%=basePath%>static/EditorMd/lib/flowchart.min.js"></script>
<script src="<%=basePath%>static/EditorMd/lib/jquery.flowchart.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {//将markdown内容转变为html
		var wordsView;
		wordsView = editormd.markdownToHTML("MDEditor", {
			htmlDecode : "style,script,iframe", // you can filter tags decode
			emoji : true,
			taskList : true,
			tex : true, // 默认不解析
			flowChart : true, // 默认不解析
			sequenceDiagram : true, // 默认不解析
		});

	})
</script>
<!-- 加载评论编辑框 -->
<script type="text/javascript">
	var commentEditor;
	$(function() {
		//$.get('test.md', function(md){  //如果是放在网站程序中的可以打开注释

		commentEditor = editormd({
			id : "commentEditor",//注意：这里是上面DIV的id
			placeholder : "发表你的评论......",
			width : "95%",
			height : 200,
			syncScrolling : "single",
			path : "<%=basePath%>static/EditorMd/lib/",//建议使用绝对路径 ps:此处不完善，最好将前面的/Blog/变成一个动态的uri

			theme : "xq-light",
			previewTheme : "xq-light",
			editorTheme : "xq-light",
			//markdown : md,
			codeFold : true,
			saveHTMLToTextarea : true, // 保存 HTML 到 Textarea
			searchReplace : true,
			watch : false, // 关闭实时预览
			htmlDecode : "style,script,iframe|on*", // 开启 HTML 标签解析，为了安全性，默认不开启    
			toolbar  : false,             //关闭工具栏
			//previewCodeHighlight : false, // 关闭预览 HTML 的代码块高亮，默认开启
			emoji : false,
			taskList : true,
			//dialogLockScreen : false,   // 设置弹出层对话框不锁屏，全局通用，默认为true
			//dialogShowMask : false,     // 设置弹出层对话框显示透明遮罩层，全局通用，默认为true
			//dialogDraggable : false,    // 设置弹出层对话框不可拖动，全局通用，默认为true
			//dialogMaskOpacity : 0.4,    // 设置透明遮罩层的透明度，全局通用，默认值为0.1
			dialogMaskBgColor : "#000", // 设置透明遮罩层的背景颜色，全局通用，默认为#fff

		//}); 	//如果是放在网站程序中的可以打开注释
		});
	});
</script>
</head>
<body>
	<!-- 首部导航 -->
	<jsp:include page="../public/header.jsp"></jsp:include>

	<!-- 容器 -->
	<div class="container">
		<div class="row">
			<!-- 左侧菜单 -->
			<div class="col-md-2 bootstrap-admin-col-left">
				<ul class="nav navbar-collapse collapse bootstrap-admin-navbar-side">
					<li class="active"><a href="<%=basePath%>"> <i
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
					<li><a href="<%=basePath%>manage/articleCommentsManage"> <i
							class="glyphicon glyphicon-chevron-right"></i> 文章评论管理
					</a></li>
				</ul>
			</div>
			<div class="col-md-10 bootstrap-admin-col-right">

				<!-- 文章主题 -->
				<div class="panel panel-default bootstrap-admin-no-table-panel">
					<br>
					<!-- 标题 -->
					<div class="article_title_show">
						&emsp;
						<c:if test="${article != null }">${article.title}</c:if>
					</div>
					<!-- 标题下的分隔线 -->
					<div class="separator">
						<div class="text_in_separator">
							<span style="color: rgb(136, 136, 136);"> <c:if
									test="${article != null }">
								作者：${article.author_username} <!-- 分隔 -->
									<div class="diliver"></div> 发布时间：<fmt:formatDate
										value="${article.publishDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
									<div class="diliver"></div> 最新更新时间：<fmt:formatDate
										value="${article.publishDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
									<div class="diliver"></div>
									<c:if test="${article.author_id == userVo.id }">
										<a href="<%=basePath%>article/edit/${article.id}">编辑</a>
									</c:if>
								</c:if>
							</span>
						</div>
					</div>

					<!-- md文件编辑器编辑区域 -->
					<div id="MDEditor">
						<!-- 存放markdown文本内容，会自动被解析为HTML -->
						<!--  -->
						<!-- 注意textarea标签定义了一个一个多行的文本输入区域，
							多行文本就意味着代码中标签内的制表符换行符都是有效的。
							所以在这里${article.content}就不能有任何空格、换行、制表符
							之类的，不然可能会导致markdown代码无法被editormd插件正确解析
						 -->
						<textarea name="content" style="display: none;"><c:if
								test="${article != null }">${article.content}</c:if></textarea>
					</div>
				</div>

				<!-- 发表评论面板 -->
				<c:if test="${userVo != null }">
					<c:if test="${userVo.authorization.comment == 1 }">
						<div class="panel panel-default bootstrap-admin-no-table-panel">
							<div class="panel-heading">
								<div class="text-muted bootstrap-admin-box-title">发表评论</div>
							</div>
							<br>
							<!-- md文件编辑器编辑区域 -->
							<div id="commentEditor">
								<!-- 存放markdown文本内容，会自动被解析为HTML -->
								<textarea name="comment" style="display: none;"></textarea>

							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="col-sm-3 control-label"
										style="text-align: right; padding-top: 7px;">验证</label>
									<div class="col-sm-7">
										<c:if test="${article == null }">
											<input type="hidden" id="articleId" value="">
										</c:if>
										<c:if test="${article != null }">
											<input type="hidden" id="articleId" value="${article.id }">
										</c:if>
										<input type="password" class="form-control"
											id="confirm_commentPwd" placeholder="发表评论需进行密码验证" value=''>
										<label class="control-label" for="confirm_commentPwd"
											style="display: none;"></label>
									</div>
								</div>
							</div>
							<div class="col-md-2"></div>
							<div class="col-md-3">
								<div class="form-group">
									<button type="button" class="btn btn-primary form-control"
										id="submit_comment">提交</button>
								</div>
							</div>
							<div class="col-md-1"></div>
						</div>
					</c:if>
				</c:if>
				<c:if test="${pageInfo.list != null }">
					<!-- 评论模块 -->
					<div class="panel panel-default bootstrap-admin-no-table-panel">
						<div class="panel-heading">
							<div class="text-muted bootstrap-admin-box-title">评论</div>
						</div>
						<div class="row">
							<div class="col-md-1"></div>
							<div class="col-md-10">
								<br>
								<c:forEach items="${pageInfo.list }" var="comment">
									<div class="conmment_details">
										<div style="float: left;">
											<div class="comment_user">
												<a href="#"><i class="glyphicon glyphicon-user"></i>${comment.commenter_username }</a>
												<!--  -->
												<span class="comment_date">&emsp;<fmt:formatDate
														value="${comment.submitDate}"
														pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></span>
											</div>
										</div>
										<div style="float: right;">
											<c:if test="${comment.commenter_id == userVo.id }">
												<a href="#"><i class="glyphicon glyphicon-trash"></i>删除&emsp;</a>
											</c:if>
										</div>
										<br>
										<div class="comment_content">${comment.content }</div>
									</div>
									<hr>
								</c:forEach>
								<br>
							</div>
							<div class="col-md-11 pull-right">
								<!-- 分页 -->
								<script type="text/javascript">
									function page(pageNum) {
									window.location.href = "<%=basePath%>
									article/show/${article.id}?pageNum="
												+ pageNum
									}
								</script>
								<jsp:include page="../public/page.jsp" /></div>

						</div>

					</div>
				</c:if>
			</div>
		</div>

		<!-- 底部 -->
		<jsp:include page="../public/footer.jsp"></jsp:include>
</body>
</html>
