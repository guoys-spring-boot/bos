package cn.itcast.bos.dao.business;

import cn.itcast.bos.dao.BaseDAO;
import cn.itcast.bos.domain.business.Notice;

import org.apache.ibatis.annotations.Mapper;

/**
 * Created by gys on 2018/6/1.
 */

@Mapper
public interface NoticeDao  extends BaseDAO<Notice>{
}
