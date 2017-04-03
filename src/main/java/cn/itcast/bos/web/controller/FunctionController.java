package cn.itcast.bos.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.crypto.hash.Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itcast.bos.domain.Function;
import cn.itcast.bos.domain.User;
import cn.itcast.bos.service.FunctionService;

/**
 * 权限操作
 * 
 * @author seawind
 * 
 */
@Controller
public class FunctionController {

	@Autowired
	private FunctionService functionService;

	@RequestMapping("/function_menu.do")
	@ResponseBody
	public Object menu(HttpSession session) {
		// 查询当前用户具有功能
		User user = (User) session.getAttribute("user");

		// 调用业务层 ，返回Function对象集合
		List<Function> functions = functionService.findMenu(user);

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("total", functions.size());
		result.put("rows", functions);

		return result;
	}
}
