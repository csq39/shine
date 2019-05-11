package io.rain.modules.sys.user;

import java.util.ArrayList;

import io.rain.core.collection.RData;
import io.rain.web.bean.Page;
import io.rain.web.persistence.annotation.MyBatisDao;
/**
 * 用户Dao接口
 * @author wx
 *
 */
@MyBatisDao
public interface UserDao {
	
	public ArrayList<RData> getAllUser(Page<RData> page);
	
	public ArrayList<RData> getOfficeList();
	
	public ArrayList<RData> getAllRole();
	
	public ArrayList<RData> getRoleList();
	
	public ArrayList<RData> getExceptRoleList(RData rdata);
	
	public ArrayList<RData> getUserRole(RData rdata);
	
	public RData getUser(RData rdata);
	
	public void createUserDo(RData rdata);
	
	public void createUserRole(RData rdata);
	
	public void updateUser(RData rdata);
	
	public RData checkLoginName(RData rdata);
	
	public void deleteUser(RData rdata);
	
	public void deleteUserRole (RData rdata);
	
	public void resetPwd (RData rdata);
	
	public RData queryUserName(RData rdata);
	
	public void savePwd(RData rdata);
	
	public String queryUserPwd(RData rdata);
	
	public ArrayList<RData> getAllUserForPopup(Page<RData> page);
	
	public ArrayList<RData> querOfficeList();
	
	public RData getUserName(RData rdata);
	
	public RData queryUserLoginName(RData rdata);
	
	public void updatedMobile(RData rdata);
	
	public ArrayList<RData> getMechanismList(RData rdata);
	
	public ArrayList<RData> queryEmailMobile(RData rdata);
	
	public String queryUserId();
	
	public ArrayList<RData> queryEmailMobileUser(RData rdata);
	
	public RData queryUserForTrans(RData rdata);
	
	public void deleteUserPosition(RData rdata);
	
	public ArrayList<RData> getExceptPositionList(RData rdata);
	
	public ArrayList<RData> getUserPosition(RData rdata);
	
	public ArrayList<RData> getPositionList();
	
	public void createUserPosition(RData rdata);
	
	public void updateToY(RData rdata);
	
	public void updateToN(RData rdata);

	public RData queryUserType(RData rdata);
}
