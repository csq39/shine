<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>密码修改界面</title>
<%@include file="/core/include/head.jsp" %>		
<link rel="stylesheet" href="${ctxStatic}/plugins/zTree/css/metroStyle/metroStyle.css" type="text/css">
<script type="text/javascript">
	
	$(document).ready(function() {
		validator = $("#form").validate();
	});
	
	function fncUpdate() {
		if(validator.form()){
			//校验原密码是否与新密码相等，新密码是否一致
			if($('#oldPassword').val() == $('#newPassword').val()){
				rayDialog("新密码与不能与原来密码相同,请重新输入！");
				return;
			}
			if($('#newPassword').val() != $('#confirmPassword').val()){
				rayDialog("两次新密码输入不一致,请重新输入！");
				return;
			}
			$.ajax({
			     type: "post",
			     url: "${ctx}/user/saveUpdatedPwd",
			     data: $('#form').serialize(),
			     async:false,
			     success: function(data){
			    	if(data == 'ok'){
			    		rayDialog("修改成功,请重新登录！",function(){ actSubmit($('#form'), ctx + "/logout");  });
						
			    	}
			    	if(data == 'oldPasswordError'){
			    		rayDialog("原密码错误,请输入正确原密码");
			    		return;
			    	}
			     }
			 });
		}
	}
	
	function fncCancel() {
		actCancel($('#form'), ctx+"/user");
	}
	

	
</script>
</head>
<body>

<!-- nav -->
<rt:navigation/>
<!-- nav end -->
	<form class="form-horizontal" id="form" name="form" action=""  method="post" >
		<input type="hidden" id="userId" name="userId" value="${user.userId}">
		<div class="panel panel-default mb-10 mr-10 ml-10 mt-10">
			<div class="panel-header"></div>
			<div class="panel-body pd-0 ">
			<article class="page-container pt-0">
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>登录名</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input value="${user.loginName}"  type="text" class="input-text radius size-S" id="loginName" name="loginName" disabled="disabled">
						<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>姓名</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input value="${user.userName}"  type="text" class="input-text radius size-S" id="userName" name="userName" disabled="disabled">
						<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>原密码</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input value=""  type="password" class="input-text radius size-S" id="oldPassword" name="oldPassword">
						<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>新密码</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input value="" validata="{required:true,rangelength:[6,16]}" type="password" class="input-text radius size-S" id="newPassword" name="newPassword">
						<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>确认新密码</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input value="" validata="{required:true,rangelength:[6,16]}" type="password" class="input-text radius size-S" id="confirmPassword" name="confirmPassword">
						<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
					</div>
				</div>
			</article>
			</div>
		</div>
		<div class="row cl mt-5">
			<div class="col-xs-4 col-sm-4 col-sm-offset-8">
				<shiro:hasPermission name="user:create">
					<button type="button" class="btn btn-default btn-xs" onclick="fncUpdate();">
						保&nbsp;存
					</button>
				</shiro:hasPermission>
			</div>
		</div>
	</form>
</body>
</html>