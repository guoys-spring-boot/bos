package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.SubmitContentDao;
import cn.itcast.bos.domain.business.SubmitContent;
import cn.itcast.bos.service.business.SubmitContentService;
import cn.itcast.bos.utils.UUIDUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/4/9.
 */

@Service
@Transactional
public class SubmitContentServiceImp implements SubmitContentService {

    public SubmitContentServiceImp(SubmitContentDao dao){
        this.submitContentDao = dao;
    }

    private SubmitContentDao submitContentDao;

    @Override
    public void save(SubmitContent content) {
        content.setId(UUIDUtils.generatePrimaryKey());
        submitContentDao.insert(content);
    }

    @Override
    public List<SubmitContent> listSubmitContent(String unitId) {
        return submitContentDao.findByUnitId(unitId);
    }

    @Override
    public SubmitContent findById(String id) {
        return submitContentDao.findById(id);
    }
}
