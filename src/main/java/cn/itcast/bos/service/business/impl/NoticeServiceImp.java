package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.NoticeDao;
import cn.itcast.bos.domain.business.Notice;
import cn.itcast.bos.service.business.AttachmentService;
import cn.itcast.bos.service.business.NoticeService;
import cn.itcast.bos.utils.UUIDUtils;
import org.apache.commons.httpclient.util.DateUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by gys on 2018/6/1.
 */

@Service
@Transactional
public class NoticeServiceImp implements NoticeService {

    private NoticeDao noticeDao;

    private AttachmentService attachmentService;

    public NoticeServiceImp(NoticeDao noticeDao, AttachmentService attachmentService){
        this.noticeDao = noticeDao;
        this.attachmentService = attachmentService;
    }

    @Override
    public List<Notice> findAll() {
        return noticeDao.findAll();
    }

    @Override
    public List<Notice> findTop(int top) {
        return null;
    }

    @Override
    public void saveNotice(Notice notice) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        notice.setId(UUIDUtils.generatePrimaryKey());
        notice.setDate(sdf.format(new Date()));
        attachmentService.updateForeign(notice.getAttachment().getId(), notice.getId());
        noticeDao.insert(notice);
    }

    @Override
    public void delete(String id) {
        Notice notice = new Notice();
        notice.setId(id);
        noticeDao.delete(notice);

    }
}
