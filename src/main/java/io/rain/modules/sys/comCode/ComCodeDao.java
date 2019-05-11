package io.rain.modules.sys.comCode;

import java.util.ArrayList;

import io.rain.core.collection.RData;
import io.rain.web.bean.Page;
import io.rain.web.persistence.annotation.MyBatisDao;

/**
 * 共同代码DAO接口
 * @author likexin
 * @version 2014-04-12
 */
@MyBatisDao
public interface ComCodeDao{

	public ArrayList<RData> querycomCodeList(Page<RData> page);

	public void addComCodeDo(RData rdata);

	public RData getComCodeList(RData rdata);
	
	public void updateComCodeDo(RData rdata);

	public ArrayList<RData> getType();

	public ArrayList<RData> queryCode(RData rdata);
	
}
