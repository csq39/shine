package io.rain.business.ws.cargo.ec.bean;

import java.util.ArrayList;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class OrderECLine{
	
	public int seq;
	public String code;
	public String name;
	public String unit;
	public int quantity;
	
	public  OrderECLine(RData rdata){
		if(rdata.get("quantity")!=null)
			this.quantity = (int)rdata.getDouble("quantity");
		this.seq = rdata.getInt("seq");
		this.code = rdata.getString("productCode");
		this.name = rdata.getString("productName");
		this.unit = rdata.getString("unit");
	}
	
	public static ArrayList<OrderECLine> getOrderListByData(RData rdata){
		ArrayList<OrderECLine> orderLines= new ArrayList<OrderECLine>();
		ArrayList<RData> orderLinesData= (ArrayList<RData>)rdata.get("orderLines");
		
		for (RData item : orderLinesData) {
			orderLines.add(new OrderECLine(item));
		}
		
		return orderLines;
		
	}
	
}