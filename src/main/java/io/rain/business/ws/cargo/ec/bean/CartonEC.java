package io.rain.business.ws.cargo.ec.bean;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class CartonEC{
	
	public Double weight;
	public Double volume;
	public Double length;
	public Double width;
	public Double height;
	public Double value;
	public String unit;
	public int quantity;
	public String remark;
	
	public  CartonEC(RData rdata ) {
		if(rdata==null) return ;
		this.quantity= rdata.getInt("quantity");
	}
}