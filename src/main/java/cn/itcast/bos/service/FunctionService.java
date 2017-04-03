package cn.itcast.bos.service;

import java.util.List;

import cn.itcast.bos.domain.Function;
import cn.itcast.bos.domain.User;

/**
 * 权限操作
 * 
 * @author seawind
 * 
 */
public interface FunctionService {

	/**
	 * 查询用户可以看见的菜单
	 * 
	 * @param user
	 * @return
	 */
	public List<Function> findMenu(User user);

}
