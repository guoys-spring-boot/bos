package cn.itcast.bos.service;

import cn.itcast.bos.domain.User;

import java.util.List;

public interface UserService {
	public void saveUser(User user);

	public User findUserByLogin(User user);

	public void updatePassword(User user);

	/**
	 * 根据用户名 查询密码
	 * 
	 * @param username
	 * @return
	 */
	public String findPasswordByUsername(String username);

	/**
	 * 查询用户 对应 角色和权限信息
	 * 
	 * @param username
	 * @return
	 */
	public User findUserByUsername(String username);

	List<User> findAllUser();

	void deleteUser(String ids);

	int totalUser();
}
