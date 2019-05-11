package io.rain.business.task.cargo;

import java.util.ArrayList;

import io.rain.core.collection.RData;
import io.rain.web.persistence.annotation.MyBatisDao;


/**
 * 生产企业资质同步
 * @author GuoJianmin
 * @date 2016年8月15日
 * @version 1.0.0
 */
@MyBatisDao
public interface CargoTaskDao {
    
	   public ArrayList<RData> queryKunchuanCargoMaster();
	   public ArrayList<RData> queryKunchuanCargoDetail();
	   public RData queryKunchuanDeliveryDetail(RData data);
	   public void updateKunchuanCargoDetail(RData rdata);
	   
	   public ArrayList<RData> queryHuiKangCargoMaster();
	   public ArrayList<RData> queryHuiKangCargoDetail();
	   public void updateHuiKangCargoMaster(RData rdata);
	   public void updateHuiKangCargoDetail(RData rdata);
	   
	   public ArrayList<RData> queryShenWeiCargoMaster();
	   public ArrayList<RData> queryShenWeiCargoDetail();
	   public void updateShenWeiCargoMaster(RData rdata);
	   public void updateShenWeiCargoDetail(RData rdata);
	   
	   
	   public void addCargoMaster(RData rdata);
	   public void addCargoMasterHK(RData rdata);
	   public void addCargoDetail(RData rdata);
}

