package io.rain.business.ws.cargo.otms.bean;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedCargoDescription{
	
	@XmlElement(name="productCode")
	public String productCode;
	
	@XmlElement(name="productName")
	public String productName;
	
	@XmlElement(name="unitWeight")
	public Double unitWeight=0.0 ;
	
	@XmlElement(name="unitType")
	public String unitType="4";
	
	@XmlElement(name="unitInsurance")
	public Double unitInsurance=0.0;
	
	public  ImportedCargoDescription(RData rdata){
		this.productCode = rdata.getString("productCode");
		this.productName = rdata.getString("productName");
		this.unitType = rdata.getString("unit");
		if(rdata.get("unitWeight")!=null)
			this.unitWeight = rdata.getDouble("unitWeight");
		/*if(rdata.get("quantity")!=null &&!isInt(rdata.getDouble("quantity"))){
			this.unitInsurance =rdata.getDouble("quantity");
		}*/
	}
	
	private boolean isInt(Double val) {
		int i = String.valueOf(val).indexOf(".");
		if(val%Integer.parseInt(String.valueOf(val).substring(0, i))==0){
			return true;
		}
		return false;
		
	}
}
