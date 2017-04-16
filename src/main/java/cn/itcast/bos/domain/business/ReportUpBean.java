package cn.itcast.bos.domain.business;

public class ReportUpBean {
       private String id; // 上报内容ID
       private String khxmid;//考核项目ID
       private String dwid;//单位ID
       private String khxm;//考核项目
       private String xmlx;//考核类型
       private double totalscore;//考核项目总分
       private String unitShortName;//单位名称
       private String unitLevel;//单位等级
       private String xmlxmc;
       private String levelmc;
       private String shangji;
       private Double score; // 得分
	public String getShangji() {
		return shangji;
	}
	public void setShangji(String shangji) {
		this.shangji = shangji;
	}
	public String getXmlxmc() {
		return xmlxmc;
	}
	public void setXmlxmc(String xmlxmc) {
		this.xmlxmc = xmlxmc;
	}
	public String getLevelmc() {
		return levelmc;
	}
	public void setLevelmc(String levelmc) {
		this.levelmc = levelmc;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getKhxmid() {
		return khxmid;
	}
	public void setKhxmid(String khxmid) {
		this.khxmid = khxmid;
	}
	public String getDwid() {
		return dwid;
	}
	public void setDwid(String dwid) {
		this.dwid = dwid;
	}
	public String getKhxm() {
		return khxm;
	}
	public void setKhxm(String khxm) {
		this.khxm = khxm;
	}
	public String getXmlx() {
		return xmlx;
	}
	public void setXmlx(String xmlx) {
		this.xmlx = xmlx;
	}
	public double getTotalscore() {
		return totalscore;
	}
	public void setTotalscore(double totalscore) {
		this.totalscore = totalscore;
	}
	public String getUnitShortName() {
		return unitShortName;
	}
	public void setUnitShortName(String unitShortName) {
		this.unitShortName = unitShortName;
	}
	public String getUnitLevel() {
		return unitLevel;
	}
	public void setUnitLevel(String unitLevel) {
		this.unitLevel = unitLevel;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}
}
