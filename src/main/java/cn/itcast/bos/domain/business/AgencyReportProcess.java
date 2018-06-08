package cn.itcast.bos.domain.business;

import java.io.Serializable;

/**
 * 单位上传进度
 */
public class AgencyReportProcess implements Serializable{

    private String id;

    private String unitFullName;

    private String unitLevelText;

    private String unitLevel;

    private Integer totalContent; // 所有题目数

    private Integer reported; // 已上报数量

    private Integer scored; // 已打岔数量

    private Double totalScore; // 总分

    private String year; // 年度

    private String parentUnit;

    private String privateUnit;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUnitFullName() {
        return unitFullName;
    }

    public void setUnitFullName(String unitFullName) {
        this.unitFullName = unitFullName;
    }

    public String getUnitLevelText() {
        return unitLevelText;
    }

    public void setUnitLevelText(String unitLevelText) {
        this.unitLevelText = unitLevelText;
    }

    public String getUnitLevel() {
        return unitLevel;
    }

    public void setUnitLevel(String unitLevel) {
        this.unitLevel = unitLevel;
    }

    public Integer getTotalContent() {
        return totalContent;
    }

    public void setTotalContent(Integer totalContent) {
        this.totalContent = totalContent;
    }

    public Integer getReported() {
        return reported;
    }

    public void setReported(Integer reported) {
        this.reported = reported;
    }

    public Integer getScored() {
        return scored;
    }

    public void setScored(Integer scored) {
        this.scored = scored;
    }

    public Double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Double totalScore) {
        this.totalScore = totalScore;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getParentUnit() {
        return parentUnit;
    }

    public void setParentUnit(String parentUnit) {
        this.parentUnit = parentUnit;
    }

    public String getPrivateUnit() {
        return privateUnit;
    }

    public void setPrivateUnit(String privateUnit) {
        this.privateUnit = privateUnit;
    }
}
