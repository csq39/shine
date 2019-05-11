package io.rain.modules.sys.main;

import java.text.ParseException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.rain.core.collection.RData;
import io.rain.web.support.mvc.controller.BaseController;
import io.rain.web.support.utils.user.UserUtils;

/**
 * 首页
 * @author 曹圣泉
 * @date 2018-02-22
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/main")
public class MainController extends BaseController {

	
	@Autowired
	private MainService mainService;
	
	/**
	 *   进入共同代码管理页面
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value ="")
	public String redirect(Model model) {
		rdata.put("orgId", UserUtils.getUser().getCompanyId());
		if(mainService.hasOrgMaintain(rdata))
			return "../core/main/index";
		else
			return "redirect:" + adminPath + "/profile/baseInfo";
	}
	/**
	 *   进入共同代码管理页面
	 * @return
	 */
	@RequestMapping(value ="main")
	public String main(Model model) {
		/*if(KskConstant.IS_HOSPITAL.equals(UserUtils.getUser().getUserData("orgType"))) {
			
		}
		
		if(KskConstant.IS_SUPPLIER.equals(UserUtils.getUser().getUserData("orgType"))) {
			
		}*/
		
		return "sys/main/main";
	}
	
	/**
	 * 饼图数据
	 */
	@RequestMapping(value="getPie")
	@ResponseBody
	public ArrayList<RData> getPie(){
		return mainService.getPie(rdata);
	}
	
	/**
	 * 柱形图数据
	 * @throws ParseException 
	 */
	@RequestMapping(value="getLine")
	@ResponseBody
	public ArrayList<RData> getLine() throws ParseException{
		return mainService.getLine(rdata);
	}
	
		

}
