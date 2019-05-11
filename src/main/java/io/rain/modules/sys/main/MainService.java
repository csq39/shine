package io.rain.modules.sys.main;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import io.rain.core.collection.RData;
import io.rain.web.service.BaseService;

/**
 * 首页
 * @author caoshengquan
 * @version 2018-02-22
 */
@Service
@Transactional(readOnly = true)
public class MainService extends BaseService {
	
	@Autowired
	private MainDao mainDao;
	

	public boolean hasOrgMaintain(RData data){
		RData OrgMaintainFlag =  mainDao.hasOrgMaintain(data);
		return OrgMaintainFlag!=null;
	}

	public ArrayList<RData> getPie(RData rdata) {
		if("0".equals(rdata.getString("orgType"))){//企业
			return mainDao.getPieSupplier(rdata);
		}else {//医院
			return mainDao.getPieHosp(rdata);
		}
	}

	public ArrayList<RData> getLine(RData rdata) throws ParseException {
		//获取当前年份
		Date data = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy");
		String createData = df.format(data);
		Date d1 = new SimpleDateFormat("yyyy-MM").parse(createData+"-01");//定义起始日期
		Date d2 = new SimpleDateFormat("yyyy-MM").parse(createData+"-13");//定义结束日期
		Calendar dd = Calendar.getInstance();//定义日期实例
		dd.setTime(d1);//设置日期起始时间
		ArrayList<RData> list = new ArrayList<RData>();
		if("0".equals(rdata.getString("orgType"))){//企业
			while(dd.getTime().before(d2)){//判断是否到结束日期
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
				String str = sdf.format(dd.getTime());
				rdata.set("data", str);
				list.add(mainDao.getLineSupplier(rdata));
				dd.add(Calendar.MONTH, 1);//进行当前日期月份加1
			}
		}else {//医院
			while(dd.getTime().before(d2)){//判断是否到结束日期
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
				String str = sdf.format(dd.getTime());
				rdata.set("data", str);
				list.add(mainDao.getLineHosp(rdata));
				dd.add(Calendar.MONTH, 1);//进行当前日期月份加1
			}
		}
		
		return list;
	}
	

}
