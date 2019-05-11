<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>用户管理</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">

	$(function() {
		table = $('#datatable-form').raytable('form',{rightColumns:-1});
		//查询按钮
		$("#btnSearch").click(function(){ 
			table.ajax.reload();
		});
		$(document).keyup(function(event){
			if(event.keyCode == 13){
				$("#btnSearch").click();
			};
		});
	});
	function fncAdd(){
		actSubmit($('#form'), ctx+"/user/add");
	}
	
	function fncDelete(userId){
		rayDialogConfirm("确认删除？",function(){
			actSubmit($('#form'), ctx+"/user/deleteUserDo?userId="+userId);
		});
	} 
	
	function fncUpdate(userId){
		 actSubmit($('#form'), ctx+"/user/update?userId="+userId);
	}
	
	
	
	
</script>	
</head>
<body>
<rt:navigation/>
<div class="page-container manage">
	<div class="search-condition text-l clearfix  mt-5">
		<form class="form-horizontal" id="form" method="post" action="/user/queryUserList">
			登录名:<input type="text" id="loginName" class="input-text w140 radius size-S" placeholder="登录名" data-query="yes" >
			姓名:<input type="text" id="userName" class="input-text w140 radius size-S" placeholder="姓名" data-query="yes" >
			机构名称:<input type="text" id="orgNames" class="input-text w140 radius size-S" placeholder="机构名称" data-query="yes" >
			角色:<rt:select2 id="roleId" dataQuery="yes" headerKey="-1" className="w140 radius size-S" headerValue="全部" items="${role}" itemValue="roleId" itemLabel="roleName"></rt:select2>
			登录状态<rt:select2 id="loginFlag"  name="loginFlag" className="w140 radius size-S" dataQuery="yes" headerKey="-1" headerValue="请选择"  comCode="loginStatus"></rt:select2>
			<a href="javascript:;" class="btn btn-success radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i> 查 询</a>
		</form>
		<div class="cl mt-5">
		<span class="l">
			<shiro:hasPermission name="user:create"> 
				<a href="javascript:;" onclick="fncAdd()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 新增用户</a>
			</shiro:hasPermission>
		</span>
		</div>
	</div>
	<div class="mt-10 clearfix">
		<div class="panel panel-default pt-0">
			<table class="table table-border table-bordered table-bg table-hover table-sort table-responsive" id="datatable-form"  width="100%">
				<thead>
					<tr>
						<th data-column="num">序号</th>
						<th data-column="loginName">登录名</th>
						<th data-column="userName">姓名</th>
						<th data-column="ROLENAME">角色</th>
						<th data-column="positonName">岗位</th>
						<th data-column="userType">用户类型</th>
						<th data-column="officeId">部门</th>
						<th data-column="orgName">机构名称</th> 
						<th data-column="loginFlag">登录状态</th>
						<th data-column="op" data-method="[
									{targets:-1,title:'查看',fncName:'fncUpdate',params:'userId'},
									{targets:-1,title:'删除',fncName:'fncDelete',params:'userId',icon:'del'}
									]">操作</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>
