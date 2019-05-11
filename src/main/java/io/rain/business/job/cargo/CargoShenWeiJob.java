package io.rain.business.job.cargo;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import io.rain.business.task.cargo.CargoTask;



/**
 * 产品和生产企业资质效期定时任务 
 * @author lzw
 * @time   2018-7-16
 */
@Service
@Lazy(false)
public class CargoShenWeiJob {

	@Autowired
	private CargoTask cargoTask;
	
	@Scheduled(cron="${shenweiCargoJob.corn}")
	public void syncShenWeiCargoData(){
		cargoTask.syncShenWeiCargoData();
	}
}
