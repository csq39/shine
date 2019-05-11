<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>首页</TITLE>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<%@include file="/core/include/head.jsp"%>
<title>首页</title>
</HEAD>

<body style="background-color:#f5f5f5;">
<c:set var="date" value="<%=new java.util.Date()%>"/> 
<c:set var="orgType" value="${fns:getUser().userData.orgType}"/> 
<nav class="breadcrumb">
    <i class="Hui-iconfont">&#xe67f;</i> 首页
    <a class="btn btn-success radius r" href="javascript:location.replace(location.href);" title="刷新">
        <i class="Hui-iconfont">&#xe68f;</i>
    </a>
</nav>
<div class="page-container manage hospital-index">
	<div class="row cl">
	    <form  id="form" ></form>
		<div class="col-xs-12 col-sm-7">
			<div class="hospital row clearfix">
			<div class="col-sm-3 user">
				<img src="${ctxStatic}/img/avator.png">
					<p>你好，<span>${fns:getUser().name}</span></p>
			 </div>
			<div class="col-sm-9 clearfix">
				<img src="${ctxStatic}/img/split.png" style="height:136px;" class="f_left">
	        	<div class="f_right hos-info">
	            	<div class="today">今天是：<span><fmt:formatDate value="${date}" pattern="E"/><fmt:formatDate value="${date}" pattern="yyyy年MM月dd日" type="date" dateStyle="full"/></span></div>
	            	<div class="name">${fns:getUser().userData.orgName}</div>
	            	<ul class="hos-operate">
	            		<li data-type="account">
	                		<a data-href="userEdit/toHostInfo?type=0" data-title="账户管理" href="javascript:void(0);" onclick="fncQueryUser();">
	                     		<img src="${ctxStatic}/img/manage-account.png">账户管理</a>
	                  	</li>
					<c:if test="${orgType=='0'}">
						<li data-type="info">
	                       	<a data-href="userEdit/toHostInfo?type=1" data-title="医院资料" href="javascript:void(0);" onclick="showDialog('医院资料', 'userEdit/toHostInfo?type=1')">
	                       		<img src="${ctxStatic}/img/manage-info.png">医院资料</a>
	                   	</li>
	              	</c:if>
	                <c:if test="${orgType=='1'}">
	                  	<li data-type="info">
	                      	<a data-title="企业资料" href="javascript:void(0);" onclick="goProfile()">
	                        	<img src="${ctxStatic}/img/manage-info.png">企业资料</a>
	                	</li>
	     			 </c:if>
	               	</ul>
	          	</div>
	      	</div>
			</div>
	  	</div>
	    <div class="col-xs-12 col-sm-5">
			<div class="order">
	 		<div class="panel">
				<div class="panel-header">订购提醒</div>
				<div class="panel-body">
				<ul class="index-order clearfix">
					<li>
						<a style="cursor:default">
							<img src="${ctxStatic}/img/icon-1.png"><h5>未发货<span>${orderRemind.notShipped}</span></h5>
	                   	</a>
	              	</li>
	             	<li>
	                   	<a style="cursor:default">
	                       	 <img src="${ctxStatic}/img/icon-2.png"><h5>已发货<span>${orderRemind.shipped}</span></h5>
	                  	</a>
	               	</li>
	                <li>
	                 	<a style="cursor:default">
	                     	<img src="${ctxStatic}/img/icon-3.png"><h5>所有订单<span>${orderRemind.all}</span></h5>
	                  	</a>
	              	</li>
	           	</ul>
	            </div>
	      	</div>
	        </div>
	   	</div>
	</div>
	<div class="row cl mt-10">
		<div class="col-xs-12 col-sm-6" style="padding-right:0;">
		<div class="supplier">
			<div class="panel">
			<div class="panel-header">
	        <c:if test="${orgType=='0'}">
	  			我的企业
	       	</c:if>
	       	<c:if test="${orgType=='1'}">
	           	我的医院
	    	</c:if>
	    	</div>
		    <div class="panel-body clearfix">
	        	<div class="f_left index-supplier" style="width:20%;">
	            	<span>${homeInfo.allPartner}</span>家
	                <input type="hidden" id="orgType" name="orgType" value="${orgType}">
	          	</div>
					<div id="container" class="ct-chart tab-pane fade in active" style="height: 250%; width: 100%;"></div>
	     	</div>
	       	</div>
		</div>
		</div>
	  	<div class="col-xs-12 col-sm-6">
	  		<div class="myorder">
	     	<div class="panel">
	       		<div class="panel-header">我的采购单</div>
	          	<div class="panel-body clearfix">
	           		<div class="f_left index-supplier" style="width:20%;">
	                  	<span>${homeInfo.orderNum}</span>单
	                </div>
	                <div class="box-content">
						<div id="container1" class="ct-chart tab-pane fade in active" style="height: 250%; width: 100%;"></div>
	      	 		</div>
	                <!-- div class="f_right" id="container1" style="width:80%;height:230px"></div> -->
	          	</div>
	       	</div>
	        </div>
	    </div>
	</div>
