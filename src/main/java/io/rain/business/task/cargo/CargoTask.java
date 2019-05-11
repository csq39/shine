package io.rain.business.task.cargo;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 随货同行单同步
 * @author ZYN
 * @date 2018年5月2日
 * @version 1.0.0
 */
@Component
public class CargoTask {

	@Autowired
	private CargoTaskService cargoTaskService;

	public void syncKunchuanCargoData(){
		cargoTaskService.syncKunchuanCargo();
	}
	
	public void syncShenWeiCargoData(){
		cargoTaskService.syncShenWeiCargo();
	}
	
	public void syncHuiKanCargoData(){
		cargoTaskService.syncHuiKanCargo();
	}
}

