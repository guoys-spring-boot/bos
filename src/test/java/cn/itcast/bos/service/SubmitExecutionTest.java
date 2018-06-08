package cn.itcast.bos.service;

import cn.itcast.bos.dao.business.SubmitExecutionDao;
import cn.itcast.bos.domain.business.SubmitExecution;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by gys on 2017/6/3.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
public class SubmitExecutionTest {

    @Autowired
    private SubmitExecutionDao dao;

    @Test
    public void test(){
        List<SubmitExecution> executions = dao.listSubmitExecutions("1", "2018");
        System.out.println(executions);
    }
}
