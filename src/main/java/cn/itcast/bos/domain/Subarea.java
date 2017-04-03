package cn.itcast.bos.domain;

/**
 * 分区
 * 
 * @author seawind
 * 
 */
public class Subarea {
	private String id; // 编号
	private String addresskey; // 关键字
	private String startnum; // 起始号
	private String endnum; // 结束号
	private String single; // 单双号
	private String position; // 位置信息

	// 属于定区
	private DecidedZone decidedZone;
	// 属于区域
	private Region region;

	public DecidedZone getDecidedZone() {
		return decidedZone;
	}

	public void setDecidedZone(DecidedZone decidedZone) {
		this.decidedZone = decidedZone;
	}

	public Region getRegion() {
		return region;
	}

	public void setRegion(Region region) {
		this.region = region;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getAddresskey() {
		return addresskey;
	}

	public void setAddresskey(String addresskey) {
		this.addresskey = addresskey == null ? null : addresskey.trim();
	}

	public String getStartnum() {
		return startnum;
	}

	public void setStartnum(String startnum) {
		this.startnum = startnum == null ? null : startnum.trim();
	}

	public String getEndnum() {
		return endnum;
	}

	public void setEndnum(String endnum) {
		this.endnum = endnum == null ? null : endnum.trim();
	}

	public String getSingle() {
		return single;
	}

	public void setSingle(String single) {
		this.single = single == null ? null : single.trim();
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position == null ? null : position.trim();
	}

	@Override
	public String toString() {
		return "Subarea [id=" + id + ", addresskey=" + addresskey + ", startnum=" + startnum + ", endnum=" + endnum + ", single=" + single + ", position=" + position + ", decidedZone=" + decidedZone + ", region=" + region + "]";
	}

	public String getSubareaId() {
		return id;
	}
}