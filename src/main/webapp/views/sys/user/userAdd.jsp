<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>用户添加界面</title>
<%@include file="/core/include/head.jsp" %>		
<link rel="stylesheet" href="${ctxStatic}/plugins/zTree/css/metroStyle/metroStyle.css" type="text/css">
<script type="text/javascript">

	$(function(){
		$(".js-example-basic-single").select2();
		validator = $("#form").validate();
	})
	
	function fncAdd(){
		if(validator.form()){
			$.ajax({
			     type: "post",
			     url: "${ctx}/user/createUserDo?roleId="+$('#roleId').val()+"&positonId="+$("#positonId").val(),
			     data: $('#form').serialize() ,
			     async:false,
			     success: function(msg){
			    	 if(msg=="true"){
						rayDialog("新增用户成功",function(){
							actCancel($('#form'), ctx + "/user");
						});
	    				
			    	 }else {
			    		rayDialog(msg,function(){
			    			$("#loginName").focus();
			    		});
			    	 }
		    	}
			 });
		}
	}
	
	function fncCancel() {//返回
		 actCancel($('#form'), ctx+"/user");
	}
	
	//生成拼音码
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
				data:{emailOrmobileNo:$("#email").val(),
						userId:""},
				async:false,
				success:function(data){
					if(data.message == 'error'){
						rayDialog("此邮箱号已存在,请重新输入！");
						$("#email").focus();
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
				data:{emailOrmobileNo:$("#mobileNo").val(),
						userId:""},
				async:false,
				success:function(data){
					if(data.message == 'error'){
						rayDialog("此手机号已存在,请重新输入！");
						$("#mobileNo").focus();
					}
					if(data.message == 'ok'){
						return;
					}
				}
			});
		}
	}
	
</script>
</head>
<body>
<rt:navigation/>
<div class="page-container ">
	<div class="codeView docs-example user ">
	<form class="form form-horizontal" id="form">
				<legend>新增用户信息</legend>
				<div class="row cl mt-5">
				    <label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>机构名称 ：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<rt:select2 id="orgId" className="select" name="orgId" headerKey="-1" headerValue="请选择" items="${org}" itemLabel="orgName" itemValue="orgId" ></rt:select2>
					</div>
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>姓名：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input type="text" class="input-text radius size-S" id="userName" name="userName" onkeyup="fncUserName();" value="" placeholder="姓名" validata="{required:true}">
						<input type="hidden" id="assistCode" name="assistCode" value="">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>登录名：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input type="text" class="input-text radius size-S" id="loginName" name="loginName" value="" placeholder="登录名" validata="{required:true}">
					</div>
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>密码：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input type="password" class="input-text radius size-S" id="password" name="password" validata="{required:true,pwd:true}" placeholder="密码">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>性别：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<rt:select2 dataQuery="yes" id="sex" className="select" name="sex" headerKey="-1" headerValue="请选择"  comCode="gender"></rt:select2>
					</div>
                    <label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>邮箱：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input type="text" onchange="fncQueryEmail();" class="input-text radius size-S" id="email" name="email" placeholder="邮箱" validata="{email:true,required:true}">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>电话：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input type="text" class="input-text radius size-S" id="phoneNo" name="phoneNo" placeholder="电话" validata="{isPhone:true}">
					</div>
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>手机：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input type="text" onchange="fncQueryMobileNo();" class="input-text radius size-S" id="mobileNo" name="mobileNo" placeholder="手机"  validata="{isMobile:true,required:true}">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>部门：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input type="text" class="input-text radius size-S" id="officeId" name="officeId" value="" placeholder="部门" validata="{required:true}">
					</div>
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>状态：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input name="loginFlag" type="radio" value="Y" checked="checked">可以登录
						<input name="loginFlag" type="radio" value="N">禁止登录
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>用户类型：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<rt:select2 id="userType"  className="select" name="userType" dataQuery="yes" headerKey="-1" headerValue="请选择"  comCode="userType"></rt:select2>
					</div>
					<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>首次登陆是否需要修改密码：</label>
					<div class="formControls col-xs-3 col-sm-3">
						<input name="loginFirstFlag" type="radio" value="Y" checked="checked">是
						<input name="loginFirstFlag" type="radio" value="N">否
					</div>
				</div>
				<div class="row cl mt-5">
                     	<label class="form-label col-xs-2 col-sm-2">角色:</label>
						<div class="formControls col-xs-3 col-sm-3">
							<rt:select2 id="roleId" name="roleId" htmlAppend="multiple='multiple'" className="select"
									items="${role}" itemLabel="roleName"
									itemValue="roleId" >
							</rt:select2>
						</div>
						<label class="form-label col-xs-2 col-sm-2">岗位:</label>
						<div class="formControls col-xs-3 col-sm-3">
							<rt:select2 id="positonId" name="positonId" htmlAppend="multiple='multiple'" className="select"
									items="${positon}" itemLabel="positonName"
									itemValue="positonId" >
							</rt:select2>
						</div>
				</div>
			<div class="row cl mt-5">
		<div class="col-xs-4 col-sm-4 col-sm-offset-8">
			<button onClick="fncAdd()" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保&nbsp;存</button>
			<button onClick="fncCancel();" class="btn btn-default radius cancel" type="button">&nbsp;&nbsp;返回&nbsp;&nbsp;</button>
		</div>
		</div>	
	</form>
</div>
</div>
			
</body>
</html>
