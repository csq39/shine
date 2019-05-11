package io.rain.business.ws.cargo.ec.bean;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class AddressEC{
	
	public String company;
	public String contact;
	public String phone;
	public String mobile;
	public String email;
	public String postcode;
	public String province;
	public String town;
	public String county;
	public String address;
	public String remark;
	
	public  AddressEC(RData rdata,String type){
		if("shipFrom".equals(type)){
			this.company = rdata.getString("shipFromCompanyName");
			this.contact = rdata.getString("shipFromContactName");
			this.province = rdata.getString("shipFromProvince");
			this.town = rdata.getString("shipFromTown");
			this.county =rdata.getString("shipFromCounty");
			this.address = rdata.getString("shipFromAddress");
			this.phone = rdata.getString("shipFromContactPhone");
			this.mobile =rdata.getString("shipFromContactMobile");
		}else if("shipTo".equals(type)){
			this.company=rdata.getString("shipToCompanyName");
			this.contact = rdata.getString("shipToContactName");
			this.province =rdata.getString("shipToProvince");
			this.town = rdata.getString("shipToTown");
			this.county= rdata.getString("shipToCounty");
			this.address =rdata.getString("shipToAddress");
			this.phone = rdata.getString("shipToContactPhone");
			this.mobile =rdata.getString("shipToContactMobile");
		}
		
	}
}