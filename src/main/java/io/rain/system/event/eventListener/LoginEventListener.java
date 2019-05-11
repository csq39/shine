package io.rain.system.event.eventListener;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import io.rain.context.bean.SystemUser;
import io.rain.context.event.RayComEvent;
import io.rain.context.event.listener.IRayComEventListener;
import io.rain.context.event.sysEvent.LoginEvent;
import io.rain.core.collection.RData;
import io.rain.modules.sys.main.MainDao;
import io.rain.web.support.utils.user.UserUtils;

@Component
public class LoginEventListener implements IRayComEventListener{
	
	@Autowired
	MainDao mainDao;

	@Override
	public void onRayComEvent(RayComEvent event) {
		System.out.println("**************");
		System.out.println(((SystemUser)event.getSource()).getLoginName()+"登录成功,登录时间："+new Date());
		System.out.println("**************"+UserUtils.getUser().getCompanyId());
		SystemUser user = (SystemUser)event.getSource();
		      
		System.out.println("**************"+user.getCompanyId());
		
		
		//user.setUserData(orgData);
	}

	@Override
	public List<String> getEventClasses() {
		List<String> className = new ArrayList<String>();
		className.add(LoginEvent.class.getName());
		return className;
	}

}
