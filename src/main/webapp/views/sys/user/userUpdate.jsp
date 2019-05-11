<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>用户修改界面</title>
<%@include file="/core/include/head.jsp" %>		
<link rel="stylesheet" href="${ctxStatic}/plugins/zTree/css/metroStyle/metroStyle.css" type="text/css">
<script type="text/javascript">

	$(document).ready(function(){
		validator = $("#form").validate();
	});
	
	//拼音码
	function fncUserName(){
		$.ajax({
		     type: "post",
		     url: ctx + "/user/aliasCode",
		     data: {alias:$("#userName").val()} ,
		     async:false,
		     success: function(data){
		    	 $("#assistCode").val(data.aliasCode);
	    	}
		 });
	}
	
	function fncQueryEmail(){
		if($("#email").val()!= null || $("#email").val()!= ''){
			$.ajax({
				type:"post",
				url:ctx+"/user/queryEmailMobile",
				data:{	emailOrmobileNo:$("#email").val(),
						userId:$("#userId").val()	},
				async:false,
				success:function(data){
					if(data.message == 'error'){
						rayDialog("此邮箱号已存在,请重新输入！");
						$("#email").focus();
						$("#email").val('');
					}
					if(data.message == 'ok'){
						return;
					}
				}
			});
		}
	}
	
	function fncQueryMobileNo(){
		if($("#mobileNo").val()!= null || $("#mobileNo").val()!= ''){
			$.ajax({
				type:"post",
				url:ctx+"/user/queryEmailMobile",
				data:{	emailOrmobileNo:$("#mobileNo").val(),
						userId:$("#userId").val()	},
				async:false,
				success:function(data){
					if(data.message == 'error'){
						rayDialog("此手机号已存在,请重新输入！");
						$("#mobileNo").focus();
						$("#mobileNo").val('');
					}
					if(data.message == 'ok'){
						return;
					}
				}
			});
		}
	}
	
	//保存
	function fncUpdate() {
		if(validator.form()){
			$.ajax({
			     type: "post",
			     url: "${ctx}/user/updateUserDo?roleId="+$('#roleId').val()+"&positonId="+$("#positonId").val(),
			     data: $('#form').serialize() ,
			     async:false,
			     success: function(data){
		    	 	rayDialog("修改成功",function(){
		    	 		actSubmit($('#form'), ctx + "/user");
		    	 	});
			    },
			 });
		}
	}
	
	//重置密码
	function  fncResetPass() {
		rayDialogConfirm("确认重置密码吗？",function(){
			$.ajax({
			     type: "post",
			     url: "${ctx}/user/resetPass",
			     data: $('#form').serialize() ,
			     async:false,
			     success: function(data){
		    	 	rayDialog("重置成功",function(){
		    	 		actSubmit($('#form'), ctx + "/user");
		    	 	});
			    },
			 });
		})
	}
	
	//返回
	function fncCancel() {
		actCancel($('#form'), ctx+"/user");
	}
	
</script>
</head>
<body>
<rt:navigation/>
<div class="page-container ">
	<div class="codeView docs-example user ">
		<form class="form-horizontal" id="form" name="form" action=""  method="post" >
			<legend>修改用户信息</legend>
			<div class="row cl mt-5">
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>登录名</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input type="text" class="input-text radius size-S" id="loginName" name="loginName" value="${user.loginName}" disabled="disabled">
					<input type="hidden" id="userId" name="userId" value="${user.userId}">
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>姓名</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input type="text" class="input-text radius size-S" id="userName" name="userName" onkeyup="fncUserName();" value="${user.userName}" validata="{required:true}">
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
			</div>
			<div class="row cl mt-5">
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>性别</label>
				<div class="formControls col-xs-3 col-sm-3">
					<rt:select2 className="select" id="sex" value="${user.sex}"  name="sex" dataQuery="yes"  headerKey="-1" headerValue="请选择" comCode="gender"></rt:select2>
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>拼音码</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input value="${user.assistCode}" class="input-text radius size-S"  type="text" id="assistCode" name="assistCode" disabled="disabled" placeholder="拼音码" >
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
			</div>
			<div class="row cl mt-5">
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>电话</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input value="${user.phoneNo}" type="text" class="input-text radius size-S" id="phoneNo" name="phoneNo" placeholder="电话"  validata="{required:true,isPhone:true}">
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>邮箱</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input value="${user.email}" onchange="fncQueryEmail();" class="input-text radius size-S"  type="text" id="email" name="email"  placeholder="邮箱" validata="{required:true,email:true}" >
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
			</div>
			<div class="row cl mt-5">
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>手机</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input value="${user.mobileNo}" onchange="fncQueryMobileNo();" type="text" class="input-text radius size-S" id="mobileNo" name="mobileNo" placeholder="手机" validata="{required:true,isMobile:true}">
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>部门</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input value="${user.officeId}" class="input-text radius size-S"  type="text" id="officeId" name="officeId"  placeholder="部门" validata="{required:true}" >
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
			</div>
			<div class="row cl mt-5">
				<label class="form-label col-xs-2 col-sm-2">角色:</label>
				<div class="formControls col-xs-3 col-sm-3">
					<rt:select2 id="roleId" name="roleId" htmlAppend="multiple='multiple'" value="${userRole}"
							className="select" items="${role}" itemLabel="roleName" 
							itemValue="roleId" >
					</rt:select2>
				</div>
				<label class="form-label col-xs-2 col-sm-2">岗位:</label>
				<div class="formControls col-xs-3 col-sm-3">
					<rt:select2 id="positonId" name="positonId" htmlAppend="multiple='multiple'" value="${userPositon}"
							className="select" items="${positon}" itemLabel="positonName" 
							itemValue="positonId" >
					</rt:select2>
				</div>
			</div>
			<div class="row cl mt-5">
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>机构名称</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input value="${user.orgName}" class="input-text radius size-S"  type="text" id="orgId" name="orgId"  placeholder="机构名称" disabled="disabled" >
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>状态</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input name="loginFlag" type="radio" <c:if test="${user.loginFlag=='Y'}">checked</c:if> value="Y" >可以登录
					<input name="loginFlag" type="radio" <c:if test="${user.loginFlag=='N'}">checked</c:if> value="N">禁止登录
				</div>
			</div>
			<div class="row cl mt-5">
			    <label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>用户类型</label>
				<div class="formControls col-xs-3 col-sm-3">
					<rt:select2 id="userType"  name="userType" className="select" value="${user.userType}" dataQuery="yes" headerKey="-1" headerValue="请选择"  comCode="userType"></rt:select2>
					<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
				</div>
				<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>首次登陆是否需要修改密码：</label>
				<div class="formControls col-xs-3 col-sm-3">
					<input name="loginFirstFlag" type="radio" <c:if test="${user.loginFirstFlag=='Y'}">checked</c:if> value="Y" >是
					<input name="loginFirstFlag" type="radio" <c:if test="${user.loginFirstFlag=='N'}">checked</c:if> value="N">否
				</div>
			</div>
			<div class="row cl mt-5">
				<div class="col-xs-5 col-sm-5 col-sm-offset-7">
					<shiro:hasPermission name="user:create">
						<button onclick="fncResetPass();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i>重置密码</button>
					</shiro:hasPermission>
					<button onClick="fncUpdate();" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保&nbsp;存</button>
					<button onClick="fncCancel();" class="btn btn-default radius cancel" type="button">&nbsp;&nbsp;返回&nbsp;&nbsp;</button>
				</div>
			</div>	
		</form>
	</div>
</div>
</body>
</html>

