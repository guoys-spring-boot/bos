package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.SubmitExecutionDao;
import cn.itcast.bos.domain.business.SubmitExecution;
import cn.itcast.bos.service.business.StatisticsServcie;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/6/3.
 */

@Service
@Transactional
public class StatisticsServcieImp  implements StatisticsServcie{

    private SubmitExecutionDao submitExecutionDao;
    public StatisticsServcieImp(SubmitExecutionDao dao){
        this.submitExecutionDao = dao;
    }

    @Override
    public List<SubmitExecution> listSubmitExecutions(String unitId) {
        return submitExecutionDao.listSubmitExecutions(unitId);
    }
}
