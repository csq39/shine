package io.rain.modules.sys.comCode;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.rain.core.collection.RData;
import io.rain.web.bean.Page;
import io.rain.web.support.mvc.controller.BaseController;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/comCode")
public class ComCodeController extends BaseController {

	@Autowired
	private ComCodeService comCodeService;
	
	/**
	 *   进入共同代码管理页面
	 * @return
	 */
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		ArrayList<RData> list=comCodeService.getType();
		model.addAttribute("types", list);
		return "sys/comCode/comCodeList";
	}
	
	/**
	 * 获取所有共同代码
	 * @return
	 */
	@RequestMapping(value ="querycomCodeList")
	@ResponseBody
	public Page<RData> querycomCodeList(Model model){
		comCodeService.querycomCodeList(page);
		return  page;
	}
	
	/**
	 * 进入共同代码新增页面
	 * @return
	 */
	@RequestMapping(value = "add")
	public String add(){
		return "sys/comCode/comCodeAdd";
	}
	
	/**
	 * 共同代码查重
	 */
	@RequestMapping(value="queryCode")
	@ResponseBody
	public RData queryCode(){
		return comCodeService.queryCode(rdata);
		
	}
	
	/**
	 * 新增共同代码
	 */
	@RequestMapping(value ="addComCodeDo")
	@ResponseBody
	public void addComCodeDo() {
		comCodeService.addComCodeDo(rdata);
	}
	
	/**
	 * 进入共同代码修改页面
	 * @return
	 */
	@RequestMapping(value = "update")
	public String update(Model model){
		model.addAttribute("comCode", comCodeService.getComCodeList(rdata));
		return "sys/comCode/comCodeUpdate";
	}

	/**
	 * 更新共同代码
	 * @return
	 */
	@RequestMapping(value="updateComCodeDo")
	@ResponseBody
	public void updateComCodeDo(){
		comCodeService.updateComCodeDo(rdata);
	}
	
	
	
		

}
