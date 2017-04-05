package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.AssessmentContent;

import java.util.List;

/**
 * Created by gys on 2017/4/5.
 */
public interface AssessmentContentService {

    void save(AssessmentContent content);

    void update(AssessmentContent content);

    void delete(String id);

    List<AssessmentContent> list(String type);

    AssessmentContent findById(String id);

    int count(String type);

}
