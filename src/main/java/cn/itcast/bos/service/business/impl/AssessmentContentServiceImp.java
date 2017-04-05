package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.AssessmentContentDao;
import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.service.business.AssessmentContentService;
import cn.itcast.bos.utils.UUIDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/4/5.
 */

@Service
@Transactional
public class AssessmentContentServiceImp implements AssessmentContentService {

    private AssessmentContentDao dao;
    public AssessmentContentServiceImp(AssessmentContentDao dao){
        this.dao = dao;
    }


    @Override
    public void save(AssessmentContent content) {
        content.setId(UUIDUtils.generatePrimaryKey());
        dao.insert(content);
    }

    @Override
    public void update(AssessmentContent content) {
        if(StringUtils.isBlank(content.getId())){
            return;
        }
        dao.update(content);
    }

    @Override
    public void delete(String id) {
        if(StringUtils.isBlank(id)){
            return;
        }
        AssessmentContent content = new AssessmentContent();
        content.setId(id);
        dao.delete(content);
    }

    @Override
    public List<AssessmentContent> list(String type) {
        AssessmentContent content = new AssessmentContent();
        content.setType(type);
        return dao.findAll(content);

    }

    @Override
    public AssessmentContent findById(String id) {
        if(StringUtils.isBlank(id)){
            return null;
        }
        return dao.findById(id);
    }

    @Override
    public int count(String type) {
        AssessmentContent content = new AssessmentContent();
        content.setType(type);
        return dao.count(content);
    }
}

