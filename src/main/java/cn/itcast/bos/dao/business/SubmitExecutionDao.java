package cn.itcast.bos.dao.business;

import cn.itcast.bos.domain.business.SubmitExecution;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Created by gys on 2017/6/3.
 */

@Mapper
public interface SubmitExecutionDao {

    List<SubmitExecution> listSubmitExecutions(String unitId);
}
