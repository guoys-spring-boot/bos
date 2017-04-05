package cn.itcast.bos.dao.business;

import cn.itcast.bos.dao.BaseDAO;
import cn.itcast.bos.domain.business.AssessmentContent;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Created by gys on 2017/4/5.
 */

@Mapper
public interface AssessmentContentDao extends BaseDAO<AssessmentContent> {

    List<AssessmentContent> findAll(AssessmentContent content);

    int count(AssessmentContent content);
}
