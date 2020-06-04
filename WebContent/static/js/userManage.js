$(function(){
	$("#add_user").click(function(){
		if(!validAdd()){
			return;
		}
		var path = $("#basePath").val() + "manage/userManage/addUser";
		$.post(path,{
			username:$.trim($("#add_username").val()),
			nickname:$.trim($("#add_nickname").val()),
			password:$.trim($("#add_password").val()),
			mobile_num:$.trim($("#add_phone").val()),
			email:$.trim($("#add_email").val())
			},function(data){
				$("#user_add").modal("hide");
				var code = data["code"]
				if(code == -1){
					showInfo("用户已存在");
				}else if(code == -2){
					showInfo("联系号码已存在");
				}else if(code == -3){
					showInfo("电子邮箱已存在");
				}else if(code == -4 || code == -5){
					showInfo("添加失败");
				}else if(code == 1){
					showInfo("添加成功")
				}			
			},"json")
			//监听模态框的关闭
			$("#modal_info").on("hide.bs.modal",function(){
				location.reload();//刷新当前的页面
			})
	})
	
	$("#update_user").click(function(){
		if(!validUpdateUser()){
			return;
		}
		var path = $("#basePath").val() + "manage/userManage/updateUser";
		$.post(path,{
			id:$.trim($("#user_update_id").val()),
			nickname:$.trim($("#update_nickname").val()),
			mobile_num:$.trim($("#update_phone").val()),
			email:$.trim($("#update_email").val())
			},function(data){
				$("#user_update").modal("hide");
				var code = data["code"];
				if(code == -1){
					showInfo("id不可为空");
				}else if(code == -2){
					showInfo("昵称不可为空");
				}else if(code == -3){
					showInfo("联系号码不可为空");
				}else if(code == -4){
					showInfo("电子邮箱不可为空");
				}else if(code == -5){
					showInfo("修改失败")
				}else if(code == 1){
					showInfo("修改成功")
					
		}},"json")
		//监听模态框的关闭
		$("#modal_info").on("hide.bs.modal",function(){
			location.reload();//刷新当前的页面
		})
	})
	$("#set_userpower").click(function(){
		var postData = "user_id="+$.trim($("#userpower_set_id").val());
	    //jquery获取复选框的值
	    $('input[name="power"]:checked').each(function () {
	        postData += "&"+ $.trim($(this).attr("id")) + "=1"
	    });
	    var path = $("#basePath").val() + "manage/userManage/setPower";
	    $.post(path,postData,function(data){
	    	$("#userpower_set").modal("hide");//隐藏模态框
	    	var code = data["code"];
	    	if(code == -1){
				showInfo("id不可为空");
			}else if(code == -2){
				showInfo("设置失败");
			}else if(code == 1){
				showInfo("设置成功")
			}
	    },"json")
	    //监听模态框的关闭
		$("#modal_info").on("hide.bs.modal",function(){
			location.reload();//刷新当前的页面
		})
	})
})
//校验添加表单
function validAdd(){
	var flag = true;
	//用户名
	var username = $.trim($("#add_username").val());
	var reg = new RegExp("^[a-zA-Z]\\w{5,11}$", "g");
	if(username == ""){
		$("#add_username").parent().addClass("has-error");
		$('#add_username').next().text("请输入用户名");
        $("#add_username").next().show();
        flag = false;
	}else if(!reg.test(username)){
		$("#add_username").parent().addClass("has-error");
		$('#add_username').next().text("应以字母开头，由长度6-12的字母或数字组成");
        $("#add_username").next().show();
        flag = false;
	}else {
        $('#add_username').parent().removeClass("has-error");
        $('#add_username').next().text("");
        $("#add_username").next().hide();
    }
	//昵称
	var nickname = $.trim($("#add_nickname").val());
	var reg = new RegExp("^[a-zA-Z0-9_\\u4e00-\\u9fa5]{2,10}$", "g");
	if(nickname == ""){
		$("#add_nickname").parent().addClass("has-error");
		$('#add_nickname').next().text("请输入昵称");
        $("#add_nickname").next().show();
        flag = false;
	}else if(!reg.test(nickname)){
		$("#add_nickname").parent().addClass("has-error");
		$('#add_nickname').next().text("昵称可接受范围2~16");
        $("#add_nickname").next().show();
        flag = false;
	}else {
        $('#add_nickname').parent().removeClass("has-error");
        $('#add_nickname').next().text("");
        $("#add_nickname").next().hide();
    }
	//密码
    var password = $.trim($("#add_password").val());
    if (password == "") {
        $('#add_password').parent().addClass("has-error");
        $('#add_password').next().text("请输入密码");
        $("#add_password").next().show();
        flag = false;
    } else if (password.length < 6 || password.length > 18) {
        $("#add_password").parent().addClass("has-error");
        $("#add_password").next().text("密码长度必须在6~18之间");
        $("#add_password").next().show();
        flag = false;
    } else {
        $('#add_password').parent().removeClass("has-error");
        $('#add_password').next().text("");
        $("#add_password").next().hide();
    }
    //验证密码
    var confirmPwd = $.trim($("#add_confirmPwd").val());
    if (confirmPwd != password) {
        $('#add_confirmPwd').parent().addClass("has-error");
        $('#add_confirmPwd').next().text("两次密码不一致");
        $("#add_confirmPwd").next().show();
        flag = false;
    } else {
        $('#add_confirmPwd').parent().removeClass("has-error");
        $('#add_confirmPwd').next().text("");
        $("#add_confirmPwd").next().hide();
    }
    //联系号码
    var phone = $.trim($("#add_phone").val());
    if (phone == "") {
        $('#add_phone').parent().addClass("has-error");
        $('#add_phone').next().text("请输入联系号码");
        $("#add_phone").next().show();
        flag = false;
    } else if (!(/^1[34578]\d{9}$/.test(phone))) {
        //电话号码格式的校验
        $('#add_phone').parent().addClass("has-error");
        $('#add_phone').next().text("手机号码有误");
        $("#add_phone").next().show();
        return false;
    } else {
        $('#add_phone').parent().removeClass("has-error");
        $('#add_phone').next().text("");
        $("#add_phone").next().hide();
    }
    //电子邮箱
    var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
    var email = $.trim($("#add_email").val());
    if (email == "") {
        $('#add_email').parent().addClass("has-error");
        $('#add_email').next().text("请输入邮箱");
        $("#add_email").next().show();
        flag = false;
    } else if (!reg.test(email)) {
        //邮箱格式的校验
        $('#add_email').parent().addClass("has-error");
        $('#add_email').next().text("邮箱格式有误");
        $("#add_email").next().show();
        return false;
    } else {
        $('#add_email').parent().removeClass("has-error");
        $('#add_email').next().text("");
        $("#add_email").next().hide();
    }
    return flag;
}

