package io.rain.business.ws.cargo.ec.bean;

import java.util.ArrayList;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class OrderEC{
	
	public String carrier="SF";
	public boolean autoConfirm=false;
	public ArrayList<OrderECItem> orders;
	
	public void adOrder(OrderECItem order ) {
		if(null==orders) orders = new ArrayList<OrderECItem>();
		orders.add(order);
	}
}