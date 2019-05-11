package io.rain.business.task.cargo;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import io.rain.common.config.Global;
import io.rain.core.collection.RData;
import io.rain.web.service.BaseService;



/**
 * 汇总单接收处理service
 * @author GuoJianmin
 * @date 2016年8月16日
 * @version 1.0.0
 */
@Service
public class CargoTaskService extends BaseService {

	@Autowired
	private CargoTaskDao cargoTaskDao;
	
	public  RData queryKunchuanCargo(){
		Global.setDatabaseTmp("kunchuan");
		ArrayList<RData> cargoMaster = cargoTaskDao.queryKunchuanCargoMaster();      
		ArrayList<RData> cargoDetail = cargoTaskDao.queryKunchuanCargoDetail();    
		
		//设置同步标志位、
		for (RData master : cargoMaster) {
			master.set("pkId", "hk"+master.getString("id"));
			master.set("custid", "KC");
		}
		//设置同步标志位
		for (RData detail : cargoDetail) {
			cargoTaskDao.updateKunchuanCargoDetail(detail);
		}
		Global.clearDatabaseTmp();
		//设置同步标志位
		for (RData detail : cargoDetail) {
			RData delivery = cargoTaskDao.queryKunchuanDeliveryDetail(detail);
			if(delivery!=null&&!delivery.isEmpty())
				detail.putAll(delivery);
		}
		
		RData cargo = new RData();
		cargo.set("master", cargoMaster);
		cargo.set("detail", cargoDetail);
		return cargo;
	}
	
	//DynamicDataSourceAnnotation(dataSource ="tms")
	public  RData queryHuiKangCargo(){
		Global.setDatabaseTmp("tms");
		ArrayList<RData> cargoMaster = cargoTaskDao.queryHuiKangCargoMaster();      
		ArrayList<RData> cargoDetail = cargoTaskDao.queryHuiKangCargoDetail();    
		
		//设置同步标志位、
		for (RData master : cargoMaster) {
			cargoTaskDao.updateHuiKangCargoMaster(master);
			master.set("pkId", "hk"+master.getString("id"));
			master.set("custid", "HK");
		}
		
		//设置同步标志位
		for (RData detail : cargoDetail) {
			cargoTaskDao.updateHuiKangCargoDetail(detail);
			detail.set("pkId", "hk"+detail.getString("id"));
		}
		RData cargo = new RData();
		cargo.set("master", cargoMaster);
		cargo.set("detail", cargoDetail);
		Global.clearDatabaseTmp();
		return cargo;
	}
	
	//DynamicDataSourceAnnotation(dataSource ="tms")
	public  RData queryShenWeiCargo(){
		Global.setDatabaseTmp("tms");
		ArrayList<RData> cargoMaster = cargoTaskDao.queryShenWeiCargoMaster();      
		ArrayList<RData> cargoDetail = cargoTaskDao.queryShenWeiCargoDetail();    
		
		//设置同步标志位、
		for (RData master : cargoMaster) {
			cargoTaskDao.updateShenWeiCargoMaster(master);
			master.set("pkId", "sw"+master.getString("id"));
			master.set("custid", "SW");
		}
		
		//设置同步标志位
		for (RData detail : cargoDetail) {
			cargoTaskDao.updateShenWeiCargoDetail(detail);
			detail.set("pkId", "sw"+detail.getString("id"));
		}
		
		RData cargo = new RData();
		cargo.set("master", cargoMaster);
		cargo.set("detail", cargoDetail);
		Global.clearDatabaseTmp();
		return cargo;
	}
	
	public  void updateOTMSCargo(RData rdata){
		ArrayList<RData> cargoMaster = (ArrayList<RData>)rdata.get("master");      
		ArrayList<RData> cargoDetail = (ArrayList<RData>)rdata.get("detail");   
		
		for (RData master : cargoMaster) {
			cargoTaskDao.addCargoMaster(master);
		}
		
		for (RData detail : cargoDetail) {
			cargoTaskDao.addCargoDetail(detail);
		}
		
		
	}
	
	public  void updateOTMSCargo(RData rdata,String source){
		ArrayList<RData> cargoMaster = (ArrayList<RData>)rdata.get("master");      
		ArrayList<RData> cargoDetail = (ArrayList<RData>)rdata.get("detail");   
		
		for (RData master : cargoMaster) {
			if("HK".equals(source)){
				cargoTaskDao.addCargoMasterHK(master);
			}
		}
		
		for (RData detail : cargoDetail) {
			cargoTaskDao.addCargoDetail(detail);
		}
		
		
	}
	
	public  void syncKunchuanCargo(){
		RData kunchuan = queryKunchuanCargo();
		updateOTMSCargo(kunchuan);
		
	}
	public  void syncShenWeiCargo(){
		RData shenwei = queryShenWeiCargo();
		updateOTMSCargo(shenwei);
		
	}
	public  void syncHuiKanCargo(){
		RData huikang = queryHuiKangCargo();
		updateOTMSCargo(huikang,"HK");
		
	}
}

