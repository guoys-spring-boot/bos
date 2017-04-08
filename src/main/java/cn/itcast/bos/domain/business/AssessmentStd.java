package cn.itcast.bos.domain.business;

/**
 * Created by gys on 2017/4/7.
 */
public class AssessmentStd {
    private String id;

    private String item;

    private String remark;

    private double score;

    private String contentId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getContentId() {
        return contentId;
    }

    public void setContentId(String contentId) {
        this.contentId = contentId;
    }

    @Override
    public String toString() {
        return "AssessmentStd{" +
                "id='" + id + '\'' +
                ", item='" + item + '\'' +
                ", remark='" + remark + '\'' +
                ", score=" + score +
                '}';
    }
}
