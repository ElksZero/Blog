$(function(){
	$("#submit_comment").click(function(){
		var comment = commentEditor.getMarkdown();
		if(!validComment(comment)){
			return;
		}
		

		// 请求地址
		var path = $("#basePath").val() + "manage/submitComment";
		$.post(path, {
			article_id : $.trim($("#articleId").val()),
			content : comment,
			pwd : $.trim($("#confirm_commentPwd").val())
			}, function(data) {
			var code = data["code"];
			if (code == -1) {
				showInfo("密码错误")
			} else if (code == -2) {
				showInfo("提交失败")
			} else if (code == 1) {
				showInfo("提交成功")
			}
		},"json")
		//监听模态框的关闭
		$("#modal_info").on("hide.bs.modal",function(){
			location.reload();//刷新当前的页面
		})
	})
})

function validComment(comment){
	var flag = true;
	if(comment ==""){
		showInfo("评论不可为空");
	    flag = false;
	}else if(comment.length > 500){
		showInfo("评论长度不可超过500");
	    flag = false;
	}
	
    var password = $.trim($("#confirm_commentPwd").val());
    if (password == "") {
        $('#confirm_commentPwd').parent().addClass("has-error");
        $('#confirm_commentPwd').next().text("请输入密码");
        $("#confirm_commentPwd").next().show();
        flag = false;
    } else if (password.length < 6 || password.length > 18) {
        $("#confirm_commentPwd").parent().addClass("has-error");
        $("#confirm_commentPwd").next().text("密码长度必须在6~18之间");
        $("#confirm_commentPwd").next().show();
        flag = false;
    } else {
        $('#confirm_commentPwd').parent().removeClass("has-error");
        $('#confirm_commentPwd').next().text("");
        $("#confirm_commentPwd").next().hide();
    }
    return flag;
}