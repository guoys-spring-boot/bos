package cn.itcast.bos.dao.business;

import cn.itcast.bos.dao.BaseDAO;
import cn.itcast.bos.domain.business.Score;
import cn.itcast.bos.domain.business.SubmitContent;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by gys on 2017/4/9.
 */

@Mapper
public interface SubmitContentDao extends BaseDAO<SubmitContent> {

    List<SubmitContent> findByUnitId(@Param("unitId") String unitId);

    List<Score> findScoresByContentId(@Param("contentId") String contentId);

    int checkAlreadySubmit(@Param("contentId") String contentId, @Param("projectId") String projectId,
                           @Param("unitId") String unitId);
    int getYwcCount(@Param("unitId") String unitId);

}
