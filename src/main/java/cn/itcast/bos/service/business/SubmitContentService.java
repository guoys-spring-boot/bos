package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.Score;
import cn.itcast.bos.domain.business.SubmitContent;

import java.util.List;

/**
 * Created by gys on 2017/4/9.
 */
public interface SubmitContentService {

    void save(SubmitContent content, String attachments);

    List<SubmitContent> listSubmitContent(String unitId);


    SubmitContent findById(String id);

    void update(SubmitContent content, String needInsert, String needDelete);

    /**
     *  统计总分
     * @param unitId 单位id
     * @return
     */
    double getAlreadyScore(String unitId);

    /**
     * 根据上报内容id获取详细得分
     * @param contentId 上报内容ID
     * @return
     */
    List<Score> listScoresByContentId(String contentId);
}
