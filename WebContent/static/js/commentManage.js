function getCommentById(theId){
	//请求地址
	var path = $("#basePath").val() + "manage/articleCommentsManage/getCommentById"
	$.post(path,{id:theId},function(data){
		$("#comment_articleTitle").val(data.article_title);
		$("#comment_username").val(data.commenter_username);
		$("#comment_submitDate").val(data.submitDate);
		if(data.status == 0){
			$("#comment_publishDate").val("暂未审核");
			$("#comment_status").val("暂未审核");
			$("#comment_checkerUsername").val("暂未审核");
		}else{
			$("#comment_publishDate").val(data.publishDate);
			$("#comment_status").val(data.status);
			$("#comment_checkerUsername").val(data.checker_username);
		}
		$("#comment_content").val(data.content);	
	},"json")
}
function publishComment(theId){
	// 请求地址
	var path = $("#basePath").val() + "manage/articleCommentsManage/publishComment";
	$.post(path,{id:theId},function(data){
		var code = data["code"];
		if(code == -1){
			showInfo("评论id不可为空");
		}else if(code == -2){
			showInfo("发布失败");
		}else if(code == 1){
			showInfo("发布成功")
		}
	},"json")
	//监听模态框的关闭
	$("#modal_info").on("hide.bs.modal",function(){
		location.reload();//刷新当前的页面
	})
}

function revokeComment(theId){
	// 请求地址
	var path = $("#basePath").val() + "manage/articleCommentsManage/revokeComment";
	$.post(path,{id:theId},function(data){
		var code = data["code"];
		if(code == -1){
			showInfo("评论id不可为空");
		}else if(code == -2){
			showInfo("撤销失败");
		}else if(code == 1){
			showInfo("撤销成功")
		}
	},"json")
	//监听模态框的关闭
	$("#modal_info").on("hide.bs.modal",function(){
		location.reload();//刷新当前的页面
	})
}

function deleteComment(theId){
	// 请求地址
	var path = $("#basePath").val() + "manage/articleCommentsManage/deleteComment";
	$.post(path,{id:theId},function(data){
		var code = data["code"];
		if(code == -1){
			showInfo("文章id不可为空");
		}else if(code == -2){
			showInfo("删除失败");
		}else if(code == 1){
			showInfo("删除成功")
		}
	},"json")
	//监听模态框的关闭
	$("#modal_info").on("hide.bs.modal",function(){
		location.reload();//刷新当前的页面
	})
}