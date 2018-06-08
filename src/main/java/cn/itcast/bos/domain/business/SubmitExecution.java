package cn.itcast.bos.domain.business;


import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.text.DecimalFormat;

/**
 * 上报情况表， 统计使用
 */
public class SubmitExecution {

    private String unitName;

    private String unitType;

    private String totalCount; // 总题目数

    private String completedCount; // 已经完成数

    private String unCompleteCount; //未完成数

    private Double totalScore;

    private String competePercent; //完成率

    private String id;

    @JsonProperty(value = "_parentId")
    private String _parentId;


    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public String getUnitType() {
        return unitType;
    }

    public void setUnitType(String unitType) {
        this.unitType = unitType;
    }

    public String getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(String totalCount) {
        this.totalCount = totalCount;
    }

    public String getCompletedCount() {
        return completedCount;
    }

    public void setCompletedCount(String completedCount) {
        this.completedCount = completedCount;
    }

    public String getUnCompleteCount() {
        return unCompleteCount;
    }

    public void setUnCompleteCount(String unCompleteCount) {
        this.unCompleteCount = unCompleteCount;
    }

    public Double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Double totalScore) {
        this.totalScore = totalScore;
    }

    public String getCompetePercent() {
        double percent = Double.parseDouble(this.getCompletedCount()) / Double.parseDouble(this.getTotalCount()) * 100;
        return new DecimalFormat("###0.##").format(percent) + "%";
    }

    public void setCompetePercent(String competePercent) {
        this.competePercent = competePercent;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String get_parentId() {
        return _parentId;
    }

    public void set_parentId(String _parentId) {
        this._parentId = _parentId;
    }

    @Override
    public String toString() {
        return "SubmitExecution{" +
                "unitName='" + unitName + '\'' +
                ", unitType='" + unitType + '\'' +
                ", totalCount='" + totalCount + '\'' +
                ", completedCount='" + completedCount + '\'' +
                ", unCompleteCount='" + unCompleteCount + '\'' +
                ", totalScore=" + totalScore +
                ", competePercent='" + competePercent + '\'' +
                ", _parentId='" + _parentId + '\'' +
                '}';
    }
}
