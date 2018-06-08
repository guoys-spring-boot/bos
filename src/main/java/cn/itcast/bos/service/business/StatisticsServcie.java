package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.SubmitExecution;

import java.util.List;

/**
 * Created by gys on 2017/6/3.
 */
public interface StatisticsServcie {

    List<SubmitExecution> listSubmitExecutions(String unitId, String year);
}
