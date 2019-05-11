<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>菜单管理</TITLE>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<%@include file="/core/include/head.jsp"%>
<title>菜单管理</title>
<link rel="stylesheet" href="${ctxStatic}/plugins/zTree/v3/css/metroStyle/metroStyle.css" type="text/css">
<script type="text/javascript" src="${ctxStatic}/plugins/zTree/v3/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		validator = $("#form").validate();
		 $(':input') .attr({"readonly":true});
		 fncInitMenu();
	});
	
	var rows = 0 ;
	var index=0;
	//新建菜单内置需要,用于js控制使用,实际存入数据库时由数据库单独处理
	var newCount = 1;
	
	var setting = {
		view: {
			addHoverDom: addHoverDom,//鼠标移动到节点上
			removeHoverDom: removeHoverDom,//鼠标移出节点上
			dblClickExpand: dblClickExpand//鼠标点击事件
		},
		edit: {
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback : {
			onClick : fncTreeNodeClick
		}
	};
	
	//点击添加表格
	function Addline(){
		if(parseInt($("tbody tr:last-child").attr("id"))>0){
			index=parseInt($("tbody tr:last-child").attr("id"))+1;
		}else{
			index=index+1;
		}
		
		var trHTML ="<tr id="+index+"><td>"+index+"</td><td><input type='text' name='permissionCode' placeholder='权限编码'  value=''/></td><td> <input type='text' placeholder='权限名称' name='permissionName'  value=''/></td><td> <button id='qw' type='button' class='btn btn-default radius cancel' onclick='fncDelButton("+index+")'>删&nbsp;除</button></td></tr>";
		$("#tab").append(trHTML); 
	}
	
	//删除按钮
	function fncDelButton(index){
		rayDialogConfirm("确认删除？",function(){
			$.ajax({
				type : "POST",
				url : ctx+"/menu/delButton",
				data : {
					menuId:$("#menuId").val(),
					permissionCode:$("#"+index+" td:nth-child(2)>input").val()
				},
				success : function(data) {
					rayDialog("删除成功！");
				}
			});
			$("#"+index+"").remove();
		});
	}
	
	//新增和更新
	function fncAdd() {
		var rows= document.getElementById("tab").rows.length;
		for(var i=1;i<rows;i++){
			var name1 = $("#tab tr").eq(i).children("td:eq(1)").find("input").val() ;
			if(name1==""){
				rayDialog("权限编码不能为空！");
				return;
			}
		}
		for(var i=1;i<rows;i++){
			var name1 = $("#tab tr").eq(i).children("td:eq(1)").find("input").val() ;
			for(var j=i+1;j<rows;j++){
				var name2 = $("#tab tr").eq(j).children("td:eq(1)").find("input").val() ;
					if(name1==name2){
						rayDialog("有重复的权限编码");
						return;
					}
			}
		}
		if(rows>1){
			if($("#permission").val()==""){
				rayDialog("权限标识不能为空！");
				return;
			}
		}
		if(validator.form()){
			$.ajax({
				type : "POST",
				url : ctx + "/menu/update",
				async:false,
				data : $('#form').serialize(),
				success : function(data) {
					if(data == "saveOk"){
						return rayDialog("保存成功！",function(){
							$("tbody").remove();
							actCancel($('#form'), ctx + "/menu");
						});
					}
					$("tbody").remove();
					actCancel($('#form'), ctx + "/menu");
				}
			});
		}
	}
	
	//删除菜单
	function fncDel() {
		if ($("#menuId").val() != ""){
			rayDialogConfirm("确认要删除当前菜单？",function(){
				$("tbody").remove();
				$.ajax({
					type : "POST",
					url : ctx + "/menu/del",
					async:false,
					data : $('#form').serialize(),
					success : function() {
						$("tbody").remove();
						actCancel($('#form'), ctx + "/menu");
					}
				});
			});
		}
	}
	
	//鼠标单击执行的事件
	function fncTreeNodeClick(event, treeId, treeNode) {
		if(treeNode.id=='1000000'){
			 $(':input') .attr({"readonly":true});
			fncInitForm();
			return;
		}
		fncInitForm();
		$("tbody").remove();
		$(':input') .attr({"readonly":false});
		$("input[name=parentName]").attr({"readonly":true});
		if(treeNode.id.charAt(0)=='n'){//新增菜单
			$("#parentId").val(treeNode.pId);
			$("#parentName").val(treeNode.getParentNode().name);
			return;
		}
		//更新菜单
		//查询菜单和按钮
		$.ajax({
			url: ctx+"/menu/searchById",
			data: { menuId: treeNode.id},
			type: "POST",
			success: function(data){
				$("#menuId").val(data.menuId);
				$("#name").val(data.name);
				$("#parentId").val(data.parentId);
				$("#parentName").val(data.parentName);
				$("#remarks").val(data.remarks);
				$("#href").val(data.href);
				$("#icon").val(data.icon);
				$("#target").val(data.target);
				$("#sort").val(data.sort);
				$("#permission").val(data.permission);
				if (data.isShow == "Y") {
					$("input[name=isShow]").get(0).checked=true;
				} else {
					$("input[name=isShow]").get(1).checked=true;
				}
			}
		});
		index=0;
	 	$.ajax({
			url: ctx+"/menu/selectButton",
			data: { menuId: treeNode.id},
			type: "POST",
			success: function(data){
				for (var i=0 ; i<data.length ; i++){
					var index=i+1;
					var trHTML ="<tr id="+index+"><td>"+index+"</td><td><input type='text' name='permissionCode'   value='"+data[i].permissionCode+"'/></td><td> <input type='text' name='permissionName'  value='"+data[i].permissionName+"'/></td><td> <button id='qw' type='button' class='btn btn-default btn-xs' onclick='fncDelButton("+index+")'>删除</button></td></tr>";
					$("#tab").append(trHTML);
				} 
			 }
		});  
	 	var rows= document.getElementById("tab").rows.length;
	}
	
	//初始化
	function fncInitMenu() {
		$.ajax({
			async : false,
			cache : false,
			type : "post",
			url : ctx + "/menu/getAllNode",
			success : function(data) {
				zTree = $.fn.zTree.init($("#tree"), setting, data);
				zTree.expandNode(zTree.getNodes()[0],true,false,true);
				fncInitForm() 
			},
			error : function() {
				rayDialog("请求失败")
				
			}
		});
	}
	
	//初始化门户
	function fncInitForm() {//清空编辑区
		 $(':input','#form')  
		 .not(':button, :submit, :reset, :hidden, :radio')  
		 .val('') ;  
		$("#menuId").val('');
	};
	
	function dblClickExpand(treeId, treeNode) {
		return treeNode.level > 0;//主节点不可变更
	}
	
	//鼠标移动到节点上
	function addHoverDom(treeId, treeNode) {
		if(treeNode.id.charAt(0)=='n') return;
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		
		var sObj = $("#" + treeNode.tId + "_span");
		sObj.after("<span class='button add' id='addBtn_" + treeNode.tId+ "' title='add node' onfocus='this.blur();'></span>");
		
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) {
			btn.bind("click", function(){
				zTree.addNodes(treeNode, {id:('n' + newCount), pId:treeNode.id, name:"新建菜单" + (newCount++)});
				fncInitForm();
				$("#parentId").val(treeNode.id);
				$("#parentName").val(treeNode.name);
				return false;
			});
		}
	};
	
	//鼠标移出节点
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
</script>
<style>
	html,body{
		box-sizing: border-box;
		width: 100%;
		height: 100%;
	}
