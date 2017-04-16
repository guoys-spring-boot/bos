package cn.itcast.bos.dao.business;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import cn.itcast.bos.dao.BaseDAO;
import cn.itcast.bos.domain.business.ReportUpBean;

@Mapper
public interface ReportDao extends BaseDAO<ReportUpBean>{
	
	List<ReportUpBean> findAll(ReportUpBean reportUpbean);
	
	int totalCountByCondition(ReportUpBean reportUpbean);
}
