package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.SubmitContent;

import java.util.List;

/**
 * Created by gys on 2017/4/9.
 */
public interface SubmitContentService {

    void save(SubmitContent content);

    List<SubmitContent> listSubmitContent(String unitId);

    SubmitContent findById(String id);
}
