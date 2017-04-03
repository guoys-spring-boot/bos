package cn.itcast.bos.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 登陆 控制拦截器
 * 
 * @author seawind
 * 
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

	// 所有页面都使用 PageController访问，只需要拦截 page.do
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// 如果用户没有登陆 返回false
		// if(request.getSession().getAttribute("user")==null){

		// 使用shiro 判断用户是否登陆
		Subject subject = SecurityUtils.getSubject();
		// 跳转到登陆页面
		if (!subject.isAuthenticated()) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			// 没有登陆
			return false;
		}
		return true;
	}
}
