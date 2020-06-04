$(function(){
	$("#add_label").click(function(){
		if(!validAddLabel()){//校验标签名称
			return;
		}
		//请求地址
		var path = $("#basePath").val() + "manage/articleLabelsManage/addLabel";
		$.post(path,{
			name:$.trim($("#add_labelName").val())
		},function(data){
			//隐藏模态框
			$("#label_add").modal("hide");
			var code = data["code"];
			if(code == -1){
				showInfo("标签名称不可为空");
			}else if(code == -2){
				showInfo("标签已存在");
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
	$("#update_label").click(function(){
		if(!validUpdateLabel()){
			return;
		}
		
		//请求地址
		var path = $("#basePath").val() + "manage/articleLabelsManage/updateLabel";
		$.post(path,{
			id:$.trim($("#update_labelId").val()),
			name:$.trim($("#update_labelName").val())
		},function(data){
			//隐藏模态框
			$("#label_update").modal("hide");
			var code = data["code"];
			if(code == -1){
				showInfo("标签id不可为空");
			}else if(code == -2){
				showInfo("标签名称不可为空");
			}else if(code == -3){
				showInfo("标签已存在");
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
function validAddLabel(){
	var flag = true;
	var typename = $.trim($("#add_labelName").val());
	if(typename == ""){
		$("#add_labelName").parent().addClass("has-error");
		$('#add_labelName').next().text("请输入分类名称");
        $("#add_labelName").next().show();
        flag = false;
	}else if(typename.length < 2 || typename.length > 8){
		$("#add_labelName").parent().addClass("has-error");
        $("#add_labelName").next().text("分类名称长度必须在2~8之间");
        $("#add_labelName").next().show();
        flag = false;
	} else {
        $('#add_labelName').parent().removeClass("has-error");
        $('#add_labelName').next().text("");
        $("#add_labelName").next().hide();
    }
	return flag;
}
//校验分类名称规范
function validUpdateLabel(){
	var flag = true;
	var typename = $.trim($("#update_labelName").val());
//	alert($.trim($("#update_typeName").val()))
	if(typename == ""){
		$("#update_labelName").parent().addClass("has-error");
		$('#update_labelName').next().text("请输入分类名称");
        $("#update_labelName").next().show();
        flag = false;
	}else if(typename.length < 2 || typename.length > 8){
		$("#update_labelName").parent().addClass("has-error");
        $("#update_labelName").next().text("分类名称长度必须在2~8之间");
        $("#update_labelName").next().show();
        flag = false;
	} else {
        $('#update_labelName').parent().removeClass("has-error");
        $('#update_labelName').next().text("");
        $("#update_labelName").next().hide();
    }
	return flag;
}
//通过id获取分类//预设初始值
function getLabelById(theId){
	//请求地址
	var path = $("#basePath").val() + "manage/articleLabelsManage/getLabelById"
	$.post(path,{id:theId},function(data){
		$("#update_labelId").val(theId);
		$("#update_labelName").val(data["label"].name);

	},"json")
}
//通过id删除
function deleteLabelById(theId){
	//请求地址
	var path = $("#basePath").val() + "manage/articleLabelsManage/deleteLabel";
	$.post(path,{id:theId},function(data){
		var code = data["code"];
		if(code == -1){
			showInfo("标签id不可为空");
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

