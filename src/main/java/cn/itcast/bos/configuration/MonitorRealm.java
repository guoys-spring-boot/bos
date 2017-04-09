package cn.itcast.bos.configuration;

import java.util.List;

import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.UnitService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itcast.bos.domain.Function;
import cn.itcast.bos.domain.Role;
import cn.itcast.bos.domain.User;
import cn.itcast.bos.service.UserService;
import org.springframework.stereotype.Component;

/**
 * 自定义 校验规则
 * 
 * @author seawind
 * 
 */

@Component
public class MonitorRealm extends AuthorizingRealm {

    public MonitorRealm(HashedCredentialsMatcher hashedCredentialsMatcher, UnitService unitService) {
        this.setCredentialsMatcher(hashedCredentialsMatcher);
        this.unitService = unitService;
    }

    private UnitService unitService;


    @Override
    // 授权
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {

        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        // 查询当前用户具有 角色和权限
//		String username = (String) super.getAvailablePrincipal(principalCollection);
//		User user = userService.findUserByUsername(username);
//		// TODO 如果是管理员， 查询所有角色 ，连同权限
//		List<Role> roles = user.getRoles();
//		for (Role role : roles) {
//			// 将role 加入 返回授权info
//			simpleAuthorizationInfo.addRole(role.getName());
//			// 加角色对应权限
//			List<Function> functions = role.getFunctions();
//			for (Function function : functions) {
//				// 将function 加入返回授权info
//				simpleAuthorizationInfo.addStringPermission(function.getName());
//			}
//		}
        return simpleAuthorizationInfo;
    }


    @Override
    // 认证
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        // 根据用户名 去查询密码
        UnitBean bean = unitService.findByUsername(token.getUsername());
        if (bean == null || StringUtils.isBlank(bean.getPassword())) {
            return null;
        }
        String password = bean.getPassword();
        return new SimpleAuthenticationInfo(token.getUsername(), password.toCharArray(), getName());

    }

}
