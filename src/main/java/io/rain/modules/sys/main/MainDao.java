package io.rain.modules.sys.main;

import java.util.ArrayList;

import io.rain.core.collection.RData;
import io.rain.web.persistence.annotation.MyBatisDao;

/**
 * 首页
 * @author caoshengquan
 * @version 2018-02-22
 */
@MyBatisDao
public interface MainDao{

	public RData hasOrgMaintain(RData data);
	public RData RetrieveOrgInfo(RData data);
	public ArrayList<RData> getPieSupplier(RData rdata);
	public ArrayList<RData> getPieHosp(RData rdata);
	public RData getLineSupplier(RData rdata);
	public RData getLineHosp(RData rdata);

}
