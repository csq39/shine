<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/core/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
  <meta content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=0" name="viewport"> 
  <link rel="stylesheet" type="text/css" href="${ctxStatic}/plugins/login/core.css" />
 <title>${fns:getConfig('productName')}</title>
</head>
<body class="white no-ads" >   
<div id="userView" class="scale-out" style="background-color:rgb(233, 237, 240);"> 
	<canvas width="1920" height="363"></canvas>   
	<div id="login-popup-box">  
		<div id="login-popup-left"> 
			<div id="login-popup-left-inner">
			<div class="login-vip-popup-content">
				<p class="vip-title">神威药业OTMS接口</p>
				<div class="vip-content">
					<ul>
						<li>交货单接口</li>
						<li>随货同行单接口</li>
						<li>系统推送</li>
					</ul>
				</div>
			</div>
			</div> 
		</div> 
		<div id="login-popup-right" class="font-open-sans"> 
		<div id="login-popup-right-inner"> 
		<div class="user_bg"> 
		<div> 
		<div class="all_panels" id="login_panel" style=""> 
			<form id="loginForm" name="loginForm" class="form-signin" action="${ctx}/login" method="post"> 
			<div class="clearfloat"><p style="font-family:'Trebuchet MS';font-size:24px;line-height: 22px;padding-top: 24px;text-align: center;">${fns:getConfig('productName')}</p> </div>
			<div class="underlogo-space">
				<div class="msg_box"  class=" ${empty message ? 'hide' : ''}">
					${message}
				</div> 
			</div>
			
			<div class="login-input-container">
				<div class="inputtextbg_div">
					<input tabindex="1" name="username" id="username" class="inputtext" maxlength="100" value="" placeholder="登录名" type="text"> 
				</div>
			</div>
			<div class="login-input-container clearfix">
				<div class="inputtextbg_div">
					<input tabindex="2" name="password" id="password" class="inputtext" value="" placeholder="登录密码" type="password">
				</div>
				<div class="msg_box allmsg"></div>
			</div>
			<c:if test="${isValidateCodeLogin}">
			<div class="login-input-container clearfix">
				<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
			</div>
			</c:if>
			<!--
			<div class="login_remember clearfloat">
				<span class="d_left">
					<div class="d_checkbox"><input name="rememberMe" id="rememberMe" class="c_input" value="" type="hidden"></div>
					<a class="l_cb" href="javascript:void(0)" id="ULP_w_remember">记住密码</a> 
				</span>
				<span class="d_right"> 
					<a href="javascript:;" class="resetPass" id="ULP_w_forgetpwd">忘记密码</a>
				</span>
			</div> 
			-->
			<div class="loginPanelBottomBtn">
				<a  href = "javascript:;" onclick ="login();" class="userupbtn btnfx btn-8g" id="login_btn">登录</a> 
				   <input type="submit" name="argsubmit" style="display:none"/>
			</div> 
			<div class="go_sign_up"> 请输入用户名和密码进行登陆<!--<a href="javascript:;" id="go-register">马上注册</a> --></div> 
			</form>
			</div> 
			<div class="terms_privacy form-bottom"> 
			<hr class="hr1"> 
			<span class="user_other_login"></span> 
			</div> 
		</div>           
		</div>  
		</div>
		</div> 
		</div>
	</div>   
</div> 
<script src="${ctxStatic}/plugins/jquery/jquery.min.js"></script>
<script src="${ctxStatic}/plugins/jquery/jquery.validate.min.js"></script>
<script src="${ctxStatic}/plugins/login/canvas.js"></script>
<script type="text/javascript">
		$(document).ready(function() {

			if(self!=top){
				//如果不是顶层页面，将其设为顶层页面
			 	top.location=self.location;
			}
			
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			rayDialog('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
		
		if(self!=top){
			//如果不是顶层页面，将其设为顶层页面
		 	top.location=self.location;
		}
		
		function login(){
			document.getElementById("loginForm").submit();
		}
	</script>
</body></html>