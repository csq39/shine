package io.rain.business.ws.cargo.otms.bean;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedLocation{
	
	@XmlElement(name="companyName")
	public String companyName;
	
	@XmlElement(name="postcode")
	public String postcode;
	
	@XmlElement(name="province")
	public String province;
	
	@XmlElement(name="town")
	public String town;
	
	@XmlElement(name="county")
	public String county;
	
	@XmlElement(name="xttSupport")
	public boolean xttSupport=true;
	
	@XmlElement(name="address")
	public String address;
	
	@XmlElement(name="contact")
	public ImportedContactPerson contact;
	
	public  ImportedLocation(RData rdata,String type){
		if("shipFrom".equals(type)){
			this.companyName = rdata.getString("shipFromCompanyName");
			this.province = rdata.getString("shipFromProvince");
			this.town = rdata.getString("shipFromTown");
			this.county =rdata.getString("shipFromCounty");
			this.address = rdata.getString("shipFromAddress");
			this.contact =new ImportedContactPerson(rdata,"shipFrom");
		}else if("shipTo".equals(type)){
			this.companyName=rdata.getString("shipToCompanyName");
			this.province =rdata.getString("shipToProvince");
			this.town = rdata.getString("shipToTown");
			this.county= rdata.getString("shipToCounty");
			this.address =rdata.getString("shipToAddress");
			this.contact = new ImportedContactPerson(rdata,"shipTo");
		}
		
	}
	
	
}
