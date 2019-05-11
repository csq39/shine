package io.rain.modules.ship.delivery;

import java.util.ArrayList;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import io.rain.business.ws.cargo.ec.bean.OrderEC;
import io.rain.business.ws.cargo.ec.bean.OrderECItem;
import io.rain.business.ws.cargo.ec.bean.response.ECResponse;
import io.rain.business.ws.cargo.ec.bean.response.ECResponseCode;
import io.rain.business.ws.cargo.otms.bean.OrderImportRequest;
import io.rain.business.ws.cargo.otms.bean.OrderOtms;
import io.rain.business.ws.cargo.otms.bean.response.OTMSResponseCode;
import io.rain.business.ws.cargo.otms.bean.response.OrderImportResponse;
import io.rain.business.ws.cargo.otms.bean.response.OrderOtmsResponse;
import io.rain.common.mapper.JaxbMapper;
import io.rain.common.mapper.JsonMapper;
import io.rain.components.messageService.rest.RestRaycomTemple;
import io.rain.core.collection.RData;
import io.rain.utils.string.StringUtils;
import io.rain.web.bean.Page;
import io.rain.web.service.BaseService;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
@Service
public class DeliveryService extends BaseService {
	
	@Autowired
	private DeliveryDao deliveryDao;
	
	@Autowired
	private RestRaycomTemple restRaycom;
	
	@Value("${otms.url}")
	private String otmsUrl;
	
	@Value("${otms.user}")
	private String otmsUser;
	@Value("${otms.password}")
	private String otmspwd;
	
	@Value("${ec.url}")
	private String ecUrl;
	@Value("${ec.user}")
	private String ecUser;
	@Value("${ec.password}")
	private String ecpwd;
	@Value("${ec.customerCode}")
	private String ecCustomerCode;
	
	public void queryDeliveryList(Page<RData> page) {
		page.setData(deliveryDao.queryDeliveryList(page));
	}
	
	
	public RData queryDeliveryMasterForSend(RData rdata){
		deliveryDao.setDeliveryMasterCustid(rdata);//设置承运商以及月结账号
		RData delivery = deliveryDao.queryDeliveryMasterForSend(rdata);
		if(delivery!=null){
			delivery.set("orderLines", deliveryDao.queryDeliveryDetailForSend(rdata));
		}
		return delivery;
	}
	/**、
	 * type:1 按照物流（otms）发送，对应的是OTMS type：2：按照快递（EC）发送，对应的是SF.EMS
	 * @param rdata
	 * @return
	 */
	public String sendDelivery(RData rdata){
		RData  deliverySend = queryDeliveryMasterForSend(rdata);
		 if("OTMS".equals(rdata.getString("carrier"))){
			 deliverySend.set("autoProcessMode", 1); 
		}else{
			deliverySend.set("autoProcessMode", 3); 
		    deliverySend.set("transportType", "EXPRESS"); 
		    deliverySend.setString("customText24", rdata.getString("carrier"));
		}
		 
		 if("2".equals(rdata.getString("type"))&&StringUtils.isEmpty(deliverySend.getString("custid"))){
			 	deliverySend.set("custid", "SW");
		  }
		 System.out.println(deliverySend);
		sendOtmsDelivery(deliverySend);
		return "";
	}
	
	public String sendDeliveryJob(){
		ArrayList<RData>  deliverySend = deliveryDao.queryDeliveryListForSend();
		for (RData rdata : deliverySend) {
			rdata.set("type", "1");
			rdata.set("carrier", "OTMS");
			sendDelivery(rdata);
		}
		return "";
	}
	
	public String sendOtmsDelivery(RData rdata){
		OrderOtms order = new OrderOtms(rdata);
		
		OrderImportRequest orderImport = new OrderImportRequest();
		orderImport.adOrderOtms(order);
		orderImport.login=otmsUser;
		orderImport.password=otmspwd;
		order.sequence=1;

		String obj = restRaycom.putForXmlObjectWithLog(otmsUrl, orderImport, "随货同行单otms");
		
		OrderImportResponse res = JaxbMapper.fromXml(obj, OrderImportResponse.class);
		
		for (OrderOtmsResponse response : res.order) {
			RData orderRes = new RData();
			orderRes.set("billcode", order.erpNumber);
			if("NOT IMPORTED".equals(response.importStatus))
				orderRes.set("outputStatus", "3");//报错
			else
				orderRes.set("outputStatus", "2");
			for (OTMSResponseCode responseCode : response.responseCodes) {
				orderRes.set("outputMsg", orderRes.get("outputMsg")+","+responseCode.code);//报错
			}
			
			deliveryDao.updateDeliveryByWs(orderRes);
		}
		return "";
	}
	
	
	public String sendECDelivery(RData rdata){
		OrderECItem order = new OrderECItem(rdata);
		order.seq=1;
		
		OrderEC orderEC = new OrderEC();
		orderEC.adOrder(order);
		
		if(!StringUtils.isEmpty(rdata.getString("carrier"))){
			orderEC.carrier=rdata.getString("carrier");
		}
	   
		String base64ClientCredentials = new String(Base64.encodeBase64((ecUser + ":" + ecpwd).getBytes()));
	    ecUrl = ecUrl.replaceFirst("customerCode", ecCustomerCode);
		String obj = restRaycom.postForAuthJsonObjectWithLog(ecUrl, orderEC,"Basic " + base64ClientCredentials,String.class, "随货同行单EC");
		
		ECResponse res = JsonMapper.getInstance().fromJson(obj,ECResponse.class);
		if("EC0012".equals(res.responseCode)){
			RData orderRes = new RData();
			orderRes.set("outputStatus", "3");
			orderRes.set("outputMsg", "EC0012");//报错
			orderRes.set("billcode", order.orderNo);
			deliveryDao.updateDeliveryByWs(orderRes);
			return "";
		}
		
		updateDeliveryEcByWs(res);
		return "";
	}
	
	public  void updateDeliveryEcByWs(ECResponse res){
			
		RData mdata = new RData();
		for (ECResponseCode response : res.orders) {
			RData orderRes = (RData)mdata.get(response.orderNo);
			if(orderRes==null){
				orderRes = new RData();
				mdata.put(response.orderNo, orderRes);
				orderRes.set("billcode", response.orderNo);
			}
			
			if("SUCCESS".equals(response.responseCode)){
				orderRes.set("outputStatus", "2");
				orderRes.set("seq", response.seq);
				orderRes.set("transportNo", response.transportNo);
			}else{
				orderRes.set("outputStatus", "3");
				orderRes.set("outputMsg", orderRes.get("outputMsg")+","+response.responseCode);//报错
			} 
		}
		
	  for(Object key:mdata.keySet()){
         deliveryDao.updateDeliveryByWs((RData)mdata.get(key));
      }
			
	}

}
