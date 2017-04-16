package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.ScoreDao;
import cn.itcast.bos.domain.business.Score;
import cn.itcast.bos.service.business.ScoreService;
import cn.itcast.bos.utils.UUIDUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/4/16.
 */

@Service
@Transactional
public class ScoreServiceImp implements ScoreService {

    private ScoreDao scoreDao;

    public ScoreServiceImp(ScoreDao scoreDao){
        this.scoreDao = scoreDao;
    }

    @Override
    public void insert(List<Score> scores) {
        if(scores != null){
            for (Score score : scores) {
                score.setId(UUIDUtils.generatePrimaryKey());
                scoreDao.insert(score);
            }
        }
    }
}
