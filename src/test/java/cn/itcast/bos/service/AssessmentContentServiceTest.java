package cn.itcast.bos.service;

import cn.itcast.bos.dao.business.AssessmentContentDao;
import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.utils.UUIDUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.context.SpringBootContextLoader;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Configuration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * Created by gys on 2017/4/5.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
public class AssessmentContentServiceTest {

    @Autowired
    private AssessmentContentDao assessmentContentDao;

    @Test
    public void testInsert(){
        AssessmentContent content = new AssessmentContent();
        content.setId(UUIDUtils.generatePrimaryKey());
        content.setProjectName("projectName");
        content.setType("1");
        assessmentContentDao.insert(content);
        System.out.println(assessmentContentDao);
    }

    @Test
    public void testUpdate(){
        AssessmentContent content = assessmentContentDao.findById("210f3fbd2a784519878a17efa68ae1c8");
        content.setType("2");
        content.setProjectName("projectName2");
        content.setTotalScore(20.3);
        assessmentContentDao.update(content);
    }

    @Test
    public void testFindAll(){
        List<AssessmentContent> all = assessmentContentDao.findAll(new AssessmentContent());
        System.out.println(all);
    }
}
