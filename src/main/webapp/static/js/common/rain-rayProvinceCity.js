$.fn.rayProvinceCity =function(loc_province,loc_city,loc_town) {
	
	var _self = this;
	//定义3个默认值
	_self.data("province",["", "请选择省"]);
	_self.data("city",["", "请选择市"]);
	_self.data("town",["", "请选择县"]);
	
	
	//插入3个空的下拉框
	_self.append("<select></select>");
	_self.append("<select></select>");
	_self.append("<select></select>");
	//分别获取3个下拉框
	var $sel1 = this;
	var $sel2 = this;
	var $sel3 = this;
	
	
    this.init=function(){
    	//默认省级下拉
    	if(_self.data("province")){
    		$sel1.append("<option value='"+_self.data("province")[0]+"'>"+_self.data("province")[1]+"</option>");
    	};

    	//默认的1级城市下拉
    	if(_self.data("city")){
    		$sel2.append("<option value='"+_self.data("city")[0]+"'>"+_self.data("city")[1]+"</option>");
    	};
    	//默认的2级城市下拉
    	if(_self.data("town")){
    		$sel3.append("<option value='"+_self.data("town")[0]+"'>"+_self.data("town")[1]+"</option>");
    	};
    	
    	//加载省份
    	fillOption($sel1 , "-1",loc_province,'province');
    	fillOption($sel2 , loc_province,loc_city,'city');
    	fillOption($sel3 , loc_city,loc_town,'town');
    };

	this.cityEL=function(city){
		$sel2 = $("#"+city);
		//1级城市联动 控制
		$sel2.change(function(){
			$sel3[0].options.length=0;
			if(_self.data("town")){
	    		$sel3.append("<option value='"+_self.data("town")[0]+"'>"+_self.data("town")[1]+"</option>");
	    	};
			fillOption($sel3 , $sel2.val(),"",'town');
		});
		
		return this;
    };
    
    this.townEL=function(town){
    	$sel3 = $("#"+town);
    	return this;
    };

	//省级联动 控制
	$sel1.change(function(){
		//清空其它2个下拉框
		$sel2[0].options.length=0;
		$sel3[0].options.length=0;
		
		if(_self.data("city")){
    		$sel2.append("<option value='"+_self.data("city")[0]+"'>"+_self.data("city")[1]+"</option>");
    	};
    	//默认的2级城市下拉
    	if(_self.data("town")){
    		$sel3.append("<option value='"+_self.data("town")[0]+"'>"+_self.data("town")[1]+"</option>");
    	};
    	
		if(this.selectedIndex!=0){	//当选择的为 “请选择” 时
			fillOption($sel2 , $sel1.val(),"",'city');
		}

	});
	
	return _self;
	
}


function fillOption(el , loc_id , selected_id,loc_type) {
	var $el	= el; 
	if(loc_id){
		$.ajax({
		     type: "post",
		     url: ctxFront+"/common/getProvinceCity",
		     data: {areaId:loc_id,areaType:loc_type},
		     async:false,
		     success: function(data){
				var selected_index	= 0;
				for(var i=0;i<data.length;i++){
					$el.append('<option value="'+data[i].areaId+'">'+data[i].areaName+'</option>');
					
					if (data[i].areaId == selected_id) {
						selected_index	= i+1;
					}
				}
				console.log("selectedIndex-"+selected_index);
				$el.prop('selectedIndex' , selected_index); 
			 }
		 });
	}
	
}