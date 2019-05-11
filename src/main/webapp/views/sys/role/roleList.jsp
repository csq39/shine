<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>权限管理</title>
<%@include file="/core/include/head.jsp"%>
<script type="text/javascript">

	$(document).ready(function() {
		table = $('#datatable-form').raytable('form',{rightColumns:-1});
		//返回按钮
		$("#btnSearch").click(function() {
			table.ajax.reload();
		});
		//输入框中输完后点击回车就发起搜索
		$("#roleName").keyup(function(event){
			if(event.keyCode == 13){
				$("#btnSearch").click();
			};
		});
	}); 
	
	
	//新增
	function fncAdd() {
		actSubmit($('#form'), ctx + "/role/add");
	}
	
	//查看详情
	function fncDetail(id) {
		actSubmit($('#form'), ctx + "/role/queryDetail?roleId=" + id);
	}
	
	//删除
	function fncDelete(id) {
		rayDialogConfirm("确认删除？",function(){
			//判断当前角色是否有用户关联
			$.ajax({
				url : ctx + "/role/checkedUser",
				type : "POST",
				data : {"roleId" : id},
				success : function(msg) {
					if (msg == "canDelete") {
						rayDialogConfirm("确定要删除此角色？",function(){
							actSubmit($('#form'), ctx+ "/role/deleteRoleAndPercodes?roleId=" + id);
						});
					} else {
						rayDialog("该角色还有用户使用，不能删除！");
					}
				}
			});
		});
	}
	
</script>
</head>
<body>
<rt:navigation/>
<div class="page-container manage">
	<div class="search-condition text-l clearfix mt-5">
	<form  id="form" method="post" action="/role/queryRoleList">
		<span class="r ">
			角色名称:<input type="text"  id="roleName" data-query="yes"  class="input-text w140 radius size-S" name="roleName" >
			<a href="javascript:;" class="btn btn-success radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i>查&nbsp;询</a>
		</span>	
	</form>
		<div class="cl mt-5">
		<span class="l">
			<a href="javascript:;" onclick="fncAdd()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i>新&nbsp;增</a>
		</span>
		</div>
	</div>
	
	<div class="mt-15">
	<div class="panel panel-default pt-0">
		<table class="table table-border table-bordered table-bg table-hover table-sort table-responsive" id="datatable-form"  width="100%">
			<thead>
				<tr>
					<th data-column="roleId">角色编码</th>
					<th data-column="roleName">角色名称</th>
					<th data-column="roleEnname">英文名称</th>
					<th data-column="op" data-method="[
								{targets:-1,title:'查 看',fncName:'fncDetail',params:'roleId',icon:'detail'},
								{targets:-1,title:'删 除',fncName:'fncDelete',params:'roleId',icon:'del'}
								]">操作</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	</div>
	<!--End Container-->
</div>
</body>
</html>
