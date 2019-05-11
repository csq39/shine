package io.rain.business.ws.cargo.ec.bean;

import java.util.ArrayList;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class OrderECItem{
	
	public int seq;
	public String orderNo;
	public String transportNo;
	public AddressEC shipFrom;
	public AddressEC shipTo;
	public CartonEC cartonInfo;
	public TextFieldsEC textFields;
	public String mailNo;
	public String mailType;
	public Double cod;
	public Boolean isFreightCollect=false;
	public String remark;
	public ArrayList suggestCarriers;
	public  Boolean isInSuggestCarriers=false;
	public String pickupSla;
	public String signSla;
	public ArrayList orderLines =new ArrayList();
	//public ArrayList<OrderECLine> orderLines =new ArrayList();
	public  Boolean isOnline=true;
	public String offlineConfirmTime;
	public int mailPieces=0;
	public Double cost;
	
	public OrderECItem(RData rdata){
		if(rdata==null) return ;
		
		this.orderNo=rdata.getString("erpNumber");
		this.remark =rdata.getString("customtext18");
		this.pickupSla =rdata.getString("pickupDateec");
		this.signSla =rdata.getString("deliveryDateec");
		
		this.shipFrom =new AddressEC(rdata,"shipFrom");
		this.shipTo=new AddressEC(rdata,"shipTo");
		//this.orderLines =OrderECLine.getOrderListByData(rdata);
		this.cartonInfo=new CartonEC(rdata);
		this.textFields=new TextFieldsEC(rdata);
		ArrayList<RData> orderLine = (ArrayList<RData>)rdata.get("orderLines");
		if(orderLine!=null){
			for (RData item : orderLine) {
				this.mailPieces += (int)rdata.getDouble("quantity");
			}
		}
		//this.suggestCarriers =rdata.getString("erpNumber");
		//this.mailNo =rdata.getString("erpNumber");
		////this.mailType =rdata.getString("erpNumber");
		//this.cod =rdata.getString("erpNumber");
		//this.cost =rdata.getString("erpNumber");
		
	

		
	}
	
}