package io.rain.business.ws.cargo.ec.bean;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class TextFieldsEC{
	
	//业务员对应saler
	public String text1;
	
	//出库日期对应Documents_time
	public String text2;
	
	//月结账号对应custid
	public String text3;

	
	public  TextFieldsEC(RData rdata){
		this.text1 = rdata.getString("customtext3");
		this.text2 = rdata.getString("customtext6ec");
		this.text3 = rdata.getString("custid");
		if("KC".equals(this.text3)){
			this.text3="SW";
		}
		
	}
}