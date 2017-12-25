package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.AssessmentContentDao;
import cn.itcast.bos.dao.business.AssessmentStdDao;
import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.domain.business.AssessmentStd;
import cn.itcast.bos.service.business.AssessmentContentService;
import cn.itcast.bos.utils.UUIDUtils;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by gys on 2017/4/5.
 */

@Service
@Transactional
public class AssessmentContentServiceImp implements AssessmentContentService {

    private AssessmentContentDao dao;
    private AssessmentStdDao stdDao;
    public AssessmentContentServiceImp(AssessmentContentDao dao, AssessmentStdDao stdDao){
        this.dao = dao;
        this.stdDao = stdDao;
    }


    @Override
    public void save(AssessmentContent content) {
        content.setId(UUIDUtils.generatePrimaryKey());
        if(content.getAssessmentStdList() != null){
            for (AssessmentStd std : content.getAssessmentStdList()) {
                if(StringUtils.isBlank(std.getItem()) || StringUtils.isBlank(std.getItem())){
                    continue;
                }
                std.setId(UUIDUtils.generatePrimaryKey());
                std.setContentId(content.getId());
                stdDao.insert(std);
            }
        }
        dao.insert(content);
    }

    @Override
    public void update(AssessmentContent content) {
        if(StringUtils.isBlank(content.getId())){
            return;
        }
        dao.update(content);
        ArrayList<AssessmentStd> needDeletes = content.getNeedDeletes();
        for (AssessmentStd needDelete : needDeletes) {
            stdDao.delete(needDelete);
        }
        ArrayList<AssessmentStd> needInserts = content.getNeedInserts();
        for (AssessmentStd needInsert : needInserts) {
            if(StringUtils.isBlank(needInsert.getItem()) || StringUtils.isBlank(needInsert.getItem())){
                continue;
            }
            needInsert.setContentId(content.getId());
            needInsert.setId(UUIDUtils.generatePrimaryKey());
            stdDao.insert(needInsert);
        }
        for (AssessmentStd needUpdate : content.getNeedUpdates()) {
            stdDao.update(needUpdate);
        }
    }

    @Override
    public void delete(String id) {
        if(StringUtils.isBlank(id)){
            return;
        }
        AssessmentContent content = new AssessmentContent();
        content.setId(id);
        stdDao.deleteByContentId(id);
        dao.delete(content);
    }

    @Override
    public void deleteBatch(String ids) {
        for (String s : ids.split(",")) {
            delete(s);
        }
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

    @Override
    public List<AssessmentStd> listStds(String contentId) {
        if(StringUtils.isBlank(contentId)){
            return new ArrayList<AssessmentStd>();
        }
        return dao.findStdByContentId(contentId);
    }


	@Override
	public List<AssessmentContent> getWwcList(String unitId) {
		// TODO Auto-generated method stub
		return dao.getWwcList(unitId);
	}


	@Override
	public List<AssessmentContent> getYwcList(String unitId) {
		// TODO Auto-generated method stub
		return dao.getYwcList(unitId);
	}
}

