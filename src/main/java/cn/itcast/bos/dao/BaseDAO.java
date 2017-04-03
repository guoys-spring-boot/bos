package cn.itcast.bos.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import cn.itcast.bos.page.PaginationInfo;

/**
 * 基础DAO ，提供通用增删改查方法
 * 
 * @author seawind
 * 
 */

public interface BaseDAO<T> {
	// 添加
	public void insert(T entity);

	// 修改
	public void update(T entity);

	// 删除
	public void delete(T entity);

	// 查询所有
	public List<T> findAll();

	// 根据id 查询
	// String int 类型都实现 Serializable
	public T findById(Serializable id);

	// 查询记录总数
	public int findTotalCount();

	// 通用查询当前页数据代码
	public List<T> findPaginationData(@Param("first") int first, @Param("last") int last);

	// 有条件的分页
	// public List<T> findPaginationDataByCondition(@Param("first") int first, @Param("last") int last, @Param("condition") Map condition);

	// 查询记录总数
	public int findTotalCountByCondition(PaginationInfo<T> paginationInfo);

	// 有条件的分页数据
	public List<T> findPaginationDataByCondition(PaginationInfo<T> paginationInfo);

	// 使用拦截器的分页
	public List<T> queryByPage(PaginationInfo<T> paginationInfo);

}
