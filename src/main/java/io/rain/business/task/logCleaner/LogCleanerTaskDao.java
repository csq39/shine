package io.rain.business.task.logCleaner;

import io.rain.web.persistence.annotation.MyBatisDao;


/**
 * 生产企业资质同步
 * @author GuoJianmin
 * @date 2016年8月15日
 * @version 1.0.0
 */
@MyBatisDao
public interface LogCleanerTaskDao {
    
	   public void LogClean();
}

