package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.Notice;

import java.util.List;

/**
 * Created by gys on 2018/6/1.
 */
public interface NoticeService {

    List<Notice> findAll();

    List<Notice> findTop(int top);

    void saveNotice(Notice notice);

    void delete(String id);
}
