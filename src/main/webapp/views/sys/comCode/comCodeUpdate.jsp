<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>共同代码修改界面</title>
<%@include file="/core/include/head.jsp" %>		
<script type="text/javascript">
	$(document).ready(function(){
		validator = $("#form").validate();
	}); 

	function fncUpdate() {
		if(validator.form()){
			$.ajax({
			     type: "post",
			     url: "${ctx}/comCode/updateComCodeDo",
			     data: $('#form').serialize(),
			     async:false,
			     success: function(data){
					rayDialog("修改成功",function(){
						actCancel($('#form'), ctx + "/comCode");
					})
			     },
			     error:function(){
			    	rayDialog("修改失败");
			     }
			 });
		}
	}
	
	function fncCancel() {
		actCancel($('#form'), ctx + "/comCode");
	}
	
</script>
</head>
<body>
<rt:navigation/>
<div class="page-container ">
	<div class="codeView docs-example user ">
		<form class="form-horizontal" id="form" method="post" >
		<legend>更新公用代码</legend>
			<div class="row cl mt-5">
					<input type="hidden" class="form-control" id="dictId" name="dictId" value="${comCode.dictId}">
					<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>分类：</label>
					<div class="formControls col-xs-5 col-sm-5">
						<input type="text" class="input-text radius size-S" id="type" name="type" value="${comCode.type}" disabled="disabled">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码：</label>
					<div class="formControls col-xs-5 col-sm-5">
						<input type="text" class="input-text radius size-S" id="code" name="code" value="${comCode.code}" disabled="disabled">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码名：</label>
					<div class="formControls col-xs-5 col-sm-5"> 
						<input type="text" class="input-text radius size-S" id="label" name="label" validata="{required:true}" value="${comCode.label}">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码排序：</label>
					<div class="formControls col-xs-5 col-sm-5">
						<input type="text"  class="input-text radius size-S" id="sort" name="sort" validata="{required:true,isDigits:true,maxlength:3}" value="${comCode.sort}">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码描述：</label>
					<div class="formControls col-xs-5 col-sm-5">
						<input type="text"  class="input-text radius size-S" id="remark" name="remark" validata="{required:true}" value="${comCode.remark}">
					</div>
				</div>
				<div class="row cl mt-5">
					<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码状态：</label>
					<div class="formControls col-xs-5 col-sm-5">
						<input type="radio" id="delFlag1" name="delFlag" <c:if test="${comCode.delFlag=='N'}">checked</c:if>  value="N" >可用
						<input type="radio" id="delFlag2" name="delFlag" <c:if test="${comCode.delFlag=='Y'}">checked</c:if> value="Y" >禁用
					</div>
				</div>
			<div class="row cl mt-5">
				<div class="col-xs-9 col-sm-9 col-xs-offset-3 col-sm-offset-3">
					<shiro:hasPermission name="comCode:create">
						<button onClick="fncUpdate()" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保&nbsp;存</button>
					</shiro:hasPermission>
					<button onClick="fncCancel();" class="btn btn-default radius cancel" type="button">&nbsp;&nbsp;返回&nbsp;&nbsp;</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>
