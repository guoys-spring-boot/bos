package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.SubmitContentDao;
import cn.itcast.bos.domain.EnumBean;
import cn.itcast.bos.domain.business.Score;
import cn.itcast.bos.domain.business.SubmitContent;
import cn.itcast.bos.domain.business.vo.MyReportVO;
import cn.itcast.bos.service.business.AttachmentService;
import cn.itcast.bos.service.business.SubmitContentService;
import cn.itcast.bos.utils.UUIDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/4/9.
 */

@Service
@Transactional
public class SubmitContentServiceImp implements SubmitContentService {

    public SubmitContentServiceImp(SubmitContentDao dao, AttachmentService attachmentService){
        this.submitContentDao = dao;
        this.attachmentService = attachmentService;
    }

    private SubmitContentDao submitContentDao;

    private AttachmentService attachmentService;


    @Override
    public List<EnumBean> listAssessmentTypeByUnitId(String unitId) {
        return submitContentDao.findAssessmentTypeByUnitId(unitId);
    }

    @Override
    public void save(SubmitContent content, String attachments) {
        content.setId(UUIDUtils.generatePrimaryKey());
        submitContentDao.insert(content);
        if(StringUtils.isNotBlank(attachments)){
            for (String s : attachments.split(",")) {
                attachmentService.updateForeign(s, content.getId());
            }
        }
    }

    @Override
    public List<SubmitContent> listSubmitContent(String unitId, String year) {
        return submitContentDao.findByUnitId(unitId, year);
    }

    @Override
    public List<SubmitContent> listSubmitContentWithProject(MyReportVO vo) {

        List<SubmitContent> result = submitContentDao.findContentWithProjectByUnitId(vo);

        for (SubmitContent content : result) {
            if(content.getProject() != null){
                content.setProjectId(content.getProject().getId());
            }
        }

        return result;

    }

    @Override
    public SubmitContent findById(String id) {
        return submitContentDao.findById(id);
    }

    @Override
    public void update(SubmitContent content, String needInsert, String needDelete) {
        submitContentDao.update(content);
        if(StringUtils.isNotBlank(needInsert)){
            for (String s : needInsert.split(",")) {
                attachmentService.updateForeign(s, content.getId());
            }
        }
        if(StringUtils.isNotBlank(needDelete)){
            for (String s : needDelete.split(",")) {
                attachmentService.deleteById(s);
            }
        }
    }

    @Override
    public double getAlreadyScore(String unitId, String year) {
        List<SubmitContent> submitContents = listSubmitContent(unitId, year);
        double total = 0d;
        for (SubmitContent submitContent : submitContents) {
            if(submitContent.getScore() != null){
                total += submitContent.getScore();
            }
        }
        return total;
    }

    @Override
    public List<Score> listScoresByContentId(String contentId, String year) {
        return submitContentDao.findScoresByContentId(contentId);
    }

    @Override
    public boolean checkAlreadySubmit(String projectId, String contentId, String unitId, String year) {
        return submitContentDao.checkAlreadySubmit(contentId, projectId, unitId, year) > 0;
    }

    public boolean checkAlreadyScored(String projectId, String contentId, String unitId, String year){
        return submitContentDao.checkAlreadyScored(contentId, projectId, unitId, year) > 0;
    }

    @Override
    public int getYwcCount(String unitId) {
        // TODO Auto-generated method stub
        return submitContentDao.getYwcCount(unitId);
    }
}
