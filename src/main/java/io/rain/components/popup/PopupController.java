package io.rain.components.popup;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.rain.core.collection.RData;
import io.rain.web.support.mvc.controller.BaseController;

/**
 * 菜单管理
 * @author 杨刘斌
 * @date 2016-04-14
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/popup")
public class PopupController extends BaseController {
	
	@Autowired
	private PopupDao popupDao;

	@RequestMapping(value = "checkbox")
	public String po() {
		return "../core/popup/checkboxTree";
	}
	
	@RequestMapping(value = "radio")
	public String pop() {
		return "../core/popup/radioTree";
	}
	
	/**
	 * 获取所有菜单，用于树形显示
	 * @return
	 */
	@RequestMapping(value ="materialCategoryPopup")
	@ResponseBody
	public List<RData> materialCategoryTreePopup(){
		return popupDao.queryMaterialCategoryPopup(rdata);
	}

}
