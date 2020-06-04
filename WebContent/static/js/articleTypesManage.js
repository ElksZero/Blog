$(function(){
	$("#add_type").click(function(){
		if(!validAddType()){//校验分类名称
			return;
		}
		//请求地址
		var path = $("#basePath").val() + "manage/articleTypesManage/addType";
		$.post(path,{
			name:$.trim($("#add_typeName").val()),
			describe:$.trim($("#add_typeDesc").val())
		},function(data){
			//隐藏模态框
			$("#type_add").modal("hide");
			var code = data["code"];
			if(code == -1){
				showInfo("分类名称不可为空");
			}else if(code == -2){
				showInfo("分类标签已存在");
			}else if(code == -3){
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
	//修改标签
	$("#update_type").click(function(){
		if(!validUpdateType()){
			return;
		}
		
		//请求地址
		var path = $("#basePath").val() + "manage/articleTypesManage/updateType";
		$.post(path,{
			id:$.trim($("#update_typeId").val()),
			name:$.trim($("#update_typeName").val()),
			describe:$.trim($("#update_typeDesc").val())
		},function(data){
			//隐藏模态框
			$("#type_update").modal("hide");
			var code = data["code"];
			if(code == -1){
				showInfo("分类id不可为空");
			}else if(code == -2){
				showInfo("分类名称不可为空");
			}else if(code == -3){
				showInfo("该分类已存在")
			}else if(code == -4){
				showInfo("修改失败");
			}else if(code == 1){
				showInfo("修改成功")
			}
		},"json")
		//监听模态框的关闭
		$("#modal_info").on("hide.bs.modal",function(){
			location.reload();//刷新当前的页面
		})
	})
})
//校验分类名称规范
function validAddType(){
	var flag = true;
	var typename = $.trim($("#add_typeName").val());
	if(typename == ""){
		$("#add_typeName").parent().addClass("has-error");
		$('#add_typeName').next().text("请输入分类名称");
        $("#add_typeName").next().show();
        flag = false;
	}else if(typename.length < 2 || typename.length > 10){
		$("#add_typeName").parent().addClass("has-error");
        $("#add_typeName").next().text("分类名称长度必须在2~10之间");
        $("#add_typeName").next().show();
        flag = false;
	} else {
        $('#add_typeName').parent().removeClass("has-error");
        $('#add_typeName').next().text("");
        $("#add_typeName").next().hide();
    }
	var typeDesc = $.trim($("#add_typeDesc").val());
	if(typeDesc.length > 30){
		$("#add_typeDesc").parent().addClass("has-error");
        $("#add_typeDesc").next().text("分类描述长度不得超过50");
        $("#add_typeDesc").next().show();
        flag = false;
	} else {
        $('#add_typeDesc').parent().removeClass("has-error");
        $('#add_typeDesc').next().text("");
        $("#add_typeDesc").next().hide();
    }
	return flag;
}
//校验分类名称规范
function validUpdateType(){
	var flag = true;
	var typename = $.trim($("#update_typeName").val());
//	alert($.trim($("#update_typeName").val()))
	if(typename == ""){
		$("#update_typeName").parent().addClass("has-error");
		$('#update_typeName').next().text("请输入分类名称");
        $("#update_typeName").next().show();
        flag = false;
	}else if(typename.length < 2 || typename.length > 10){
		$("#update_typeName").parent().addClass("has-error");
        $("#update_typeName").next().text("分类名称长度必须在2~10之间");
        $("#update_typeName").next().show();
        flag = false;
	} else {
        $('#update_typeName').parent().removeClass("has-error");
        $('#update_typeName').next().text("");
        $("#update_typeName").next().hide();
    }
	var typeDesc = $.trim($("#update_typeDesc").val());
	if(typeDesc.length > 30){
		$("#update_typeDesc").parent().addClass("has-error");
        $("#update_typeDesc").next().text("分类描述长度不得超过50");
        $("#update_typeDesc").next().show();
        flag = false;
	} else {
        $('#update_typeDesc').parent().removeClass("has-error");
        $('#update_typeDesc').next().text("");
        $("#update_typeDesc").next().hide();
    }
	return flag;
}
//通过id获取分类//预设初始值
function getTypeById(theId){
	//请求地址
	var path = $("#basePath").val() + "manage/articleTypesManage/getArticleTypeById"
	$.post(path,{id:theId},function(data){
		$("#update_typeId").val(theId);
//		console.log($("#update_typeId").val())
//		console.log(theId)
		$("#update_typeName").val(data["type"].name);
		$("#update_typeDesc").val(data["type"].describe);
//		console.log($("#update_typeName").val())
	},"json")
}
//通过id删除
function deleteTypeById(theId){
	//请求地址
	var path = $("#basePath").val() + "manage/articleTypesManage/deleteType";
	$.post(path,{id:theId},function(data){
		var code = data["code"];
		if(code == -1){
			showInfo("分类id不可为空");
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