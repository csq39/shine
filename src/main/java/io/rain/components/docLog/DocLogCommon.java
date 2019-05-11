package io.rain.components.docLog;

import java.util.ArrayList;

import io.rain.core.collection.RData;
import io.rain.web.persistence.annotation.MyBatisDao;

/** 
 * @author zhx  
 * @version 1.0   
 * 创建时间：2018年7月18日 下午2:30:14   
 * 类说明：  
 */
@MyBatisDao
public interface DocLogCommon {

	//query 操作记录
	ArrayList<RData> queryDocLog(RData rdata);
}
