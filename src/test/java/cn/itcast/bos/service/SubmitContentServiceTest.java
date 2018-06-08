package cn.itcast.bos.service;

import cn.itcast.bos.dao.business.SubmitContentDao;
import cn.itcast.bos.domain.business.Score;
import cn.itcast.bos.domain.business.SubmitContent;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by gys on 2017/4/19.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
public class SubmitContentServiceTest {

    @Autowired
    private SubmitContentDao submitContentDao;

    @Test
    public void testFindByUnitId(){
        List<SubmitContent> submitContents = submitContentDao.findByUnitId("0243143576fd4392ae95c893e53d7bb5", "2018");

        System.out.printf("");
    }

    @Test
    public void testFindScoreByContentId(){
        List<Score> scores = submitContentDao.findScoresByContentId("13cbfa03e01f4ba0820e714818a7409b");

        System.out.println();
    }

}
