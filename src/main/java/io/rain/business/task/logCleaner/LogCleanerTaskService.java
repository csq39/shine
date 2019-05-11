package io.rain.business.task.logCleaner;

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
public class LogCleanerTaskService extends BaseService {

	@Autowired
	private LogCleanerTaskDao logCleanerTaskDao;
	
	public  void LogClean(){
		logCleanerTaskDao.LogClean(); 
	}
	
}

