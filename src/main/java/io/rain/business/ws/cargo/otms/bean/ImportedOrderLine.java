package io.rain.business.ws.cargo.otms.bean;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlElement;

import io.rain.core.collection.RData;

/**
 * @date 2016-04-11
 * @version 1.0.0
 */
public class ImportedOrderLine{
	
	@XmlElement(name="cargoDescription")
	public ImportedCargoDescription cargoDescription;
	
	@XmlElement(name="quantity")
	public int quantity;
	
	@XmlElement(name="weight")
	public Double weight=0.0;
	
	@XmlElement(name="volume")
	public Double volume=0.0;
	
	@XmlElement(name="customFields")
	public ImportedOrderLineCustomFields customFields;
	
	public  ImportedOrderLine(RData rdata){
		if(rdata.get("quantity")!=null){
			this.quantity = (int)rdata.getDouble("quantity");
			
		}
		
		if(rdata.get("weight")!=null)
			this.weight = rdata.getDouble("weight");
		if(rdata.get("volume")!=null)
			this.volume = rdata.getDouble("volume");
		this.cargoDescription =new ImportedCargoDescription(rdata);
		this.customFields =new ImportedOrderLineCustomFields(rdata);
	}
	
	public static ArrayList<ImportedOrderLine> getOrderListByData(RData rdata){
		ArrayList<ImportedOrderLine> orderLines= new ArrayList<ImportedOrderLine>();
		ArrayList<RData> orderLinesData= (ArrayList<RData>)rdata.get("orderLines");
		
		for (RData item : orderLinesData) {
			orderLines.add(new ImportedOrderLine(item));
		}
		
		return orderLines;
		
	}
	
	private boolean isInt(Double val) {
		int i = String.valueOf(val).indexOf(".");
		if(val%Integer.parseInt(String.valueOf(val).substring(0, i))==0){
			return true;
		}
		return false;
		
	}
	
}
