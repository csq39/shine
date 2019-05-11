<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title>随货同行单</title>
<%@include file="/core/include/head.jsp" %>	
<script type="text/javascript">
	$(document).ready(function() {
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
		
		$('#datatable-form').on( 'draw.dt', function () {
			var arr = table.rows().data();
			for(var i = 0; i <arr.length;i++){
				if(arr[i].type == 1){
					$('#datatable-form').find('tr').eq(i+1).find('select').val("OTMS");
				}/* else{
					$('#datatable-form').find('tr').eq(i+1).find('select').val(arr[i].carrier);
					
				} */
			}
		});
		
		$("#myCheck").click(function() {
			if(this.checked){
				$("input[name='checkbox']").prop("checked", true);
			}else{
				$("input[name='checkbox']").prop("checked", false);
			}
		});
	});
	
	
	function fncSendOtmsList() {
		if(!$('input[name="checkbox"]:checked').is(":checked")) {
			rayDialog("请选择发送的随货同行单！");
			return ;
		}
		var arr = table.rows().data();
		var billcode=new Array();
		var carrier=new Array();
		
		 $('input[name="checkbox"]:checked').each(function() {
			 
			 for(var i = 0; i <arr.length;i++){
					if(arr[i].billcode == $(this).val()){
						billcode.push($(this).val());
						carrier.push($('#datatable-form').find('tr').eq(i+1).find('select').val());
					}
				}
		 }); 
		 $.ajax({
		     type: "post",
		     url: "${ctx}/ship/cargo/sendOtmsCargoList",
		     data: {"billcode":billcode.join(),"carrier":carrier.join()} ,
		     async:false,
		     success: function(){
				rayDialog("操作完成",function(){
					table.ajax.reload();
				});
			 },
			 error:function(){
		    	rayDialog("操作产生了异常");
		    }
		 });
	
	}
	
	function fncSendOtms(billcode,status,id) {
		var arr = table.rows().data();
		var carrier;
		for(var i = 0; i <arr.length;i++){
			if(arr[i].id == id){
				carrier = $('#datatable-form').find('tr').eq(i+1).find('select').val();
			}
		}
		$.ajax({
		     type: "post",
		     url: "${ctx}/ship/cargo/sendOtmsCargo",
		     data: {"billcode":billcode,"carrier":carrier} ,
		     async:false,
		     success: function(){
				rayDialog("OTMS发送完成",function(){
					table.ajax.reload();
				});
			 },
			 error:function(){
		    	rayDialog("OTMS发送异常");
		    }
		 });
			
	}
	

</script>	
</head>
<body>
<rt:navigation/>
<div class="page-container manage">
	<div class="search-condition text-l clearfix mt-5">
	<form  id="form" method="post" action="/ship/cargo/queryCargoList">
		<span class="r ">
			来源：<rt:select2 id="custid" dataQuery="yes"  headerKey="-1" className="w140 radius size-S" headerValue="全部"  comCode="custid" itemValue="type" itemLabel="type"></rt:select2>
			状态：<rt:select2 id="outputStatus" dataQuery="yes"  headerKey="-1" className="w140 radius size-S" headerValue="全部"  comCode="cargotype" itemValue="type" itemLabel="type"></rt:select2>
			交货单:<input type="text" id="deliveryBillcode" data-query="yes" class="input-text w140 radius size-S">
			随货同行单:<input type="text" id="billcode" data-query="yes" class="input-text w140 radius size-S">
			<a href="javascript:;" class="btn btn-success radius" id="btnSearch"><i class="Hui-iconfont">&#xe665;</i>  查询</a>
		</span>	
	</form>
		<div class="cl mt-5">
		<span class="l">
			<a href="javascript:;" onclick="fncSendOtmsList()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 发送</a>
		</span>
		</div>
	</div>
	<div class="mt-10 clearfix">
	<div class="panel panel-default pt-0">
		<table class="table table-border table-bordered table-bg table-hover table-sort table-responsive" id="datatable-form"  width="100%" style="wiite-spac:nowrap">
			<thead>
				<tr>
					<th data-column="op" data-method="[
										{targets:0,params:'billcode',
										htmlAppend:'<input type=\'checkbox\' name=\'checkbox\' value=\'billcode\'>'}
										]">
										<input type="checkbox" id="myCheck" class="form-control"/>
										</th>
					<th data-column="num" >序号</th>
					<th data-column="billcode" >随货同行单</th>
					<th data-column="outputStatus" >状态</th>
					<th data-column="deliveryBillcode" >交货单</th>
					<th data-column="salerPhone" >业务员电话</th>
					<th data-column="shipper" >发货方</th>
					<th data-column="cneeTown" >收货地址(市县)</th>
					<th data-column="cneeAdd" >详细地址</th>
					<th data-column="cneeContacts" >收货人</th>
					<th data-column="custid" >来源</th>
					<th data-column="op" data-method="[
								{targets:-2,params:'carrier',
								htmlAppend:'<select id=\'carrier\' name=\'carrier\' class=\'w50 radius size-S\' ><option value=\'OTMS\'>OTMS</option> <option selected value=\'SF\'>顺丰</option> <option value=\'EMS\'>EMS</option></select>'}]">承运商</th>
					<th data-column="op"  data-method="[{targets:-1,title:'发送',fncName:'fncSendOtms',params:'billcode,status,id',icon:'detail'}]">操作</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	</div>
</div>
</body>
</html>