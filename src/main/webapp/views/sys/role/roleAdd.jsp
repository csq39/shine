<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>角色新增</title>
<%@include file="/core/include/head.jsp"%>
<link href="${ctxStatic}/plugins/zTree/v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
<script type="text/javascript">

	$(document).ready(function() {
		fncInitMenu();
		validator = $("#form").validate();
	}); 
	
	var setting = {
		check : {
			enable : true,
			chkStyle : "checkbox",
			chkboxType : {
				"Y" : "ps",
				"N" : "s"
			}
		},
		data : {
			simpleData : {
				enable : true
			}
		},
	};
	
	// 初始化
	function fncInitMenu() {
		$.ajax({
			type : "post",
			url : ctx + "/role/getAllMenu",
			success : function(data) {
				zTree = $.fn.zTree.init($("#tree"), setting, data);
				var nodes = zTree.getNodes();
				for(var i=0;i<nodes.length;i++){
					if (nodes[i].level==0) {
						zTree.expandNode(nodes[i], true, false, false);
					}
				}
			},
			error : function() {
				rayDialog("请求失败")
			}
		});
	}
	
	//保存按钮
	function fncSave() {
		if(validator.form()){
			var menuIds =[{
					"roleName" : $('#roleName').val().trim(),
					"roleEnname" : $('#roleEnname').val().trim(),
					"remarks" : $('#remarks').val().trim()
					}];
			
			var selectedNode = zTree.getCheckedNodes();
			for (var i = 0,j = 0; i < selectedNode.length; i++) {
				var node = selectedNode[i];
				if(node.type == 'btn'){//按钮
					menuIds.push({menuPid:node.pId,permissionCode:node.id}); 
				}	
				if(node.type == 'menu'){//meun
					menuIds.push({menuId:node.id});
				}
			}
			$.ajax({
				url : ctx + "/role/createRole",
				type : "POST",
				data :{jsonDt:JSON.stringify(menuIds)} ,
				success : function(msg) {
					if (msg == "0") {
						rayDialog("保存成功",function(){
							actCancel($('#form'), ctx + "/role");
						});
						
					} else {
						rayDialog("该角色名称已经存在，请输入其他角色名称！");
					}
				},
				error : function() {
					rayDialog("保存失败");
				}
			});
		}
	}
	
	//返回按钮
	function fncCancel() {
		actCancel($('#form'), ctx + "/role");
	}
	
</script>
</head>
<body>
<div class="page-container ">
	<div class="codeView docs-example user ">
		<form class="form-horizontal" id="form" action="" method="post">
			<legend>新增角色权限</legend>
			<div class="row cl mt-5">
				<div class="formControls col-xs-4 col-sm-4 ">
					<div class="formControls col-xs-4 col-sm-4">
						<div class="ztreeBackground right" style="height:100%; overflow:auto; width:320px;height:400px; border:1px solid #efefef">
							<ul id="tree" class="ztree"></ul>
						</div>
					</div>
				</div>
				<div class="formControls col-xs-8 col-sm-8" style="height:100%;width:700px;min-height:400px;border:1px solid #efefef">
					<div class="row cl mt-5">
						<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>角色名称</label>
						<div class="formControls col-xs-5 col-sm-5">
							<input type="text" validata="{required:true,rangelength:[0,30]}" placeholder="角色名称" data-toggle="tooltip" data-placement="bottom" class="input-text radius size-S" id="roleName" name="roleName" >
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="row cl mt-5">
						<label class="form-label col-xs-3 col-sm-3"><span class="c-red">*</span>英文名称</label>
						<div class="formControls col-xs-5 col-sm-5">
							<input type="text" placeholder="英文名称" data-toggle="tooltip" data-placement="bottom" validata="{required:true,rangelength:[0,30],isEnglish:true}" class="input-text radius size-S" id="roleEnname" name="roleEnname"  >
							<span class="fa fa-check-square-o txt-danger form-control-feedback"></span>
						</div>
					</div>
					<div class="row cl mt-5">
						<label class="form-label col-xs-3 col-sm-3">备注</label>
						<div class="formControls col-xs-5 col-sm-5">
							<textarea rows="3" cols="60" validata="{rangelength:[0,60]}" class="textarea" placeholder="备注" id="remarks" name="remarks" style="width:335px;"></textarea>
						</div>
					</div>
					<div class="row cl mt-5">
						<div class="col-xs-5 col-sm-5 col-sm-offset-7">
							<button type="button" class="btn btn-primary radius" onclick="fncSave()">
								<i class="Hui-iconfont">&#xe632;</i>保&nbsp;存
							</button>
							<button type="button" class="btn btn-default radius cancel" onclick="fncCancel()">
								返&nbsp;回
							</button>
						</div>
					</div>				
				</div>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript"	src="${ctxStatic}/plugins/zTree/v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"	src="${ctxStatic}/plugins/zTree/v3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"	src="${ctxStatic}/plugins/zTree/v3/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript"	src="${ctxStatic}/plugins/zTree/v3/js/jquery.ztree.excheck-3.5.min.js"></script>
</body>
</html>
