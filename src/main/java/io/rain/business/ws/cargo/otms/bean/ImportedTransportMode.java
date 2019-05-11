package io.rain.business.ws.cargo.otms.bean;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedTransportMode{
	
	@XmlElement(name="transportType")
	public String transportType="LTL";
	
	@XmlElement(name="truckType")
	public String truckType="2";
	
	public  ImportedTransportMode(RData rdata){
		if(rdata.get("transportType")!=null) {
			this.transportType = rdata.getString("transportType");
		  }
			
	}
}