</div>
<script>
    $(function () {
        $('.hos-operate li').hover(function () {
            var type = $(this).attr('data-type');
            var img = $(this).find('img')

            if (type == "account")
                img.attr('src', '${ctxStatic}/img/manage-account-b.png');
            else if (type == "info")
                img.attr('src', '${ctxStatic}/img/manage-info-b.png');
        }, function () {
            var type = $(this).attr('data-type');
            var img = $(this).find('img')

            if (type == "account")
                img.attr('src', '${ctxStatic}/img/manage-account.png');
            else if (type == "info")
                img.attr('src', '${ctxStatic}/img/manage-info.png');
        });
        aloadPie();
        aloadLine();
    });

</script>
<script src="${ctxStatic}/plugins/echarts/3.2.2/echarts.js"></script>
<script type="text/javascript">
  //饼图
	function aloadPie(){
		var dom = document.getElementById("container");
		var myChart = echarts.init(dom);
		myChart.setOption(getPieOption());
		/*  // 处理点击事件并且跳转到物资效期页面
	    myChart.on('click', function (params) {
			actSubmit($('#form'), ctx+"/materialQualification");
	    }); */
	}
    function getPieOption(){	  
    	var dataArray = [{value:0, name:'无省份'}];
    	/* $.ajax({
			async : false,
			cache : false,
			type : "post",
			url : ctx + "/main/getPie?userType="+$("#orgType").val(),
			success : function(data) {
				if(data==''){
				}else{
					dataArray=data;
				}
			},
			error : function() {
				//rayDialog("请求失败")
			}
		});  */
    	var option = {
    		    title : {
    		        x:'center'
    		    },
    		    tooltip : {
    		        trigger: 'item',
    		        formatter: "{a} <br/>{b} : {c} ({d}%)"
    		    },
    		    series : [
    		        {
    		            name: '访问来源',
    		            type: 'pie',
    		            radius : '60%',
    		            center: ['50%', '60%']/* ,
    		            data:
    		             dataArray    */
    		            ,
    		            itemStyle: {
    		                emphasis: {
    		                    shadowBlur: 10,
    		                    shadowOffsetX: 0,
    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
    		                }
    		            }
    		        }
    		    ]
    		};
    	return option;
    }
    //线图
    function aloadLine(){
    	var dom1 = document.getElementById("container1");
		var myChart1 = echarts.init(dom1);
		myChart1.setOption(getLineOption());
		 // 处理点击事件并且跳转到物资效期页面
/* 	    myChart1.on('click', function (params) {
			actSubmit($('#form'), ctx+"/materialQualification");
	    });	 */		 
    }
    function getLineOption(){
    	var dataAxis = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];
    	var dataValue = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		
    	/* $.ajax({
			async : false,
			cache : false,
			type : "post",
			url : ctx + "/main/getLine?userType="+$("#orgType").val(),
			success : function(data) {
				if(data==''){
				}else{
					dataValue=data;
				}
			},
			error : function() {
				//rayDialog("请求失败")
			}
		});  */
    	var option = {
    		    color: ['#3398DB'],
    		    tooltip : {
    		        trigger: 'axis',
    		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    		        }
    		    },
    		    grid: {
    		        left: '3%',
    		        right: '4%',
    		        bottom: '3%',
    		        containLabel: true
    		    },
    		    xAxis : [
    		        {
    		            type : 'category',
    		            data : dataAxis,
    		            axisTick: {
    		                alignWithLabel: true
    		            }
    		        }
    		    ],
    		    yAxis : [
    		        {
    		            type : 'value'
    		        }
    		    ],
    		    series : [
    		        {
    		            name:'直接访问',
    		            type:'bar',
    		            barWidth: '60%'/* ,
    		            data:dataValue */
    		        }
    		    ]
    		};
    	return option;
    }

    //打开弹层
    function showDialog(title, url) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    
    function fncQueryUser(){
    	actSubmit($('#form'), ctx + "/card/queryUser");
    }
    
    function goProfile(){
    	actSubmit($('#form'), ctx + "/profile/baseInfo");
    }
</script>
   
</body>

</html>