</style>
</head>
<body>
<rt:navigation/>
<div class="page-container manage">
	<form class="form-horizontal" id="form"	 method="post">
	<div class="mt-10 clearfix">
		<div class="panel panel-default pt-0">
				<div class="row cl mt-5">
					<div class="formControls col-xs-4 col-sm-4 ">
						<div class="formControls col-xs-4 col-sm-4">
							<div class="ztreeBackground right" style="height:100%; overflow:auto; width:321px;height:450px; border:1px solid #efefef">
								<ul id="tree" class="ztree"></ul>
							</div>
						</div>
					</div>
					<div class="formControls col-xs-8 col-sm-8 pd-0" style="height:100%;width:740px;min-height:450px;border:1px solid #efefef">
						<div class="row cl mt-5">
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>菜单名称</label>
							<div class="formControls col-xs-3 col-sm-3">
								<input type="hidden" readonly="readonly" id="menuId" name="menuId">
								<input type="text" validata="{required:true,rangelength:[0,80]}" placeholder="菜单名称" data-toggle="tooltip" data-placement="bottom" class="input-text radius size-S" id="name" name="name" >
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>父级菜单</label>
							<div class="formControls col-xs-3 col-sm-3">
								<input type="hidden" id="parentId" name="parentId"  >
								<input type="text" class="input-text radius size-S" readonly="readonly"	id="parentName" name="parentName" placeholder="父级菜单" data-toggle="tooltip" data-placement="bottom">
							</div>
						</div>
						<div class="row cl mt-5">
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>菜单序号</label>
							<div class="formControls col-xs-3 col-sm-3">
								<input type="text" validata="{required:true,isDigits:true}" placeholder="菜单序号" data-toggle="tooltip" data-placement="bottom" class="input-text radius size-S" id="sort" name="sort" >
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>权限标识</label>
							<div class="formControls col-xs-3 col-sm-3">
								<input type="text" class="input-text radius size-S" id="permission" name="permission"  data-toggle="tooltip" data-placement="bottom" placeholder="权限标识">
							</div>
						</div>
						<div class="row cl mt-5">
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>菜单url</label>
							<div class="formControls col-xs-3 col-sm-3">
								<input type="text" validata="{required:true}" placeholder="菜单url" data-toggle="tooltip" data-placement="bottom" class="input-text radius size-S" id="href" name="href" >
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>菜单描述</label>
							<div class="formControls col-xs-3 col-sm-3">
								<input type="text" validata="{rangelength:[0,150]}" placeholder="菜单描述" data-toggle="tooltip" data-placement="bottom" class="input-text radius size-S" id="remarks" name="remarks" >
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
						</div>
						<div class="row cl mt-5">
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>图标</label>
							<div class="formControls col-xs-3 col-sm-3">
								<input type="text" validata="{rangelength:[0,150]}" placeholder="图标" data-toggle="tooltip" data-placement="bottom" class="input-text radius size-S" id="icon" name="icon" >
								<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
							</div>
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>是否可用</label>
							<div class="formControls col-xs-3 col-sm-3">
								<input type="radio" name="isShow" id="isShow1" value="Y"checked />在用
								<input type="radio" name="isShow" id="isShow2" value="N"  />禁用
							</div>
						</div>
						<div class="row cl mt-5">
							<label class="form-label col-xs-2 col-sm-2"><span class="c-red">*</span>按钮权限管理</label>
							<div class="formControls col-xs-3 col-sm-3">
								<button type="button" class="btn btn-primary radius" onclick="Addline()">
										<i class="Hui-iconfont">&#xe632;</i>添&nbsp;加
								</button>
							</div>
						</div>
						<div class="row cl mt-5">
							<label class="form-label col-xs-2 col-sm-2"></label>
							<div class="formControls col-xs-8 col-sm-8">
								<table class="table table-border table-bordered table-bg table-hover table-sort table-responsive" id="tab">
									<thead>
										<tr>
											<th>序号</th>
											<th>权限编码</th>
											<th>权限名称</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
						<div class="row cl mt-5">
							<div class="col-xs-4 col-sm-4 col-sm-offset-8">
								<shiro:hasPermission name="menu:create">
									<button type="button" class="btn btn-primary radius" onclick="fncAdd()">
										<i class="Hui-iconfont">&#xe632;</i>保&nbsp;存
									</button>
								</shiro:hasPermission>
								<shiro:hasPermission name="menu:delete">
									<button type="button" class="btn btn-default radius cancel" onclick="fncDel()">
										删&nbsp;除
									</button>
								</shiro:hasPermission>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>	
</form>
</div>
</body>
</html>