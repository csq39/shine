package io.rain.business.ws.cargo.otms.bean;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedCustomFields{
	
	@XmlElement(name="customText1")
	public String customText1;
	
	@XmlElement(name="customText2")
	public String customText2;
	
	@XmlElement(name="customText3")
	public String customText3;
	
	@XmlElement(name="customText4")
	public String customText4;
	
	@XmlElement(name="customText5")
	public String customText5;
	
	@XmlElement(name="customText6")
	public String customText6;
	
	@XmlElement(name="customText7")
	public String customText7;
	
	@XmlElement(name="customText8")
	public String customText8;
	
	@XmlElement(name="customText9")
	public String customText9;
	
	@XmlElement(name="customText10")
	public String customText10;
	
	@XmlElement(name="customText11")
	public String customText11;
	
	@XmlElement(name="customText12")
	public String customText12;
	
	@XmlElement(name="customText13")
	public String customText13;
	
	@XmlElement(name="customText14")
	public String customText14;
	
	@XmlElement(name="customText15")
	public String customText15;
	
	@XmlElement(name="customText16")
	public String customText16;
	
	@XmlElement(name="customText17")
	public String customText17;
	
	@XmlElement(name="customText18")
	public String customText18;
	
	@XmlElement(name="customText19")
	public String customText19;
	
	@XmlElement(name="customText20")
	public String customText20;
	
	@XmlElement(name="customText21")
	public String customText21;
	
	@XmlElement(name="customText22")
	public String customText22;
	
	@XmlElement(name="customText24")
	public String customText24;
	
	@XmlElement(name="customText26")
	public String customText26;
	
	@XmlElement(name="customText27")
	public String customText27="轻货";
	
	
	public  ImportedCustomFields(RData rdata){
		this.customText1 = rdata.getString("customtext1");
		this.customText2 = rdata.getString("customtext2");
		this.customText3 = rdata.getString("customtext3");
		this.customText4 = rdata.getString("customtext4");
		this.customText5 = rdata.getString("customtext5");
		this.customText6 = rdata.getString("customtext6");
		this.customText7 = rdata.getString("customtext7");
		//this.setCustomText8(rdata.getString("customtext8"));
		this.customText9 = rdata.getString("customtext9");
		this.customText10 = rdata.getString("customtext10");
		this.customText11 = rdata.getString("customtext11");
		this.customText12 = rdata.getString("customtext12");
		this.customText13 = rdata.getString("customtext13");
		this.customText14 = rdata.getString("customtext14");
		//this.setCustomText15(rdata.getString("customtext15"));
		//this.setCustomText16(rdata.getString("customtext16"));
		//this.setCustomText17(rdata.getString("customtext17"));
		this.customText18 = rdata.getString("customtext18");
		this.customText19 = rdata.getString("customtext19");
		this.customText20 = rdata.getString("customtext20");
		this.customText21 = rdata.getString("customtext21");
		this.customText22 = rdata.getString("customtext22");
		this.customText24 = rdata.getString("customText24");
		this.customText26 = rdata.getString("custid");
		
		if("KC".equals(this.customText26)){
			this.customText26="SW";
		}
	}
	
	
	
}
