package io.rain.business.ws.cargo.otms.bean;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedCargoDetails{
	@XmlElement(name="cargoType")
	public int cargoType=1;
	
	@XmlElement(name="packageType")
	public String packageType="A";
	
	/*@XmlElement(name="totalInsurance")
	public Double totalInsurance=0.0;*/
	
	
	public  ImportedCargoDetails(RData rdata){
		/*if(rdata.get("quantity")!=null)
			*/
	}
}
