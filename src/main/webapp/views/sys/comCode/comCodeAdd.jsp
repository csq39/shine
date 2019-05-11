<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title>共同代码管理</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">

	$(document).ready(function(){		
		validator = $("#form").validate();
	}); 
	
	function fncAdd() {
		if(validator.form()){
			$.ajax({
			     type: "post",
			     url: "${ctx}/comCode/addComCodeDo",
			     data: $('#form').serialize() ,
			     async:false,
			     success: function(){
					rayDialog("新增共同代码成功",function(){
						actCancel($('#form'), ctx + "/comCode");
					});
				 },
				 error:function(){
			    	rayDialog("新增共同代码失败");
			    }
			 });
		}
	}
	
	function fncQueryCode(){
		var type = $("#type").val();
		var code = $("#code").val();
		if(type != null || type != ''){
			$.ajax({
				type:"post",
				url:ctx+"/comCode/queryCode",
				data:{
					type:type,
					code:code
				},
				async:false,
				success:function(data){
					if(data.message == 'error'){
						rayDialog("代码"+code+"已存在,请重新输入！");
						$("#code").focus();
						$("#code").val('');
					}
					if(data.message == 'ok'){
						return;
					}
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
	<form class="form form-horizontal" id="form">
	<legend>新增公用代码</legend>
		<div class="row cl mt-5">
			<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>分类：</label>
			<div class="formControls col-xs-5 col-sm-5">
				<input type="text" class="input-text radius size-S" value="" id="type" name="type" placeholder="分类" validata="{required:true}">
			</div>
		</div>
		<div class="row cl mt-5">
			<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码：</label>
			<div class="formControls col-xs-5 col-sm-5">
				<input type="text" class="input-text radius size-S" onChange="fncQueryCode()" id="code" name="code" validata="{required:true}" placeholder="代码">
			</div>
		</div>
		<div class="row cl mt-5">
			<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码名：</label>
			<div class="formControls col-xs-5 col-sm-5"> 
				<input type="text" class="input-text radius size-S" value="" id="label" name="label"  validata="{required:true}" placeholder="代码名"> 
			</div>
			
		</div>
		<div class="row cl mt-5">
			<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码排序：</label>
			<div class="formControls col-xs-5 col-sm-5">
				<input type="text" class="input-text radius size-S" value="" id="sort" name="sort" validata="{required:true,isDigits:true,maxlength:3}"placeholder="代码排序">
			</div>
		</div>
		<div class="row cl mt-5">
			<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码描述：</label>
			<div class="formControls col-xs-5 col-sm-5">
				<input type="text" class="input-text radius size-S" value="" id="remark" name="remark"  validata="{required:true}" placeholder="代码描述"> 
			</div>
		</div>
		<div class="row cl mt-5">
			<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>代码状态：</label>
			<div class="formControls col-xs-5 col-sm-5">
				<input type="radio" id="delFlag1" checked="checked" name="delFlag"  value="N" >可用
				<input type="radio" id="delFlag2" name="delFlag"  value="Y" >禁用
			</div>
		</div>
	<div class="row cl mt-5">
		<div class="col-xs-9 col-sm-9 col-xs-offset-3 col-sm-offset-3">
			<button onClick="fncAdd()" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保&nbsp;存</button>
			<button onClick="fncCancel();" class="btn btn-default radius cancel" type="button">&nbsp;&nbsp;返回&nbsp;&nbsp;</button>
		</div>
	</div>
	</form>	
</div>
</div>
</body>
</html>
