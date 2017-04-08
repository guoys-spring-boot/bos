package cn.itcast.bos.domain.business;

import java.util.ArrayList;
import java.util.List;

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


    private List<AssessmentStd> assessmentStdList = new ArrayList<AssessmentStd>();

    private double totalScore;

    public List<AssessmentStd> getAssessmentStdList() {
        return assessmentStdList;
    }

    private ArrayList<AssessmentStd> needInserts = new ArrayList<AssessmentStd>();
    private ArrayList<AssessmentStd> needUpdates = new ArrayList<AssessmentStd>();
    private  ArrayList<AssessmentStd> needDeletes = new ArrayList<AssessmentStd>();

    public ArrayList<AssessmentStd> getNeedInserts() {
        return needInserts;
    }

    public void setNeedInserts(ArrayList<AssessmentStd> needInserts) {
        this.needInserts = needInserts;
    }

    public ArrayList<AssessmentStd> getNeedUpdates() {
        return needUpdates;
    }

    public void setNeedUpdates(ArrayList<AssessmentStd> needUpdates) {
        this.needUpdates = needUpdates;
    }

    public ArrayList<AssessmentStd> getNeedDeletes() {
        return needDeletes;
    }

    public void setNeedDeletes(ArrayList<AssessmentStd> needDeletes) {
        this.needDeletes = needDeletes;
    }

    public void setAssessmentStdList(List<AssessmentStd> assessmentStdList) {
        this.assessmentStdList = assessmentStdList;
    }

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
                ", assessmentStdList=" + assessmentStdList +
                ", totalScore=" + totalScore +
                ", needInserts=" + needInserts +
                ", needUpdates=" + needUpdates +
                ", needDeletes=" + needDeletes +
                '}';
    }
}
