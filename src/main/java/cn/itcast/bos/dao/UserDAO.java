package cn.itcast.bos.dao;

import cn.itcast.bos.domain.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserDAO extends BaseDAO<User> {
	// 从父类基础增删改查方法

	// 登录
	public User login(User user);

	// 修改密码
	public void updatePassword(User user);

	/**
	 * 根据用户名 查询密码
	 * 
	 * @param username
	 * @return
	 */
	public String findPasswordByUsername(String username);

	/**
	 * 根据用户名 查询 全部信息 （角色和权限）
	 * 
	 * @param username
	 * @return
	 */
	public User findUserByUsername(String username);

	void deleteByIds( @Param("ids") String[] ids);
}
