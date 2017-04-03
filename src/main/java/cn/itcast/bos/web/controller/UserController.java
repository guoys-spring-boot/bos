package cn.itcast.bos.web.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Observable;

import javax.servlet.http.HttpServletRequest;


import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itcast.bos.domain.User;
import cn.itcast.bos.service.UserService;


/**
 * 用户操作控制器
 * @author seawind
 *
 */
@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	/**
	 * 修改密码  (使用 flexjson)
	 * @return
	 * @throws IOException 
	 */
//	@RequestMapping("/updatePassword.do")
//	public void updatePassword(String password, HttpServletRequest request, HttpServletResponse response) throws IOException{
//		// 封装新密码
//		User user = (User) request.getSession().getAttribute("user");
//		user.setPassword(password);
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		try{
//			// 调用Service层
//			userService.updatePassword(user);
//			// 向客户端返回 结果（以json返回 ）
//			result.put("success", true); 
//			result.put("msg", "修改密码成功！");
//		}catch(Exception e){
//			result.put("success", false); 
//			result.put("msg", "修改密码失败！发送异常："+ e.getMessage());
//		}
//		
//		// 将结果转换json
//		JSONSerializer jsonSerializer = new JSONSerializer();
//		String json = jsonSerializer.deepSerialize(result);
//		
//		response.setContentType("application/json;charset=utf-8");
//		response.getWriter().print(json);
//		
//	}
	
	@RequestMapping("/updatePassword.do")
	@ResponseBody // 注解 将返回值，自动转换为 json格式
	public Object updatePassword(String password, HttpServletRequest request) throws IOException{
		// 封装新密码
		User user = (User) request.getSession().getAttribute("user");
		user.setPassword(password);
		
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			// 调用Service层
			userService.updatePassword(user);
			// 向客户端返回 结果（以json返回 ）
			result.put("success", true); 
			result.put("msg", "修改密码成功！");
		}catch(Exception e){
			result.put("success", false); 
			result.put("msg", "修改密码失败！发送异常："+ e.getMessage());
		}
		return result;
	}

	@RequestMapping("/listUser")
    @ResponseBody
	public Map<String, Object> listUser(Integer page, Integer rows){

	    Map<String, Object> result = new HashMap<String, Object>();

	    int pageNum = page == null ? 1 : page;
	    int pageSize = rows == null ? 10 : rows;
	    PageHelper.startPage(pageNum, pageSize);
        result.put("rows", userService.findAllUser());
        result.put("total", userService.totalUser());
		return result;
	}

	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
	public String saveUser(User user){
	    userService.saveUser(user);
	    return "admin/userlist";
    }

    @RequestMapping("/deleteUser")
    @ResponseBody
    public void deleteUser(String ids){
        userService.deleteUser(ids);
    }
}
