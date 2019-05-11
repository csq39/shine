"use strict";

var rayUpload = layui.upload;
$.fn.rayImgUpload=function(attchId,defaultImgId,callback,eventFired){
	var imgId = this[0].id;
	this.addClass("img-uplaod");
	this.text("");// 清空数据
	this.append("<div class=\"upload-thumb\">"+
                "<img id=\""+imgId+"_img"+"\" src=\""+ctxStatic+"/img/default_upload_image.gif\" height='160' width='160'>"+
                "</div>"+
                "<div class=\"mt-10 img-upload-btn\">"+
                "<a type=\"button\" class=\"btn btn-primary radius\" id=\""+imgId+"_btn"+"\">"+
                "	<i class=\"Hui-iconfont\">&#xe642;</i>上传图片 "+
                "</a>"+
                "</div>"); 
	
    if(defaultImgId){
    	$('#'+imgId+"_img").attr('src',ctxCdn+'/file/showImg?fileId='+defaultImgId);    
    	$('#'+imgId+"_img").click(function(){
    		fncShowImg(ctxCdn+'/file/showImg?fileId='+defaultImgId);
    	});
    }     
	rayUpload.render({
        elem:"#"+imgId+"_btn", //绑定元素
         url: ctxCdn+"/file/upload",
      accept:'images',
        data:{eventFired:eventFired,sysName:'mhs'},
        done: function (data) {
        	if(data.error==""){
	   	 		$('#'+attchId).val(data.fileId);
	   	 		$('#'+imgId+"_img").attr('src',ctxCdn+'/file/showImg?fileId='+data.fileId);    
	   	 		$('#'+imgId+"_img").unbind("click");
		   	 	$('#'+imgId+"_img").click(function(){
		   	 		fncShowImg(ctxCdn+'/file/showImg?fileId='+data.fileId);
		    	});
	   	 		if(typeof callback == "function")  callback();
	   	 	}
        },
       error: function () {
            //请求异常回调
        }
    }); 
}; 
$.fn.rayFileUpload=function(attchId,defaultImgId,callback,eventFired){
	var imgId = this[0].id;
	this.addClass("btn-upload");
	this.text("");// 清空数据
	this.append("<a href=\"javascript:void(0);\" class=\"btn btn-primary radius\" id=\""+imgId+"_btn"+"\">"+
			"<i class=\"Hui-iconfont\">&#xe642;</i>上传 </a>"); 
	 if(defaultImgId)     
		 $("#"+imgId+"_btn").after('<a id="uploadContent" href="'+ ctxCdn+'/file/download?fileId='+defaultImgId+'" target="_blank">附件查看</a>');    
	rayUpload.render({
		elem:"#"+imgId+"_btn", //绑定元素
		url: ctxCdn+"/file/upload",
		accept:'file',
		data:{eventFired:eventFired,sysName:'mhs'},
		done: function (data) {
			if(data.error==""){
				$('#'+attchId).val(data.fileId);
	   	 		$("#"+imgId+"_btn").next("#uploadContent").remove();
	   	 		$("#"+imgId+"_btn").after('<a id="uploadContent" href="'+ ctxCdn+'/file/download?fileId='+data.fileId+'" target="_blank">'+data.OriginalFilename+'</a>');
	   	 	 if(typeof callback == "function")  callback();
			}
		},
		error: function () {
			//请求异常回调
		}
	}); 
}; 


$.fn.raymultiplefileUpload=function(fileList){
	return this.fileinput({
	     	language: 'zh', 
			'theme': 'explorer',
			uploadAsync:true,
			browseClass:"btn btn-primary btn-xs",
			removeClass:"btn btn-default btn-xs",
			uploadClass:"btn btn-default btn-xs",
			cancelClass:"btn btn-default btn-xs",
			uploadUrl: ctxCdn+"/file/upload", 
        }).on("filebatchselected", function(event, files) {
            $(this).fileinput("upload");
        }).on('fileuploaded', function(event, data, previewId, index) {
        	fileList.push({ fileId: data.response.fileId, KeyID: previewId })
	    }).on("filesuccessremove", function (event, data, previewId, index) { 
	    	 for (var i = 0; i < fileList.length; i++) { 
	    	      if (fileList[i].KeyID== data) { 
	    	    	  fileList.splice(i,1);
		    	      return;
	    	      } 
	    	   }
		}).on('fileclear', function(event) {	
			fileList.length = 0;
		});
}; 

function fncShowImg( url) {
	$("#imgShowDiv").remove();
	$(document.body).append("<div id='imgShowDiv' class='hide'><img src='"+url+"' height='516px' width='450px'></div>");
	
    layer.open({
        type: 1,
        title:false,
        closeBtn:0,
        shadeClose:true,
        area:['450px','516px'],
        shade:0.8,
        content: $("#imgShowDiv")
    });;
}
$.fn.materialCategoryRadioTree=function(data){
	data.url = "/popup/materialCategoryPopup";
	window.treeLvl = 6;
	this.radioTree(data);
}

$.fn.radioTree=function(data){
	var selectedValue=data.values;
	var id=data.id;
	var name=data.name?data.name:this[0].id;
	var url=data.url;
	var defaultData=data.defaultData;
	var callback=data.callback;
	
	window.selectedValue = selectedValue;
	window.defaultData = defaultData;
	window.dataUrl = url;
	var treeLvl="";
	if(window.treeLvl) 
		treeLvl = window.treeLvl;
	this.on('click', function () {
		if(window.treeLvl&&treeLvl!=window.treeLvl){
			treeLvl =window.treeLvl;
			popup.remove();
		}
		window.popup =dialog({
			id: id+'-dialog',
			align: 'bottom left',
		    width: 400,
		    height: 400,
		    padding: 0, 
			url: ctx+'/popup/radio',
			quickClose: true,
			onshow: function () { 
			},
			oniframeload: function () {
			},
			onclose: function () {
				if (this.returnValue) {
					$('#'+name).val(this.returnValue.name);
					$('#'+id).val(this.returnValue.id);
					window.selectedValue = this.returnValue.id;
					if(typeof callback == "function")  callback();
				}
			},
			onremove: function () {
			}
		});
		popup.show(this);
	});
}; 


$.fn.materialCategoryCheckboxTree=function(data){
	data.url = "/popup/materialCategoryPopup";
	window.treeLvl = 6;
	this.checkboxTree(data);
}


$.fn.checkboxTree=function(data){
	var selectedValue=data.values;
	var id=data.id;
	var name=data.name?data.name:this[0].id;
	var url=data.url;
	var defaultData=data.defaultData;
	var callback=data.callback;
	
	window.selectedValue = selectedValue;
	window.defaultData = defaultData;
	window.dataUrl = url;
	var treeLvl="";
	if(window.treeLvl) 
		treeLvl = window.treeLvl;
	this.on('click', function () {
		if(window.treeLvl&&treeLvl!=window.treeLvl){
			treeLvl =window.treeLvl;
			popup.remove();
		}
		window.popup =dialog({
			id: id+'-dialog',
			align: 'bottom left',
		    width: 400,
		    height: 400,
		    padding: 0, 
			url: ctx+'/popup/checkbox',
			quickClose: true,
			onshow: function () { 
			},
			oniframeload: function () {
			},
			onclose: function () {
				if (this.returnValue) {
					$('#'+name).val(this.returnValue.name);
					$('#'+id).val(this.returnValue.id);
					window.selectedValue = this.returnValue.id;
					if(typeof callback == "function")  callback();
				}
			},
			onremove: function () {
			}
		});
		popup.show(this);
	});
	
	
}; 