//通过id获取用户信息//预设初始值
function getUserById(theId){
	//请求地址
	var path = $("#basePath").val() + "manage/userManage/getUserById";
	$.post(path,{id:theId},function(data){
		$("#user_update_id").val(theId);
		$("#update_username").val(data["user"].username);
		$("#update_nickname").val(data["user"].nickname);
		$("#update_phone").val(data["user"].mobile_num);
		$("#update_email").val(data["user"].email);
	},"json")
}
//校验更新表单
function validUpdateUser(){
	var flag = true;
	//用户名
	var username = $.trim($("#update_username").val());
	var reg = new RegExp("^[a-zA-Z]\\w{5,11}$", "g");
	if(username == ""){
		$("#update_username").parent().addClass("has-error");
		$('#update_username').next().text("请输入用户名");
        $("#update_username").next().show();
        flag = false;
	}else if(!reg.test(username)){
		$("#update_username").parent().addClass("has-error");
		$('#update_username').next().text("应以字母开头，由长度6-12的字母或数字组成");
        $("#update_username").next().show();
        flag = false;
	}else {
        $('#update_username').parent().removeClass("has-error");
        $('#update_username').next().text("");
        $("#update_username").next().hide();
    }
	//昵称
	var nickname = $.trim($("#update_nickname").val());
	var reg = new RegExp("^[a-zA-Z0-9_\\u4e00-\\u9fa5]{2,10}$", "g");
	if(nickname == ""){
		$("#update_nickname").parent().addClass("has-error");
		$('#update_nickname').next().text("请输入昵称");
        $("#update_nickname").next().show();
        flag = false;
	}else if(!reg.test(nickname)){
		$("#update_nickname").parent().addClass("has-error");
		$('#update_nickname').next().text("昵称可接受范围2~16");
        $("#update_nickname").next().show();
        flag = false;
	}else {
        $('#update_nickname').parent().removeClass("has-error");
        $('#update_nickname').next().text("");
        $("#update_nickname").next().hide();
    }

    //联系号码
    var phone = $.trim($("#update_phone").val());
    if (phone == "") {
        $('#update_phone').parent().addClass("has-error");
        $('#update_phone').next().text("请输入联系号码");
        $("#update_phone").next().show();
        flag = false;
    } else if (!(/^1[345789]\d{9}$/.test(phone))) {
        //电话号码格式的校验
        $('#update_phone').parent().addClass("has-error");
        $('#update_phone').next().text("手机号码有误");
        $("#update_phone").next().show();
        return false;
    } else {
        $('#update_phone').parent().removeClass("has-error");
        $('#update_phone').next().text("");
        $("#update_phone").next().hide();
    }
    //电子邮箱
    var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
    var email = $.trim($("#update_email").val());
    if (email == "") {
        $('#update_email').parent().addClass("has-error");
        $('#update_email').next().text("请输入邮箱");
        $("#update_email").next().show();
        flag = false;
    } else if (!reg.test(email)) {
        //邮箱格式的校验
        $('#update_email').parent().addClass("has-error");
        $('#update_email').next().text("邮箱格式有误");
        $("#update_email").next().show();
        return false;
    } else {
        $('#update_email').parent().removeClass("has-error");
        $('#update_email').next().text("");
        $("#update_email").next().hide();
    }
    return flag;
}
function deleteUserById(theId){
	var path = $("#basePath").val() + "manage/userManage/deleteUser";
	$.post(path,{id:theId},function(data){
		var code = data["code"];
		if(code == -1){
			showInfo("用户id不可为空");
		}else if(code == -2){
			showInfo("删除失败");
		}else if(code == -3){
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
function getAuthorizationById(theId){
	//请求地址
	var path = $("#basePath").val() + "manage/userManage/getAuthorizationById"
	$.post(path,{id:theId},function(data){
		$("#userpower_set_id").val(theId);
        $('input[name="power"]').removeAttr("checked");//取消全选
        if (data.write != 0) {
            $("#write").attr("checked", "checked");
        }
        if (data.comment != 0) {
            $("#comment").attr("checked", "checked");
        }

        if (data.labelSet != 0) {
            $("#labelSet").attr("checked", "checked");
        }
        if (data.typeSet != 0) {
            $("#typeSet").attr("checked", "checked");
        }
        if (data.articleSet != 0) {
            $("#articleSet").attr("checked", "checked");
        }
        if (data.commentSet != 0) {
            $("#commentSet").attr("checked", "checked");
        }
        if (data.userSet != 0) {
            $("#userSet").attr("checked", "checked");
        }

	},"json")
}
