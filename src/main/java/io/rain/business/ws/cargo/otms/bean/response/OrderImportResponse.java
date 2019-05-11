package io.rain.business.ws.cargo.otms.bean.response;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
@XmlRootElement(name="orderImportResponse")
public class OrderImportResponse{
	
	@XmlAttribute(name="version")
	public String version="0.1";
	
	@XmlElement(name="processedOrders")
	public String processedOrders;
	
	@XmlElement(name="responseCode")
	public String responseCode;
	
	@XmlElementWrapper(name="orders")
	@XmlElement(name="order")
	public ArrayList<OrderOtmsResponse>  order;
	

}
