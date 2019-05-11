package io.rain.components.popup;

import java.util.ArrayList;

import io.rain.core.collection.RData;
import io.rain.web.persistence.annotation.MyBatisDao;

/**
 * PopupDao
 * @author caoshengquan
 * @version 2014-05-16
 */
@MyBatisDao
public interface PopupDao  {

	public ArrayList<RData> queryMaterialCategoryPopup(RData rdata);
	
	
}
