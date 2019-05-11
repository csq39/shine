package io.rain.business.job.logCleaner;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import io.rain.business.task.logCleaner.LogCleanerTask;



/**
 * 产品和生产企业资质效期定时任务 
 * @author lzw
 * @time   2018-7-16
 */
@Service
@Lazy(false)
public class LogCleanerJob {

	@Autowired
	private LogCleanerTask logCleanerTask;
	
	@Scheduled(cron="${logCleanerJob.corn}")
	public void LogClean(){
		logCleanerTask.LogClean();
	}
}
