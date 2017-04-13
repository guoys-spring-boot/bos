package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.AttachmentDao;
import cn.itcast.bos.domain.business.Attachment;
import cn.itcast.bos.service.business.AttachmentService;
import cn.itcast.bos.utils.UUIDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/4/13.
 */

@Service
@Transactional
public class AttachServiceImp implements AttachmentService {

    private AttachmentDao attachmentDao;

    public AttachServiceImp(AttachmentDao dao){
        this.attachmentDao = dao;
    }

    @Override
    public void insert(Attachment attachment) {
        if(StringUtils.isBlank(attachment.getId())){
            attachment.setId(UUIDUtils.generatePrimaryKey());
        }
        attachmentDao.insert(attachment);
    }

    @Override
    public List<Attachment> findByForeignKey(String key) {
        return attachmentDao.findByForeignKey(key);
    }

    @Override
    public void updateForeign(String id, String key) {
        attachmentDao.updateForeignKey(id, key);
    }
}
