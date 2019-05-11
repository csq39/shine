package io.rain.modules.ship.delivery;

import java.util.ArrayList;

import io.rain.core.collection.RData;
import io.rain.web.bean.Page;
import io.rain.web.persistence.annotation.MyBatisDao;

/**
 * 共同代码DAO接口
 * @author likexin
 * @version 2014-04-12
 */
@MyBatisDao
public interface DeliveryDao{

	public ArrayList<RData> queryDeliveryList(Page<RData> page);
	
	public RData queryDeliveryMasterForSend(RData rdata);
	
	public ArrayList<RData> queryDeliveryDetailForSend(RData rdata);
	
	public ArrayList<RData> queryDeliveryListForSend();
	
	public void setDeliveryMasterCustid(RData rdata);
	
	public void updateDeliveryByWs(RData rdata);

}
