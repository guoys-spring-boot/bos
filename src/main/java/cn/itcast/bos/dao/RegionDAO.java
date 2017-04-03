package cn.itcast.bos.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import cn.itcast.bos.domain.Region;

@Mapper
public interface RegionDAO extends BaseDAO<Region> {

	/**
	 * 批量插入
	 * 
	 * @param regions
	 */
	public void insertBatch(List<Region> regions);

	/**
	 * 条件查询
	 * 
	 * @param q
	 * @return
	 */
	public List<Region> findRegionsByCondition(@Param("q") String q);

}
