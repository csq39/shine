package io.rain.business.ws.cargo.otms.bean;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;
import io.rain.utils.string.StringUtils;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedContactPerson{
	
	@XmlElement(name="name")
	public String name;
	
	@XmlElement(name="phone")
	public String phone;
	
	@XmlElement(name="phoneAreaCode")
	public String phoneAreaCode;
	
	@XmlElement(name="mobile")
	public String mobile;
	
	public  ImportedContactPerson(RData rdata,String type){
		if("shipFrom".equals(type)){
			this.name = rdata.getString("shipFromContactName");
			this.phone = rdata.getString("shipFromContactPhone");
			this.phoneAreaCode=rdata.getString("shipFromContactPhoneAreaCode");
			this.mobile =rdata.getString("shipFromContactMobile");
			if(!StringUtils.isEmpty(mobile)&&mobile.endsWith(";")) {
				this.mobile =this.mobile.substring(0, this.mobile.length()-1);
			}
		}else if("shipTo".equals(type)){
			this.name = rdata.getString("shipToContactName");
			this.phone = rdata.getString("shipToContactPhone");
			this.phoneAreaCode=rdata.getString("shipToContactPhoneAreaCode");
			this.mobile =rdata.getString("shipToContactMobile");
			if(!StringUtils.isEmpty(mobile)&&mobile.endsWith(";")) {
				this.mobile =this.mobile.substring(0, this.mobile.length()-1);
			}
		}
	}
		

	
}
