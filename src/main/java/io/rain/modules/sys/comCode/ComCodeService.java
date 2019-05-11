package io.rain.modules.sys.comCode;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import io.rain.core.collection.RData;
import io.rain.web.bean.Page;
import io.rain.web.service.BaseService;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
@Service
@Transactional(readOnly = true)
public class ComCodeService extends BaseService {
	
	@Autowired
	private ComCodeDao comCodeDao;
	

	public ArrayList<RData> getType(){
		return comCodeDao.getType();
	}
	
	public void querycomCodeList(Page<RData> page) {
		ArrayList<RData> rList=comCodeDao.querycomCodeList(page);
		page.setData(rList);
	}
	
	public RData queryCode(RData rdata) {
		ArrayList<RData> list = comCodeDao.queryCode(rdata);
		if(list.size()!= 0){
			rdata.set("message", "error");
		}else{
			rdata.set("message", "ok");
		}
		return rdata;
	}
	
	public void addComCodeDo(RData rdata) {
		comCodeDao.addComCodeDo(rdata);
	}

	public RData getComCodeList(RData rdata) {
		return comCodeDao.getComCodeList(rdata);
	}

	public void updateComCodeDo(RData rdata){
		comCodeDao.updateComCodeDo(rdata);
	}

}
