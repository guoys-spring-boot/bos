package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.Score;

import java.util.List;

/**
 * Created by gys on 2017/4/16.
 */
public interface ScoreService {

    void insert(List<Score> scores);
}
