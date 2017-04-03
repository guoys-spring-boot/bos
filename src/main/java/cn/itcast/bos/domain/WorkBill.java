package cn.itcast.bos.domain;

import java.util.Date;

/**
 * 工单信息
 * 
 * @author seawind
 * 
 */
public class WorkBill {
	private String id; // 工单编号
	private String noticebillId; // 关联通知单编号
	private String type; // 工单类型
	private String pickstate; // 取件状态
	private Date buildtime; // 产生时间
	private Integer attachbilltimes; // 追单次数
	private String remark; // 备注
	private Staff staff; // 取派员

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getNoticebillId() {
		return noticebillId;
	}

	public void setNoticebillId(String noticebillId) {
		this.noticebillId = noticebillId == null ? null : noticebillId.trim();
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type == null ? null : type.trim();
	}

	public String getPickstate() {
		return pickstate;
	}

	public void setPickstate(String pickstate) {
		this.pickstate = pickstate == null ? null : pickstate.trim();
	}

	public Date getBuildtime() {
		return buildtime;
	}

	public void setBuildtime(Date buildtime) {
		this.buildtime = buildtime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark == null ? null : remark.trim();
	}

	public Integer getAttachbilltimes() {
		return attachbilltimes;
	}

	public void setAttachbilltimes(Integer attachbilltimes) {
		this.attachbilltimes = attachbilltimes;
	}

	public Staff getStaff() {
		return staff;
	}

	public void setStaff(Staff staff) {
		this.staff = staff;
	}
}