package io.rain.business.ws.cargo.otms.bean;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedOrderLineCustomFields{
	
	@XmlElement(name="customText23")
	public Double customText23=0.0;
	
	@XmlElement(name="customText8")
	public String customText8;
	
	@XmlElement(name="customText15")
	public String customText15;
	
	@XmlElement(name="customText16")
	public String customText16;
	
	@XmlElement(name="customText17")
	public String customText17;
	
	
	
	public  ImportedOrderLineCustomFields(RData rdata){
		if(rdata.get("quantity")!=null &&!isInt(rdata.getDouble("quantity"))){
			this.customText23 = rdata.getDouble("quantity");
		}
		this.customText8 = rdata.getString("billcode");
		this.customText15 = rdata.getString("materialBatch");
		this.customText16 = rdata.getString("releaseDate");
		this.customText17 = rdata.getString("expiringDate");
	}
	
	private boolean isInt(Double val) {
		int i = String.valueOf(val).indexOf(".");
		if(val%Integer.parseInt(String.valueOf(val).substring(0, i))==0){
			return true;
		}
		return false;
		
	}
	
	
}
