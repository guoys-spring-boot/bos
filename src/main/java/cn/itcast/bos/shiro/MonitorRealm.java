package cn.itcast.bos.shiro;

import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itcast.bos.domain.Function;
import cn.itcast.bos.domain.Role;
import cn.itcast.bos.domain.User;
import cn.itcast.bos.service.UserService;

/**
 * 自定义 校验规则
 * 
 * @author seawind
 * 
 */
public class MonitorRealm extends AuthorizingRealm {

	@Autowired
	private UserService userService;

	@Override
	// 授权
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
		System.out.println("用户授权 ========================");
		SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
		// 查询当前用户具有 角色和权限
		String username = (String) super.getAvailablePrincipal(principalCollection);
		User user = userService.findUserByUsername(username);
		// TODO 如果是管理员， 查询所有角色 ，连同权限
		List<Role> roles = user.getRoles();
		for (Role role : roles) {
			// 将role 加入 返回授权info
			simpleAuthorizationInfo.addRole(role.getName());
			// 加角色对应权限
			List<Function> functions = role.getFunctions();
			for (Function function : functions) {
				// 将function 加入返回授权info
				simpleAuthorizationInfo.addStringPermission(function.getName());
			}
		}
		return simpleAuthorizationInfo;
	}

	@Override
	// 认证
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
		System.out.println("用户登陆 认证 ==============================================");
		UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
		// 根据用户名 去查询密码
		String password = userService.findPasswordByUsername(token.getUsername());
		if (password == null) {
			// 没有用户名
			return null; // 用户名不存在异常
		} else {
			return new SimpleAuthenticationInfo(token.getUsername(), password.toCharArray(), getName());
		}
	}

}
