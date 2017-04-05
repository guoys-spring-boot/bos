package cn.itcast.bos.domain.business;

/**
 * Created by gys on 2017/4/5.
 */
public class AssessmentContent {
    // 主键
    private String id;

    // 考核项目
    private String projectName;

    // 考核类型
    private String type;

    private double totalScore;

    public double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(double totalScore) {
        this.totalScore = totalScore;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "AssessmentContent{" +
                "id='" + id + '\'' +
                ", projectName='" + projectName + '\'' +
                ", type='" + type + '\'' +
                ", totalScore=" + totalScore +
                '}';
    }
}
