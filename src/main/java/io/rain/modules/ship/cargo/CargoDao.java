package io.rain.modules.ship.cargo;

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
public interface CargoDao{

	public ArrayList<RData> queryCargoList(Page<RData> page);
	
	public RData queryCargoMasterForOtms(RData rdata);
	
	public ArrayList<RData> queryCargoDetailForOtms(RData rdata);
	
	public void setCargoMasterCustid(RData rdata);
	
	public void updateCargoByWs(RData rdata);

}
