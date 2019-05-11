package io.rain.business.ws.cargo.otms.bean;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;

import io.rain.core.collection.RData;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class OrderOtms{
	
	@XmlAttribute(name="sequence")
	public int sequence;
	
	@XmlElement(name="clientCode")
	public String clientCode;
	
	@XmlElement(name="timeSchedule")
	public ImportedTimeSchedule timeSchedule;
	
	@XmlElement(name="cargoDetails")
	public ImportedCargoDetails cargoDetails;
	
	@XmlElement(name="transportMode")
	public ImportedTransportMode transportMode;
	
	@XmlElement(name="clientReferenceNumber")
	public String clientReferenceNumber;
	
	@XmlElement(name="branch")
	public String branch;
	
	@XmlElement(name="erpNumber")
	public String erpNumber;
	
	@XmlElement(name="allowUpdate")
	public boolean allowUpdate=false;
	
	@XmlElement(name="shipFrom")
	public ImportedLocation shipFrom;
	
	@XmlElement(name="shipTo")
	public ImportedLocation shipTo;
	
	@XmlElement(name="rejectDraft")
	public boolean rejectDraft=false;
	
	@XmlElement(name="autoProcessMode")
	public int autoProcessMode=1;
	
	@XmlElement(name="customFields")
	public ImportedCustomFields customFields;
	
	@XmlElementWrapper(name="orderLines")
	@XmlElement(name="orderLine")
	public ArrayList<ImportedOrderLine> orderLines;
	
	public OrderOtms(RData rdata){
		if(rdata==null) return ;
		
		//this.setSequence(rdata.getInt("sequence"));
		//this.setClientCode(rdata.getString("clientCode"));
		this.timeSchedule =new ImportedTimeSchedule(rdata);
		this.clientReferenceNumber=rdata.getString("clientReferenceNumber");
		this.branch=rdata.getString("branch");
		if(rdata.containsKey("autoProcessMode"))
			this.autoProcessMode=rdata.getInt("autoProcessMode");
		this.erpNumber=rdata.getString("erpNumber");
		this.shipFrom =new ImportedLocation(rdata,"shipFrom");
		this.shipTo=new ImportedLocation(rdata,"shipTo");
		this.customFields =new ImportedCustomFields(rdata);
		this.orderLines =ImportedOrderLine.getOrderListByData(rdata);
		this.cargoDetails = new ImportedCargoDetails(rdata);
		this.transportMode = new ImportedTransportMode(rdata);
		Double weight=0.0;
		for (ImportedOrderLine importedOrderLine : orderLines) {
			weight+=importedOrderLine.weight;
		}
		if(weight>20)
			customFields.customText27="重货";
		
	}
	
	
	
}
