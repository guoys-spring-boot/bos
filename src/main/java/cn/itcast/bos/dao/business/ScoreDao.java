package cn.itcast.bos.dao.business;

import cn.itcast.bos.dao.BaseDAO;
import cn.itcast.bos.domain.business.Score;
import org.apache.ibatis.annotations.Mapper;

/**
 * Created by gys on 2017/4/16.
 */

@Mapper
public interface ScoreDao extends BaseDAO<Score> {
    public Double getScore(String dwid);
    public int getYwcCount(String dwid);
}
