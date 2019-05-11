package io.rain.business.ws.cargo.otms.bean;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedTimeSchedule{
	
	@XmlElement(name="pickupDate")
	public String pickupDate;
	
	@XmlElement(name="pickupDateRemarks")
	public String pickupDateRemarks;
	
	@XmlElement(name="deliveryDate")
	public String deliveryDate;
	
	@XmlElement(name="deliveryDateRemarks")
	public String deliveryDateRemarks;
	
	@XmlElement(name="pickupTimeFrom")
	public String pickupTimeFrom;
	
	@XmlElement(name="pickupTimeTo")
	public String pickupTimeTo;
	
	@XmlElement(name="deliveryTimeFrom")
	public String deliveryTimeFrom;
	
	@XmlElement(name="deliveryTimeTo")
	public String deliveryTimeTo;
	
	public  ImportedTimeSchedule(RData rdata){
		this.pickupDate = rdata.getString("pickupDate");
		this.deliveryDate=rdata.getString("deliveryDate");
		this.pickupTimeFrom = rdata.getString("pickupTimeFrom");
		this.pickupTimeTo=rdata.getString("pickupTimeTo");
		this.deliveryTimeFrom =rdata.getString("deliveryTimeFrom");
		this.deliveryTimeTo=rdata.getString("deliveryTimeTo");
	}
	
	
}
