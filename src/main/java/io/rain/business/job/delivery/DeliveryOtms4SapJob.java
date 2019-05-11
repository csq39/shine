package io.rain.business.job.delivery;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import io.rain.modules.ship.delivery.DeliveryService;



/**
 * 产品和生产企业资质效期定时任务 
 * @author lzw
 * @time   2018-7-16
 */
@Service
@Lazy(false)
public class DeliveryOtms4SapJob {

	@Autowired
	private DeliveryService deliveryService;
	
	@Scheduled(cron="${sendOtms4SapJob.corn}")
	public void syncShenWeiCargoData(){
		deliveryService.sendDeliveryJob();
	}
}
