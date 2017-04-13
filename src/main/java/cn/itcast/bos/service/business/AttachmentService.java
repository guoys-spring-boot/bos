package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.Attachment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/4/13.
 */

public interface AttachmentService {

    void insert(Attachment attachment);

    List<Attachment> findByForeignKey(String key);

    void updateForeign(String id, String key);
}
