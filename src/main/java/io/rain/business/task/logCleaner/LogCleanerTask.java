package io.rain.business.task.logCleaner;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 随货同行单同步
 * @author ZYN
 * @date 2018年5月2日
 * @version 1.0.0
 */
@Component
public class LogCleanerTask {

	@Autowired
	private LogCleanerTaskService logCleanerTaskService;

	public void LogClean(){
		logCleanerTaskService.LogClean(); 
	}
	
}

