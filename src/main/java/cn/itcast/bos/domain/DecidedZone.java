package cn.itcast.bos.domain;

/**
 * 定区数据
 * 
 * @author seawind
 * 
 */
public class DecidedZone {
	private String id; // 定区编号

	private String name; // 定区名称

	private Staff staff; // 负责定区取派员

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name == null ? null : name.trim();
	}

	public Staff getStaff() {
		return staff;
	}

	public void setStaff(Staff staff) {
		this.staff = staff;
	}

}