package cn.itcast.bos.dao;

import java.util.List;

import cn.itcast.bos.domain.Function;
import cn.itcast.bos.domain.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FunctionDAO extends BaseDAO<Function> {

	/**
	 * 查询菜单
	 * 
	 * @param user
	 * @return
	 */
	public List<Function> findMenu(User user);

}
