package cn.itcast.bos.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;


import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import util.WebUrlUtils;
import cn.itcast.bos.domain.WeiXin;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.EnumService;
import cn.itcast.bos.service.business.UnitService;

@Controller
@RequestMapping("/mobile/login")
public class MobileLoginController {

	@Autowired
	private UnitService unitService;
	@Autowired
	private EnumService enumService;
	private static String url = "https://api.weixin.qq.com/sns/jscode2session";
	private static String appId = "wx8ef1333b22c153b0";
	private static String secret = "196124ae9405c980b9f328708cddccb0";
	
	@RequestMapping("/sendCode")
	@ResponseBody
	// check该用户是否关联了小程序
	public Map<String, String> sendCode(String code, HttpServletRequest request) {
//		String url = "https://api.weixin.qq.com/sns/jscode2session";
		Map<String, String> params = new HashMap<String, String>();
		params.put("appid", appId);
		params.put("secret", secret);
		params.put("js_code", code);
		params.put("grant_type", "authorization_code");

		String jsonResult = WebUrlUtils.getRemoteByUrl(url, params);
		JSONObject jsonobject = JSONObject.fromObject(jsonResult);
		WeiXin weiXin = (WeiXin) JSONObject.toBean(jsonobject, WeiXin.class);
		System.out.println(weiXin.getOpenid() + "|" + weiXin.getSession_key());

		Map<String, String> map = new HashMap<String, String>();
		UnitBean unitBean = unitService.findByOpenid(weiXin.getOpenid());
		if (unitBean != null) {
			String sessionKey = unitBean.getSessionKey();
			map.put("is_login", "1");
			map.put("session_key", sessionKey);
			UnitBean updateBean = unitService.findById(unitBean.getId());
			updateBean.setSessionKey(sessionKey);
			unitService.update(updateBean);
		} else {
			map.put("is_login", "2");
		}
		return map;
	}
	
	@RequestMapping("/sendSessionKey")
	@ResponseBody
	// check该用户是否关联了小程序
	public Map<String, String> sendSessionKey(String sessionKey, HttpServletRequest request){
		Map<String, String> map = new HashMap<String, String>();
		UnitBean unitBean = unitService.findBySessionKey(sessionKey);
		if (unitBean != null) {
			map.put("is_login", "1");
			map.put("session_key", sessionKey);
		} else {
			map.put("is_login", "2");
			map.put("session_key", sessionKey);
		}
		return map;
	}

	// 获取用户信息
	@RequestMapping("/getUserInfo")
	@ResponseBody
	public Map<String, Object> getUserInfo(String sessionKey,
			HttpServletRequest request) {
		UnitBean unitBean = unitService.findBySessionKey(sessionKey);
		if(unitBean != null){
			unitBean.setParentUnitCode(unitService.findById(unitBean.getParentUnitCode()).getUnitFullName());
			Map<String, String> mapUnitType = enumService.getEnum("unitType");
			unitBean.setUnitType(mapUnitType.get(unitBean.getUnitType()));
			Map<String, String> mapUnitProperty = enumService.getEnum("unitProperty");
			unitBean.setUnitProperty(mapUnitProperty.get(unitBean.getUnitProperty()));
			Map<String, String> mapUnitLevel = enumService.getEnum("unitLevel");
			unitBean.setUnitLevel(mapUnitLevel.get(unitBean.getUnitLevel()));
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status", "0");
		map.put("data", unitBean);
		return map;
	}

	// 检测后台是否绑定小程序
	@RequestMapping("/checkLogin")
	@ResponseBody
	public Map<String, String> bindWx(String sessionKey,
			HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		if (StringUtils.isBlank(sessionKey)) {
			return map;
		}
		UnitBean unitBean = unitService.findBySessionKey(sessionKey);
		if (unitBean != null) {
			map.put("is_login", "1");
			map.put("session_key", sessionKey);
		} else {
			map.put("is_login", "2");
			map.put("session_key", sessionKey);
		}
		return map;
	}

	//绑定小程序
	@RequestMapping("/bindXcx")
	@ResponseBody
	public Map<String, String> bindXcx(String code, String username, String password,
			HttpServletRequest request) {
		Map<String, String> result = new HashMap<String, String>();
		if(StringUtils.isEmpty(username) || StringUtils.isEmpty(password)){// 用户名或密码为空
			result.put("errMsg", "用户名或密码为空");
			result.put("status", "2");
            return result;
        }
		if(StringUtils.isEmpty(code)){//微信未授权登陆
			result.put("errMsg", "微信未授权登陆");
			result.put("status", "3");
            return result;
        }
		// 使用shiro 进行权限控制
		Subject userSubject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(username, password.toCharArray());
		// 记住用户信息
		//token.setRememberMe(true);

		UnitBean unitBean = unitService.findByUsername(username);
		if(unitBean == null){
			result.put("errMsg", "用户不存在");
			result.put("status", "4");
            return result;
        }
		if(!"1".equals(unitBean.getAuditingStatus()) && !"admin".equals(unitBean.getUsername())){
            result.put("errMsg", "该单位还没有审核通过");
			result.put("status", "5");
            return result;
        }
		userSubject.login(token);
		UnitBean unit = unitService.findById(unitBean.getId());
		Map<String, String> params = new HashMap<String, String>();
		params.put("appid", appId);
		params.put("secret", secret);
		params.put("js_code", code);
		params.put("grant_type", "authorization_code");
		String sessionKey = UUID.randomUUID().toString();
		String jsonResult = WebUrlUtils.getRemoteByUrl(url, params);
		JSONObject jsonobject = JSONObject.fromObject(jsonResult);
		WeiXin weiXin = (WeiXin) JSONObject.toBean(jsonobject, WeiXin.class);
		System.out.println(weiXin.getOpenid() + "|" + weiXin.getSession_key());
		unit.setOpenid(weiXin.getOpenid());
		unit.setSessionKey(sessionKey);
		unitService.update(unit);
		
		result.put("sessionKey", sessionKey);
		result.put("errMsg", "小程序登陆成功");
		result.put("status", "0");
        return result;
	}
}
