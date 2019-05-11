<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title>账户管理</title>
<%@include file="/core/include/head.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){		
		validator = $("#form").validate();
	});
	
	function fncUpdateUser(){
		var sex = $("#sex").val();
		var email = $("#email").val();
		var mobileNo = $("#mobileNo").val();
		if(validator.form()){
			$.ajax({
				type:"post",
				url:ctx+"/card/queryRepeat",
				data:{
					mobileNo:mobileNo
				},
				success:function(data){
					if(data.msg== 'Y'){
						rayDialog("此手机号已被使用，请重新输入！");
						return;
					}else{
						$.ajax({
							type:"post",
							url:ctx+"/card/updateUser",
							data:{
								sex:sex,
								email:email,
								mobileNo:mobileNo
							},
							success:function(){
								rayDialog("修改成功！",function(){
									window.history.back(-1);
								});
							},
							error:function(){
								rayDialog("修改失败！");
								return;
							}
						});
					}
				}
			});
		}
	}

	function fncChangePwd(){
		actSubmit($('#form'), ctx + "/card/changePwd");
	}
	
	function closeWin(){
		window.history.back(-1);
	}
	
</script>
</head>
<body>
<rt:navigation/>
<div class="page-container">
        <div class="codeView docs-example user">
            <form class="form form-horizontal" id="form">
                <div class="row cl">
                <input type="hidden" id="userId" name="userId" value="${user.userId}" /> 
                    <label class="form-label col-sm-3">用户名：</label>
                    <div class="formControls col-sm-5" style="margin-top:3px;">
                        <code>${user.loginName}</code>
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-sm-3">职务：</label>
                    <div class="formControls col-sm-5" style="margin-top:3px;">
                        <code>${user.position}</code>
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-sm-3">部门：</label>
                    <div class="formControls col-sm-5" style="margin-top:3px;">
                        <code>${user.officeId}</code>
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-sm-3">
                        <span class="layui-badge-dot"></span>性别：</label>
                    <div class="formControls col-sm-5">
                         <rt:select2 id="sex" name="sex" value="${user.sex}" className="w140 radius size-S" comCode="gender" ></rt:select2>
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-sm-3">
                        <span class="layui-badge-dot"></span>密码：</label>
                    <div class="formControls col-sm-5" style="margin-top: 3px;">
							<input type="password" class="w140 radius size-S"
								value="123123" disabled> <a href="javascript:;"
								class="change"
								onclick="fncChangePwd();">修改</a>
						</div>
                </div>
                <div class="row cl">
                    <label class="form-label col-sm-3">
                        <span class="layui-badge-dot"></span>邮箱：</label>
                   <div class="formControls col-sm-5">
							<input type="text" id="email" name="userEmail"
								class="w200 radius size-S" validata="{required:true,email:true}" placeholder="填写正确邮箱地址"
								value="${user.email}">
						</div>
                </div>
                <div class="row cl">
                    <label class="form-label col-sm-3">
                        <span class="layui-badge-dot"></span>手机号：</label>
                   <div class="formControls col-sm-5">
							<input type="text" id="mobileNo" validata="{required:true,isMobile:true}" name="mobileNo"
								class="w200 radius size-S" placeholder="手机号"
								value="${user.mobileNo}">
						</div>
                </div>
                <div class="row cl">
                    <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                       	<input 	class="btn btn-primary radius" onclick="fncUpdateUser();" value="&nbsp;&nbsp;修改&nbsp;&nbsp;">
                        <input	class="btn btn-default radius" onclick="closeWin();" type="button" value="&nbsp;&nbsp;返回&nbsp;&nbsp;">
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
