package cn.itcast.bos.dao.business;

import cn.itcast.bos.dao.BaseDAO;
import cn.itcast.bos.domain.business.UnitBean;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Created by gys on 2017/4/3.
 */

@Mapper
public interface UnitDao extends BaseDAO<UnitBean> {

    List<UnitBean> findUnitByCondition(UnitBean unitBean);

    int totalCountByCondition(UnitBean unitBean);
}
