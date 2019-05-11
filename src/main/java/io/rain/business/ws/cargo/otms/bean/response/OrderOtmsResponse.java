package io.rain.business.ws.cargo.otms.bean.response;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;

/**
 * 共同代码管理
 * @author 李可新
 * @date 2016-04-11
 * @version 1.0.0
 */
public class OrderOtmsResponse{
	
	@XmlAttribute(name="sequence")
	public int sequence;
	
	@XmlElement(name="clientReferenceNumber")
	public String clientReferenceNumber;
	
	@XmlElement(name="importStatus")
	public String importStatus;
	
	@XmlElement(name="orderNumber")
	public String orderNumber;
	
	@XmlElement(name="erpNumber")
	public String erpNumber;
	
	@XmlElementWrapper(name="responseCodes")
	@XmlElement(name="responseCode")
	public ArrayList<OTMSResponseCode> responseCodes;

}
