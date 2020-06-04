$(function(){
	//注册
	$("#register").click(function(){
		if(!validRegister()){
			return;
		}
		var path = $("#basePath").val() + "user/register";
		$.post(path,{
				username:$.trim($("#register_username").val()),
				nickname:$.trim($("#register_nickname").val()),
				password:$.trim($("#register_password").val()),
				mobile_num:$.trim($("#register_phone").val()),
				email:$.trim($("#register_email").val())
				},function(data){
					$("#user_register").modal("hide");
					var code = data["code"]
					if(code == -1){
						showInfo("用户已存在");
					}else if(code == -2){
						showInfo("联系号码已存在");
					}else if(code == -3){
						showInfo("电子邮箱已存在");
					}else if(code == -4 || code == -5){
						showInfo("注册失败");
					}else if(code == 1){
						showInfo("注册成功")
						//自动登录
						$.post($("#basePath").val() + "user/login",{username:$.trim($("#register_username").val()),password:$.trim($("#register_password").val())},function(data){},"json")
					}			
				},"json")
				//监听模态框的关闭
				$("#modal_info").on("hide.bs.modal",function(){
					location.reload();//刷新当前的页面
				})
	})
	//登录
	$("#login").click(function(){
		if(!validLogin()){
			return;
		}
		var path = $("#basePath").val() + "user/login";
		$.post(path,{
				username:$.trim($("#login_username").val()),
				password:$.trim($("#login_password").val())
				},function(data){
					$("#user_login").modal("hide");
					var code = data["code"];
					if(code == -1){
						showInfo("用户名不可为空");
					}else if(code == -2){
						showInfo("密码不可为空");
					}else if(code == -3){
						showInfo("用户不存在");
					}else if(code == -4){
						showInfo("密码错误");
					}else if(code == 1){
						showInfo("登录成功")
					}},"json")
		//监听模态框的关闭
		$("#modal_info").on("hide.bs.modal",function(){
			location.reload();//刷新当前的页面window.location.href = $("#basePath").val();
		})
	})
	$("#logout").click(function(){
		var path = $("#basePath").val() + "user/logout";
		$.post(path,function(){
			showInfo("登出成功")
		})
//		alert(1)
		//监听模态框的关闭
		$("#modal_info").on("hide.bs.modal",function(){
			window.location.href = $("#basePath").val();//返回首页页面
		})
	})
	//修改个人信息
	$("#update_userInfo").click(function(){
		if(!validInfo()){
			return;
		}
		var path = $("#basePath").val() + "user/updateinfo";
		$.post(path,{
			id:$.trim($("#user_updateinfo_id").val()),
			nickname:$.trim($("#info_nickname").val()),
			mobile_num:$.trim($("#info_phone").val()),
			email:$.trim($("#info_email").val())
			},function(data){
				$("#user_updateinfo").modal("hide");
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
	//修改密码
	$("#update_userpwd").click(function(){
		if(!validPassword()){
			return;
		}
		var path = $("#basePath").val() + "user/updatepwd";
		$.post(path,{
			id:$.trim($("#user_updatepwd_id").val()),
			oldPwd:$.trim($("#user_oldPwd").val()),
			newPwd:$.trim($("#user_newPwd").val())
			},function(data){
				$("#user_updatepwd").modal("hide");
				var code = data["code"];
				if(code == -1){
					showInfo("id不可为空");
				}else if(code == -2){
					showInfo("用户不存在");
				}else if(code == -3){
					showInfo("密码错误");
				}else if(code == -4){
					showInfo("修改失败");
				}else if(code == 1){
					showInfo("修改成功")
					
		}},"json")
		//监听模态框的关闭
		$("#modal_info").on("hide.bs.modal",function(){
			location.reload();//刷新当前的页面
		})
	})
})

//校验注册表单
function validRegister(){
	var flag = true;
	//用户名
	var username = $.trim($("#register_username").val());
	var reg = new RegExp("^[a-zA-Z]\\w{5,11}$", "g");
	if(username == ""){
		$("#register_username").parent().addClass("has-error");
		$('#register_username').next().text("请输入用户名");
        $("#register_username").next().show();
        flag = false;
	}else if(!reg.test(username)){
		$("#register_username").parent().addClass("has-error");
		$('#register_username').next().text("应以字母开头，由长度6-12的字母或数字组成");
        $("#register_username").next().show();
        flag = false;
	}else {
        $('#register_username').parent().removeClass("has-error");
        $('#register_username').next().text("");
        $("#register_username").next().hide();
    }
	//昵称
	var nickname = $.trim($("#register_nickname").val());
	var reg = new RegExp("^[a-zA-Z0-9_\\u4e00-\\u9fa5]{2,10}$", "g");
	if(nickname == ""){
		$("#register_nickname").parent().addClass("has-error");
		$('#register_nickname').next().text("请输入昵称");
        $("#register_nickname").next().show();
        flag = false;
	}else if(!reg.test(nickname)){
		$("#register_nickname").parent().addClass("has-error");
		$('#register_nickname').next().text("昵称可接受范围2~16");
        $("#register_nickname").next().show();
        flag = false;
	}else {
        $('#register_nickname').parent().removeClass("has-error");
        $('#register_nickname').next().text("");
        $("#register_nickname").next().hide();
    }
	//密码
    var password = $.trim($("#register_password").val());
    if (password == "") {
        $('#register_password').parent().addClass("has-error");
        $('#register_password').next().text("请输入密码");
        $("#register_password").next().show();
        flag = false;
    } else if (password.length < 6 || password.length > 18) {
        $("#register_password").parent().addClass("has-error");
        $("#register_password").next().text("密码长度必须在6~18之间");
        $("#register_password").next().show();
        flag = false;
    } else {
        $('#register_password').parent().removeClass("has-error");
        $('#register_password').next().text("");
        $("#register_password").next().hide();
    }
    //验证密码
    var confirmPwd = $.trim($("#register_confirmPwd").val());
    if (confirmPwd != password) {
        $('#register_confirmPwd').parent().addClass("has-error");
        $('#register_confirmPwd').next().text("两次密码不一致");
        $("#register_confirmPwd").next().show();
        flag = false;
    } else {
        $('#register_confirmPwd').parent().removeClass("has-error");
        $('#register_confirmPwd').next().text("");
        $("#register_confirmPwd").next().hide();
    }
    //联系号码
    var phone = $.trim($("#register_phone").val());
    if (phone == "") {
        $('#register_phone').parent().addClass("has-error");
        $('#register_phone').next().text("请输入联系号码");
        $("#register_phone").next().show();
        flag = false;
    } else if (!(/^1[34578]\d{9}$/.test(phone))) {
        //电话号码格式的校验
        $('#register_phone').parent().addClass("has-error");
        $('#register_phone').next().text("手机号码有误");
        $("#register_phone").next().show();
        return false;
    } else {
        $('#register_phone').parent().removeClass("has-error");
        $('#register_phone').next().text("");
        $("#register_phone").next().hide();
    }
    //电子邮箱
    var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
    var email = $.trim($("#register_email").val());
    if (email == "") {
        $('#register_email').parent().addClass("has-error");
        $('#register_email').next().text("请输入邮箱");
        $("#register_email").next().show();
        flag = false;
    } else if (!reg.test(email)) {
        //邮箱格式的校验
        $('#register_email').parent().addClass("has-error");
        $('#register_email').next().text("邮箱格式有误");
        $("#register_email").next().show();
        return false;
    } else {
        $('#register_email').parent().removeClass("has-error");
        $('#register_email').next().text("");
        $("#register_email").next().hide();
    }
    return flag;
}
//校验登录表单
function validLogin(){
	var flag = true;
	//用户名
	var username = $.trim($("#login_username").val());
	var reg = new RegExp("^[a-zA-Z]\\w{5,11}$", "g");
	if(username == ""){
		$("#login_username").parent().addClass("has-error");
		$('#login_username').next().text("请输入用户名");
        $("#login_username").next().show();
        flag = false;
	}else if(!reg.test(username)){
		$("#login_username").parent().addClass("has-error");
		$('#login_username').next().text("应以字母开头，由长度6-12的字母或数字组成");
        $("#login_username").next().show();
        flag = false;
	}else {
        $('#login_username').parent().removeClass("has-error");
        $('#login_username').next().text("");
        $("#login_username").next().hide();
    }
	
	//密码
    var password = $.trim($("#login_password").val());
    if (password == "") {
        $('#login_password').parent().addClass("has-error");
        $('#login_password').next().text("请输入密码");
        $("#login_password").next().show();
        flag = false;
    } else if (password.length < 6 || password.length > 18) {
        $("#login_password").parent().addClass("has-error");
        $("#login_password").next().text("密码长度必须在6~18之间");
        $("#login_password").next().show();
        flag = false;
    } else {
        $('#login_password').parent().removeClass("has-error");
        $('#login_password').next().text("");
        $("#login_password").next().hide();
    }
    return flag;
}
//校验个人资料表单
function validInfo(){
	var flag = true;
	//用户名
	var username = $.trim($("#info_username").val());
	var reg = new RegExp("^[a-zA-Z]\\w{5,11}$", "g");
	if(username == ""){
		$("#info_username").parent().addClass("has-error");
		$('#info_username').next().text("请输入用户名");
        $("#info_username").next().show();
        flag = false;
	}else if(!reg.test(username)){
		$("#info_username").parent().addClass("has-error");
		$('#info_username').next().text("应以字母开头，由长度6-12的字母或数字组成");
        $("#info_username").next().show();
        flag = false;
	}else {
        $('#info_username').parent().removeClass("has-error");
        $('#info_username').next().text("");
        $("#info_username").next().hide();
    }
	//昵称
	var nickname = $.trim($("#info_nickname").val());
	var reg = new RegExp("^[a-zA-Z0-9_\\u4e00-\\u9fa5]{2,10}$", "g");
	if(nickname == ""){
		$("#info_nickname").parent().addClass("has-error");
		$('#info_nickname').next().text("请输入昵称");
        $("#info_nickname").next().show();
        flag = false;
	}else if(!reg.test(nickname)){
		$("#info_nickname").parent().addClass("has-error");
		$('#info_nickname').next().text("昵称可接受范围2~16");
        $("#info_nickname").next().show();
        flag = false;
	}else {
        $('#info_nickname').parent().removeClass("has-error");
        $('#info_nickname').next().text("");
        $("#info_nickname").next().hide();
    }

    //联系号码
    var phone = $.trim($("#info_phone").val());
    if (phone == "") {
        $('#info_phone').parent().addClass("has-error");
        $('#info_phone').next().text("请输入联系号码");
        $("#info_phone").next().show();
        flag = false;
    } else if (!(/^1[345789]\d{9}$/.test(phone))) {
        //电话号码格式的校验
        $('#info_phone').parent().addClass("has-error");
        $('#info_phone').next().text("手机号码有误");
        $("#info_phone").next().show();
        return false;
    } else {
        $('#info_phone').parent().removeClass("has-error");
        $('#info_phone').next().text("");
        $("#info_phone").next().hide();
    }
    //电子邮箱
    var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
    var email = $.trim($("#info_email").val());
    if (email == "") {
        $('#info_email').parent().addClass("has-error");
        $('#info_email').next().text("请输入邮箱");
        $("#info_email").next().show();
        flag = false;
    } else if (!reg.test(email)) {
        //邮箱格式的校验
        $('#info_email').parent().addClass("has-error");
        $('#info_email').next().text("邮箱格式有误");
        $("#info_email").next().show();
        return false;
    } else {
        $('#info_email').parent().removeClass("has-error");
        $('#info_email').next().text("");
        $("#info_email").next().hide();
    }
    return flag;
}
//校验密码表单
function validPassword(){
	var flag = true;
	//旧密码
    var oldPwd = $.trim($("#user_oldPwd").val());
    if (oldPwd == "") {
        $('#user_oldPwd').parent().addClass("has-error");
        $('#user_oldPwd').next().text("请输入密码");
        $("#user_oldPwd").next().show();
        flag = false;
    } else if (oldPwd.length < 6 || oldPwd.length > 18) {
        $("#user_oldPwd").parent().addClass("has-error");
        $("#user_oldPwd").next().text("密码长度必须在6~18之间");
        $("#user_oldPwd").next().show();
        flag = false;
    } else {
        $('#user_oldPwd').parent().removeClass("has-error");
        $('#user_oldPwd').next().text("");
        $("#user_oldPwd").next().hide();
    }
    
    //新密码
    var newPwd = $.trim($("#user_newPwd").val());
    if (newPwd == "") {
        $('#user_newPwd').parent().addClass("has-error");
        $('#user_newPwd').next().text("请输入密码");
        $("#user_newPwd").next().show();
        flag = false;
    } else if (newPwd.length < 6 || newPwd.length > 18) {
        $("#user_newPwd").parent().addClass("has-error");
        $("#user_newPwd").next().text("密码长度必须在6~18之间");
        $("#user_newPwd").next().show();
        flag = false;
    } else {
        $('#user_newPwd').parent().removeClass("has-error");
        $('#user_newPwd').next().text("");
        $("#user_newPwd").next().hide();
    }
    //验证密码
    var confirmPwd = $.trim($("#user_confirmPwd").val());
    if (confirmPwd != newPwd) {
        $('#user_confirmPwd').parent().addClass("has-error");
        $('#user_confirmPwd').next().text("两次密码不一致");
        $("#user_confirmPwd").next().show();
        flag = false;
    } else {
        $('#user_confirmPwd').parent().removeClass("has-error");
        $('#user_confirmPwd').next().text("");
        $("#user_confirmPwd").next().hide();
    }
    return flag;
}
//显示提示信息
function showInfo(msg) {
    $("#div_info").text(msg);
    $("#modal_info").modal('show');
}