package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.SubmitContentDao;
import cn.itcast.bos.domain.business.SubmitContent;
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
    public List<SubmitContent> listSubmitContent(String unitId) {
        return submitContentDao.findByUnitId(unitId);
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
}
