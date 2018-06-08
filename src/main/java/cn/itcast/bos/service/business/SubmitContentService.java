package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.EnumBean;
import cn.itcast.bos.domain.business.Score;
import cn.itcast.bos.domain.business.SubmitContent;
import cn.itcast.bos.domain.business.vo.MyReportVO;

import java.util.List;

/**
 * Created by gys on 2017/4/9.
 */
public interface SubmitContentService {

    List<EnumBean> listAssessmentTypeByUnitId(String unitId);

    void save(SubmitContent content, String attachments);

    List<SubmitContent> listSubmitContent(String unitId, String year);

    /**
     * 以项目为基准， 带考核上报内容
     * @param vo
     * @return
     */
    List<SubmitContent> listSubmitContentWithProject(MyReportVO vo);


    SubmitContent findById(String id);

    void update(SubmitContent content, String needInsert, String needDelete);

    /**
     *  统计总分
     * @param unitId 单位id
     * @return
     */
    double getAlreadyScore(String unitId, String year);

    /**
     * 根据上报内容id获取详细得分
     * @param contentId 上报内容ID
     * @return
     */
    List<Score> listScoresByContentId(String contentId, String year);

    /**
     *  检查一个考核题目是否已经上报过
     * @param projectId 题目Id
     * @param contentId 当前内容的id 修改时使用
     * @param unitId 单位Id
     * @return
     */
    boolean checkAlreadySubmit(String projectId, String contentId, String unitId, String year);

    /**
     * 检查一个考核项目是否已经打分
     * @param proejctId
     * @param contentId
     * @param unitId
     * @return
     */
    boolean checkAlreadyScored(String proejctId, String contentId, String unitId, String year);

    int getYwcCount(String unitId);
}
