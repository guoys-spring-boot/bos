package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.AssessmentContentDao;
import cn.itcast.bos.dao.business.AssessmentStdDao;
import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.domain.business.AssessmentStd;
import cn.itcast.bos.service.business.AssessmentContentService;
import cn.itcast.bos.utils.UUIDUtils;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    private Logger logger = LoggerFactory.getLogger(getClass());
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
    public void copyAsNewYear(String old, String newYear) {
        AssessmentContent param = new AssessmentContent();
        param.setYear(newYear);

        int count = this.count(param);
        if(count > 0){
            logger.warn("新的年度中已经有了项目， 返回");
            return;
        }

        param.setYear(old);
        List<AssessmentContent> list = this.list(param);
        for (AssessmentContent content : list) {
            content.setYear(newYear);
            content.setId(UUIDUtils.generatePrimaryKey());

            List<AssessmentStd> stds = content.getAssessmentStdList();
            for (AssessmentStd std : stds) {
                std.setYear(newYear);
                std.setId(UUIDUtils.generatePrimaryKey());
                std.setContentId(content.getId());

                stdDao.insert(std);
            }

            dao.insert(content);
        }

        logger.info("复制完成， 共复制 {} 条", list.size());
    }

    @Override
    public List<AssessmentContent> list(AssessmentContent content) {

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
    public int count(AssessmentContent content) {
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

