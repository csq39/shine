package io.rain.business.ws.cargo.otms.bean;

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
@XmlRootElement(name="orderImportRequest")
public class OrderImportRequest{
	
	@XmlAttribute(name="version")
	public String version="0.1";
	
	@XmlAttribute(name="login")
	public String login="0.1";
	
	@XmlAttribute(name="password")
	public String password="0.1";
	
	@XmlElementWrapper(name="orders")
	@XmlElement(name="order")
	public ArrayList<OrderOtms>  orders;
	
	public void adOrderOtms(OrderOtms order ) {
		if(null==orders) orders = new ArrayList<OrderOtms>();
		orders.add(order);
	}

}
