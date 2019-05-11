package io.rain.modules.ship.delivery;

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
@RequestMapping(value = "${adminPath}/ship/delivery")
public class DeliveryController extends BaseController {

	@Autowired
	private DeliveryService deliveryService;
	
	/**
	 * 进入共同代码管理页面
	 * @return
	 */
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		return "ship/delivery/deliveryList";
	}
	
	/**
	 * 获取所有共同代码
	 * @return
	 */
	@RequestMapping(value ="queryDeliveryList")
	@ResponseBody
	public Page<RData> queryDeliveryList(Model model){
		deliveryService.queryDeliveryList(page);
		return  page;
	}
	
	/**
	 * 获取所有共同代码
	 * @return
	 */
	@RequestMapping(value ="sendDelivery")
	@ResponseBody
	public String sendDelivery(Model model){
		deliveryService.sendDelivery(rdata);
		
		return  "";
	}
	
	/**
	 * 获取所有共同代码
	 * @return
	 */
	@RequestMapping(value ="sendDeliveryList")
	@ResponseBody
	public String sendDeliveryList(Model model){
		String[] billcode=rdata.getString("billcode").split(",");
		String[] type=rdata.getString("type").split(",");
		String[] carrier=rdata.getString("carrier").split(",");
		for (int i = 0; i < carrier.length; i++) {
			RData delivery = new RData();
			delivery.set("billcode", billcode[i]);
			delivery.set("type", type[i]);
			delivery.set("carrier", carrier[i]);
			deliveryService.sendDelivery(delivery);
		}
		return  "";
	}
	
}
