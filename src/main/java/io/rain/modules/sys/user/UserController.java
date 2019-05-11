package io.rain.modules.sys.user;

import java.util.ArrayList;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import io.rain.core.collection.RData;
import io.rain.web.bean.Page;
import io.rain.web.support.mvc.controller.BaseController;
import io.rain.web.support.security.service.SecurityService;
import io.rain.web.support.utils.user.UserUtils;


/**
 * 用户Controller
 * @author wx 
 * @data 2016-4-14
 */
@Controller
@RequestMapping(value = "${adminPath}/user")
public class UserController extends BaseController{
	@Autowired
	private UserService userService;
	
	/**
	 * 进入初始界面
	 */
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		ArrayList<RData> roleList=userService.getRoleList();
		model.addAttribute("role", roleList);
		return "sys/user/userList";
	}
	
	/**
	 * 查询用户列表
	 * @return
	 */
	@RequestMapping(value = "queryUserList")
	@ResponseBody
	public Page<RData> queryUserList() {
		UserUtils.setResourceCodeAuthority(page.param, "userRoleType");
		userService.getAllUser(page);
		return page;
	}
	
	/**
	 * 进入新增界面
	 */
	@RequestMapping(value ="add")
	public String add(Model model) {
		ArrayList<RData> roleList=userService.getRoleList();
		ArrayList<RData> orgList =  userService.getMechanismList(rdata);
		ArrayList<RData> positionList=userService.getPositionList();
		model.addAttribute("org", orgList);
		model.addAttribute("role", roleList);
		model.addAttribute("positon", positionList);
		return "sys/user/userAdd";
	}
	
	/**
	 * 邮箱号,手机号验重
	 */
	@RequestMapping(value="queryEmailMobile")
	@ResponseBody
	public RData queryEmail(){
		return userService.queryEmailMobile(rdata);
	}
	
	
	/**
	 * 新增用户
	 */
	@RequestMapping(value ="createUserDo")
	@ResponseBody
	public String createUserDo() {
		String password = SecurityService.entryptPassword(rdata.getString("password"));
		rdata.set("password", password);
		//角色
		if(rdata.getString("roleId").equals("null")){
			rdata.setString("roleId", "");
		}
		//岗位
		if(rdata.getString("positonId").equals("null")){
			rdata.setString("positonId", "");
		}
		return userService.createUserDo(rdata);
	}
	
	/**
	 * 获取助记码
	 */
	@RequestMapping( value = "aliasCode")
	@ResponseBody
	public RData aliasCode(Model model){
		userService.aliasCode(rdata);
		return rdata;
	}
		
	/**
	 * 重置密码
	 */
	@RequestMapping(value ="resetPass")
	@ResponseBody
	public String resetPass() {
		String password = SecurityService.entryptPassword("123456");
		rdata.set("password", password);
		userService.resetPwd(rdata);
		return "重置成功！";
	}
	/**
	 * 进入修改界面
	 */
	@RequestMapping(value ="update")
	public String update(Model model) {
		//获取当前用户已经分配的角色
		ArrayList<RData> userRole = userService.getUserRole(rdata);
		String roleId="";
		if(userRole != null && userRole.size() > 0){
			for (Iterator iterator = userRole.iterator(); iterator.hasNext();) {
				RData rData = (RData) iterator.next();
				roleId+=(rData.getString("roleId")+",");
			}
			roleId = roleId.substring(0,roleId.length()-1);
		}
        //获取当前用户已经分配的岗位
		ArrayList<RData> userPosition = userService.getUserPosition(rdata);
		String positonId="";
		if(userPosition != null && userPosition.size() > 0){
			for (Iterator iterator = userPosition.iterator(); iterator.hasNext();) {
				RData rData = (RData) iterator.next();
				positonId+=(rData.getString("positonId")+",");
			}
			positonId = positonId.substring(0,positonId.length()-1);
		}
		RData  user=userService.getUser(rdata);
		ArrayList<RData> roleList=userService.getRoleList();
		ArrayList<RData> positionList=userService.getPositionList();
		model.addAttribute("role", roleList);
		model.addAttribute("userRole", roleId);
		model.addAttribute("positon", positionList);
		model.addAttribute("userPositon",positonId);
		model.addAttribute("user", user);
		return "sys/user/userUpdate";
	}
	
	
	/**
	 * 修改用户信息
	 */
	@RequestMapping(value ="updateUserDo")
	@ResponseBody
	public void updateUserDo() {
		if(rdata.getString("roleId").equals("null")){
			rdata.setString("roleId", "");
		}
		if(rdata.getString("positonId").equals("null")){
			rdata.setString("positonId", "");
		}
		userService.updateUserDo(rdata);
	}
	
	/**
	 * 删除用户以及角色、岗位
	 */
	@RequestMapping(value ="deleteUserDo")
	public String deleteUserDo() {
		userService.deleteUser(rdata);
		userService.deleteUserRole(rdata);
		userService.deleteUserPosition(rdata);
		return "sys/user/userList";
	}
	
	/**
	 * 修改密码
	 * @return
	 */
	@RequestMapping(value="updatePwd")
	public String updatePwd(Model model){
		model.addAttribute("user",userService.queryUserName(rdata));
		return "/sys/user/pwdUpdate";
	}
	
	/**
	 * 保存修改的密码
	 * @return
	 */
	@RequestMapping(value="saveUpdatedPwd")
	@ResponseBody
	public String saveUpdatedPwd(){
		if (SecurityService.validatePassword(rdata.getString("oldPassword"), userService.queryUserPwd(rdata))) {
			//修改密码
			rdata.setString("newPassword", SecurityService.entryptPassword(rdata.getString("newPassword")));
			return userService.saveUpdatedPwd(rdata);
		}else {
			//原密码错误
			return "oldPasswordError";
		}
	}

}
