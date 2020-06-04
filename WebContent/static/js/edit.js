function submitArticle1() {
	if (!validTitle()) {// 校验标题
		return;
	}
	var article = MDEditor.getMarkdown();
	
	// 请求地址
	var path = $("#basePath").val() + "article/submitArticle";
	$.post(path, {
		title : $.trim($("#articleTitle").val()),
		type_id : $.trim($("#articleTypes").val()),
		content : article,
		labels : $.trim($("#articleLabels").val())
	}, function(data) {
		var code = data["code"];
		if (code == -1) {
			showInfo("提交失败")
		} else if (code == 1) {
			showInfo("提交成功")
		}
	},"json")
	// 监听模态框的关闭
	$("#modal_info").on("hide.bs.modal", function() {
		window.location.href = $("#basePath").val() + "manage/myArticleManage";
	})

}
function saveArticle1() {
	if (!validTitle()) {// 校验标题
		return;
	}

	var article = MDEditor.getMarkdown();

	// 请求地址
	var path = $("#basePath").val() + "article/saveArticle";
	$.post(path, {
		title : $.trim($("#articleTitle").val()),
		type_id : $.trim($("#articleTypes").val()),
		content : article,
		labels : $.trim($("#articleLabels").val())
	}, function(data) {
		var code = data["code"];
		if (code == -1) {
			showInfo("保存失败")
		} else if (code == 1) {
			showInfo("保存成功")
		}
	})
	// 监听模态框的关闭
	$("#modal_info").on("hide.bs.modal", function() {
		window.location.href = $("#basePath").val() + "manage/myArticleManage";
	},"json")
}

function submitArticle2(theId) {
	if (!validTitle()) {// 校验标题
		return;
	}

	// 将url中特殊符号全都转义
	var article = MDEditor.getMarkdown();

	// 请求地址
	var path = $("#basePath").val() + "article/submitArticle/"+theId;
	$.post(path, {
		title : $.trim($("#articleTitle").val()),
		type_id : $.trim($("#articleTypes").val()),
		content : article,
		labels : $.trim($("#articleLabels").val())
	}, function(data) {
		var code = data["code"];
		if (code == -1) {
			showInfo("提交失败")
		} else if (code == 1) {
			showInfo("提交成功")
		}
	},"json")
	// 监听模态框的关闭
	$("#modal_info").on("hide.bs.modal", function() {
		window.location.href = $("#basePath").val() + "manage/myArticleManage";
	})

}
function saveArticle2(theId) {
	if (!validTitle()) {// 校验标题
		return;
	}

	var article = MDEditor.getMarkdown();

	// 请求地址
	var path = $("#basePath").val() + "article/saveArticle/"+theId;
	$.post(path, {
		title : $.trim($("#articleTitle").val()),
		type_id : $.trim($("#articleTypes").val()),
		content : article,
		labels : $.trim($("#articleLabels").val())
	}, function(data) {
		var code = data["code"];
		if (code == -1) {
			showInfo("保存失败")
		} else if (code == 1) {
			showInfo("保存成功")
		}
	},"json")
	// 监听模态框的关闭
	$("#modal_info").on("hide.bs.modal", function() {
		window.location.href = $("#basePath").val() + "manage/myArticleManage";
	})
}

// 校验标题
function validTitle() {
	var flag = true;
	var title = $.trim($("#articleTitle").val());
	var reg = new RegExp("^[a-zA-Z0-9_\\u4e00-\\u9fa5]{2,10}$", "g");
	if (title == "") {
		$("#articleTitle").parent().addClass("has-error");
		$('#articleTitle').next().text("请输入标题");
		$("#articleTitle").next().show();
		flag = false;
	} else if (!reg.test(title)) {
		$("#articleTitle").parent().addClass("has-error");
		$('#articleTitle').next().text("标题可接受范围:2~10");
		$("#articleTitle").next().show();
		flag = false;
	} else {
		$('#articleTitle').parent().removeClass("has-error");
		$('#articleTitle').next().text("");
		$("#articleTitle").next().hide();
	}
	var labels = $.trim($("#articleLabels").val());
	if (labels.length > 25) {
		$("#articleLabels").parent().addClass("has-error");
		$('#articleLabels').next().text("标签最大长度:25");
		$("#articleLabels").next().show();
		flag = false;
	} else {
		$('#articleTitle').parent().removeClass("has-error");
		$('#articleTitle').next().text("");
		$("#articleTitle").next().hide();
	}
	return flag;
}