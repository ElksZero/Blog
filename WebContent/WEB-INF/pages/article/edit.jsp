<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="<%=basePath%>static/images/favicon.ico" rel="shortcut icon" />
<title>编辑</title>

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
<script src="<%=basePath%>static/js/edit.js"></script>
<!-- 加载 markdown 编辑器 -->
<script type="text/javascript">
	var MDEditor;
	$(function() {
		//$.get('test.md', function(md){  //如果是放在网站程序中的可以打开注释

		MDEditor = editormd({
			id : "MDEditor", //注意：这里是上面DIV的id
			placeholder : "开始你的创作吧......",
			width : "95%",
			height : 600,
			syncScrolling : "single",
			emoji : true,
			path : "<%=basePath%>static/EditorMd/lib/", //建议使用绝对路径 

			theme : "xq-light",
			previewTheme : "xq-light",
			editorTheme : "xq-light",
			//markdown : md,
			codeFold : false,
			saveHTMLToTextarea : true, // 保存 HTML 到 Textarea
			searchReplace : true,
			//watch : false,                // 关闭实时预览
			htmlDecode : "style,script,iframe|on*", // 开启 HTML 标签解析，为了安全性，默认不开启    
			//toolbar  : false,             //关闭工具栏
			//previewCodeHighlight : false, // 关闭预览 HTML 的代码块高亮，默认开启
			//emoji: true,
			taskList : true,
			tocm : true, // Using [TOCM]
			tex : true, // 开启科学公式TeX语言支持，默认关闭
			flowChart : true, // 开启流程图支持，默认关闭
			sequenceDiagram : true, // 开启时序/序列图支持，默认关闭,
			//dialogLockScreen : false,   // 设置弹出层对话框不锁屏，全局通用，默认为true
			//dialogShowMask : false,     // 设置弹出层对话框显示透明遮罩层，全局通用，默认为true
			//dialogDraggable : false,    // 设置弹出层对话框不可拖动，全局通用，默认为true
			//dialogMaskOpacity : 0.4,    // 设置透明遮罩层的透明度，全局通用，默认值为0.1
			dialogMaskBgColor : "#000", // 设置透明遮罩层的背景颜色，全局通用，默认为#fff

			/**上传图片相关配置如下*/
			imageUpload : true,
			imageFormats : [ "jpg", "jpeg", "gif", "png", "bmp", "webp" ],
			imageUploadURL : "<%=basePath%>uploadImg/", //注意你后端的上传图片服务地址
		// onload: function() {
		// 	// console.log('onload', this);
		// 	// this.fullscreen();
		// 	// this.unwatch();
		// 	// this.watch().fullscreen();

		// 	// this.setMarkdown("#PHP");
		// 	// this.width("100%");
		// 	// this.height(480);
		// 	// this.resize("100%", 640);
		// }
		//}); 	//如果是放在网站程序中的可以打开注释
		});
	});
</script>

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
			<!-- 右侧主体 -->
			<div class="col-md-10 ">
				<!-- 面板 -->
				<div class="panel panel-default bootstrap-admin-no-table-panel">
					<div class="panel-heading">
						<div class="text-muted bootstrap-admin-box-title">设置</div>
					</div>
					<div
						class="bootstrap-admin-no-table-panel-content bootstrap-admin-panel-content collapse in">

						<form class="form-horizontal" action="#" method="post">
							<div class="col-lg-6 form-group">
								<label class="col-lg-4 control-label">标题</label>
								<div class="col-lg-8">
									<c:if test="${article != null }">
									<input class="form-control" type="text" id="articleTitle"
										name="articleTitle" placeholder="请输入文章标题" value="${article.title }"> 
									<label class="control-label" for="articleTitle" style="display: none; "></label>
									</c:if>
									<c:if test="${article == null }">
									<input class="form-control" type="text" id="articleTitle"
										name="articleTitle" placeholder="请输入文章标题" > 
									<label class="control-label" for="articleTitle" style="display: none; "></label>
									</c:if>
								</div>
							</div>
							<!-- 分类 -->
							<div class="col-lg-6 form-group">
								<label class="col-lg-4 control-label">分类</label>
								<div class="col-lg-8">
									<c:if test="${types != null }">
									<select class="form-control" id="articleTypes"
										name="articleTypes">
										<c:forEach items="${types }" var="type">
											<c:if test="${article != null }">
												<c:if test="${article.type_id == type.id }">
												<option value="${type.id }" selected="selected">${type.name }</option>
											</c:if>
											<c:if test="${article.type_id != type.id }">
												<option value="${type.id }">${type.name }</option>
											</c:if>
											</c:if>
											<c:if test="${article == null }">
												<option value="${type.id }">${type.name }</option>
											</c:if>
										</c:forEach>
									</select> 
									</c:if>
									<label class="control-label" for="articleTypes" style="display: none;"></label>
								</div>
							</div>
							<!-- 标签 -->
							<div class="col-lg-8 form-group">
								<label class="col-lg-3 control-label">标签</label>
								<div class="col-lg-8">
									<input class="form-control" type="text" id="articleLabels"
										name="articleLabels" placeholder="请输入文章标签,以';'为间隔" value="${labels }"> <label
										class="control-label" for="articleLabels"
										style="display: none;"></label>
								</div>
							</div>
							<div class="col-lg-4 form-group">
								<c:if test="${article == null}">
									<button type="button" class="btn btn-primary" onclick="saveArticle1()" >保存</button>
									<button type="button" class="btn btn-primary" onclick="submitArticle1()" >提交</button>
								</c:if>
								<c:if test="${article != null }">
									<button type="button" class="btn btn-primary" onclick="saveArticle2(${article.id})" >保存</button>
									<button type="button" class="btn btn-primary" onclick="submitArticle2(${article.id})" >提交</button>
								</c:if>
							</div>
						</form>
					</div>
				</div>

				<!-- Markdown编辑器 -->
				<div class="panel panel-default">
					<div class="bootstrap-admin-panel-content">
						<!-- md文件编辑器编辑区域 后续js中会使用到 -->
						<div id="MDEditor">
							<!-- 存放markdown文本内容，会自动被解析为HTML -->
							<textarea name="content" style="display: none;"><c:if test="${article != null }">${article.content }</c:if></textarea>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	<!-- 底部 -->
	<jsp:include page="../public/footer.jsp"></jsp:include>
</body>
</html>