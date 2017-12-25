package cn.itcast.bos.dao.business;

import cn.itcast.bos.dao.BaseDAO;
import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.domain.business.AssessmentStd;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by gys on 2017/4/5.
 */

@Mapper
public interface AssessmentContentDao extends BaseDAO<AssessmentContent> {

    List<AssessmentContent> findAll(AssessmentContent content);

    int count(AssessmentContent content);

    List<AssessmentStd> findStdByContentId(@Param("contentId") String contentId);

    List<AssessmentContent> getWwcList(@Param("unitId") String unitId);
    
    List<AssessmentContent> getYwcList(@Param("unitId") String unitId);
}
