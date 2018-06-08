package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.domain.business.AssessmentStd;

import java.util.List;

/**
 * Created by gys on 2017/4/5.
 */
public interface AssessmentContentService {

    void save(AssessmentContent content);

    void update(AssessmentContent content);

    void delete(String id);

    void deleteBatch(String ids);

    List<AssessmentContent> list(AssessmentContent content);

    AssessmentContent findById(String id);

    int count(AssessmentContent content);

    void copyAsNewYear(String old,String newYear);

    List<AssessmentStd> listStds(String contentId);
    
    List<AssessmentContent> getWwcList(String unitId);
    
    List<AssessmentContent> getYwcList(String unitId);

}
