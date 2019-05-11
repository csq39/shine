package io.rain.modules.sys.user;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import io.rain.core.collection.RData;
import io.rain.utils.string.StringUtils;
import io.rain.web.bean.Page;
import io.rain.web.service.BaseService;
import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

@Service
@Transactional(readOnly = true)
public class UserService extends BaseService {
	
	@Autowired
	private UserDao userdao;
	
	/**
	 * 查询用户列表
	 * @param page
	 */
	public void getAllUser(Page<RData> page){
		page.setData(userdao.getAllUser(page));
	}
	
	/**
	 * 查询用户列表，模态窗口用
	 * @param page
	 */
	public void getAllUserForPopup(Page<RData> page){
		page.setData(userdao.getAllUserForPopup(page));
	}
	
	public String createUserDo(RData rData){
		//校验用户名重复，则返回用户名重复，否则返回true;
		if(!isLoginNameExist(rData)){
			String userId  = userdao.queryUserId();
			rData.set("userId", userId);
			userdao.createUserDo(rData);
			//创建用户角色关系
			userdao.deleteUserRole(rData);
			createUserRole(rData);
			//创建用户岗位关系
			userdao.deleteUserPosition(rData);
			createUserPosition(rData);
		}else{
			return "该登录名已存在 ！";
		}
		return "true";
	}
	
	/**
	 * 添加用户角色
	 */
	public void createUserRole(RData rdata){
		String roleString = rdata.getString("roleId").toString();
		if(!StringUtils.isEmpty(roleString)){
			String roles[] =  roleString.split(",");
			for (String role : roles) {
				rdata.set("roleId",role);
				userdao.createUserRole(rdata);
			}
		}
	}
	
	/**
	 * 添加用户岗位
	 */
	public void createUserPosition(RData rdata){
		String positons= rdata.getString("positonId").toString();
		if(!StringUtils.isEmpty(positons)){
			String positon[] =  positons.split(",");
			for (String positonId : positon) {
				rdata.set("positonId",positonId);
				userdao.createUserPosition(rdata);
			}
		}
	}
	
	public boolean isLoginNameExist(RData rdata){
		return  userdao.getUserName(rdata)!=null;
	}
	
	public void updateUserDo(RData rData){
		userdao.updateUser(rData);
		//创建用户角色
		userdao.deleteUserRole(rData);
		createUserRole(rData);
		//创建用户岗位
		userdao.deleteUserPosition(rData);
		createUserPosition(rData);
	}
	
	public ArrayList<RData> getOfficeList(){
		return userdao.getOfficeList();
	}
	
	public ArrayList<RData> getUserRole(RData rdata){
		return userdao.getUserRole(rdata);
	}
	public ArrayList<RData> getRoleList(){
		return userdao.getRoleList();
	}
	
	public ArrayList<RData> getExceptRoleList(RData rdata){
		return userdao.getExceptRoleList(rdata);
	}
	
	public ArrayList<RData> getUserPosition(RData rdata){
		return userdao.getUserPosition(rdata);
	}
	public ArrayList<RData> getPositionList(){
		return userdao.getPositionList();
	}
	
	public ArrayList<RData> getExceptPositionList(RData rdata){
		return userdao.getExceptPositionList(rdata);
	}
	
	public RData getUser(RData rdata){
		return userdao.getUser(rdata);
	}
	
	public RData checkLoginName(RData rdata) {
		return userdao.checkLoginName(rdata);
	}
	
	public void deleteUser(RData rData){
		userdao.deleteUser(rData);
	}
	
	public void deleteUserPosition (RData rData){
		userdao.deleteUserPosition(rData);
	}
    
	public void deleteUserRole (RData rData){
		userdao.deleteUserRole(rData);
	}
	
	public RData queryUserName(RData rdata) {
		return userdao.queryUserName(rdata);
	}

	public String saveUpdatedPwd(RData rdata) {
		rdata.set("userId", rdata.get("currentUser"));
		//更新密码
		this.savePwd(rdata);
		//更新密码后，将是否修改过密码置为Y
		userdao.updateToY(rdata);
		return "ok";
	}
	
	private void savePwd(RData rdata) {
		userdao.savePwd(rdata);
	}
	
	public void resetPwd(RData rdata) {
		//更新密码
		userdao.resetPwd(rdata);
		//重置密码后，将是否修改过密码置为N
		userdao.updateToN(rdata);
	}

	public String queryUserPwd(RData rdata) {
		return userdao.queryUserPwd(rdata);
	}

	public ArrayList<RData> querOfficeList() {
		return userdao.querOfficeList();
	}
	
	public RData queryUserLoginName(RData rdata){
		return userdao.queryUserLoginName(rdata);
	}

	public void saveUpdatedMobile(RData rdata) {
		userdao.updatedMobile(rdata);
	}

	public ArrayList<RData> getMechanismList(RData rdata) {
		return userdao.getMechanismList(rdata);
	}

	public RData queryEmailMobile(RData rdata) {
		ArrayList<RData> list = new ArrayList<RData>();
		if(rdata.getString("userId").equals("")||rdata.getString("userId") == null){
			list = userdao.queryEmailMobile(rdata);
		}else{
			list = userdao.queryEmailMobileUser(rdata);
		}
		if(list.size()!= 0){
			rdata.set("message", "error");
		}else{
			rdata.set("message", "ok");
		}
		return rdata;
	}

	public RData aliasCode(RData rdata){
		rdata.set("aliasCode", getPy(rdata.getString("alias")));
		return rdata;
	}

	/**
	 * 拼音缩写
	 * @param manufactureChName
	 * @return
	 */
	private String getPy(String alias) {
		if(StringUtils.isEmpty(alias))
			return "";
		String aliasCode ="";
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();      
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);      
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);      
        
        char[] nameChar = alias.toCharArray();      
        for (int i = 0; i < nameChar.length; i++) {      
            if (nameChar[i] > 128) {      
                try {   
                	String[] as = PinyinHelper.toHanyuPinyinStringArray(nameChar[i], defaultFormat);                	
                	if(as != null){
                		char s = as[0].charAt(0);
                		aliasCode += s;
                	}  
                	//aliasCode += PinyinHelper.toHanyuPinyinStringArray(nameChar[i], defaultFormat)[0].charAt(0);      
                 } catch (BadHanyuPinyinOutputFormatCombination e) {      
                     e.printStackTrace();      
                 }      
             }else{      
            	 aliasCode += nameChar[i];      
             }      
         }
		return aliasCode;
	}

	public RData queryUserType(RData rdata) {
		
		return userdao.queryUserType(rdata);
	}
}
