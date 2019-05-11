package io.rain.modules.ship.cargo;

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
@RequestMapping(value = "${adminPath}/ship/cargo")
public class CargoController extends BaseController {

	@Autowired
	private CargoService cargoService;
	
	/**
	 * 进入共同代码管理页面
	 * @return
	 */
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		return "ship/cargo/cargoList";
	}
	
	/**
	 * 获取所有共同代码
	 * @return
	 */
	@RequestMapping(value ="queryCargoList")
	@ResponseBody
	public Page<RData> queryCargoList(Model model){
		cargoService.queryCargoList(page);
		return  page;
	}
	
	/**
	 * 获取所有共同代码
	 * @return
	 */
	@RequestMapping(value ="sendOtmsCargo")
	@ResponseBody
	public String sendOtmsCargo(Model model){
		cargoService.sendCargo(rdata);
		return  "";
	}
	
	/**
	 * 获取所有共同代码
	 * @return
	 */
	@RequestMapping(value ="sendOtmsCargoList")
	@ResponseBody
	public String sendOtmsCargoList(Model model){
		String[] billcode=rdata.getString("billcode").split(",");
		String[] carrier=rdata.getString("carrier").split(",");
		for (int i = 0; i < carrier.length; i++) {
			RData delivery = new RData();
			delivery.set("billcode", billcode[i]);
			delivery.set("carrier", carrier[i]);
			cargoService.sendCargo(delivery);
		}
		return  "";
	}
	
}
