package cn.itcast.bos.domain.business;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by gys on 2017/4/9.
 */
public class SubmitContent {

    private String id;

    private AssessmentContent project;

    private String unitId;

    private String content;

    private Double score;

    private List<Score> scoreDetails = new ArrayList<Score>();

    /**
     * 成绩查询为了查出树结构加的属性
     */
    private String _parentId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public AssessmentContent getProject() {
        return project;
    }

    public void setProject(AssessmentContent project) {
        this.project = project;
    }

    public String getUnitId() {
        return unitId;
    }

    public void setUnitId(String unitId) {
        this.unitId = unitId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public List<Score> getScoreDetails() {
        return scoreDetails;
    }

    public void setScoreDetails(List<Score> scoreDetails) {
        this.scoreDetails = scoreDetails;
    }
}
