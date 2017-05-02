package cn.itcast.bos.web.controller;

import javax.servlet.http.HttpServletRequest;

import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.UnitService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.itcast.bos.domain.User;
import cn.itcast.bos.service.UserService;
import cn.itcast.bos.utils.MD5Utils;

/**
 * 和登录相关控制
 * 
 * @author seawind
 * 
 */
@Controller
public class LoginController {

	public LoginController(UnitService unitService) {
		this.unitService = unitService;
	}
	private UnitService unitService;

	@RequestMapping("/login.do")
	// 用户登录
	public String login(User user, String checkcode, HttpServletRequest request, Model model) {
		// 判断验证码 是否正确
		String key = (String) request.getSession().getAttribute("key");// session中验证码
		if (key == null || !key.equals(checkcode)) {
			// 验证码无效
			model.addAttribute("msg", "验证码输入错误");
			return "login";
		}



		// 使用shiro 进行权限控制
		Subject userSubject = SecurityUtils.getSubject();
		// 将用户名和密码 封装成 令牌
		// 方法密码 必须 传递 char[]
		UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(), user.getPassword().toCharArray());
		// 记住用户信息
		token.setRememberMe(true);

		try {
            UnitBean unitBean = unitService.findByUsername(user.getUsername());

            if(unitBean == null){
                model.addAttribute("msg", "用户不存在");
                return "login";
            }

            if(!"1".equals(unitBean.getAuditingStatus()) && !"admin".equals(unitBean.getUsername())){
                model.addAttribute("msg", "该单位还没有审核通过");
                return "login";
            }

		    // shiro 提供登陆方法
			userSubject.login(token);

			request.getSession().setAttribute("user", unitService.findById(unitBean.getId()));
			// 重定向主页
			return "redirect:index.jsp";
		} catch (UnknownAccountException e) {
			e.printStackTrace();
			model.addAttribute("msg", "用户名不存在");
			return "forward:login.jsp";
		} catch (IncorrectCredentialsException e) {
			e.printStackTrace();
			model.addAttribute("msg", "密码错误");
			return "forward:login.jsp";
		}

	}

	/**
	 * 退出系统
	 * 
	 * @return
	 */
	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest request) {
		// 通知Subject 已经退出系统
		Subject subject = SecurityUtils.getSubject();
		subject.logout();

		// 销毁当前Session对象
		request.getSession().invalidate();
		return "redirect:login.jsp";
	}
}
