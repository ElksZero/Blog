function showArticle(theId){
	window.location.href = $("#basePath").val() + "article/show/" + theId
}
function publishArticle(theId){
	// 请求地址
	var path = $("#basePath").val() + "manage/articleManage/publishArticle";
	$.post(path,{id:theId},function(data){
		var code = data["code"];
		if(code == -1){
			showInfo("文章id不可为空");
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
function revokeArticle(theId){
	// 请求地址
	var path = $("#basePath").val() + "manage/articleManage/revokeArticle";
	$.post(path,{id:theId},function(data){
		var code = data["code"];
		if(code == -1){
			showInfo("文章id不可为空");
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
function deleteArticle(theId){
	// 请求地址
	var path = $("#basePath").val() + "manage/articleManage/deleteArticle";
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