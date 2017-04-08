package cn.itcast.bos.dao.business;

import cn.itcast.bos.domain.business.AssessmentStd;
import cn.itcast.bos.dao.BaseDAO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * Created by gys on 2017/4/8.
 */

@Mapper
public interface AssessmentStdDao extends BaseDAO<AssessmentStd> {
    void deleteByContentId(@Param("contentId") String contentId);
}
