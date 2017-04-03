package cn.itcast.bos.domain;

/**
 * 取派员 
 * @author seawind
 *
 */
public class Staff {
    private String id; // 编号
    private String name; // 姓名
    private String telephone; // 手机
    private String haspda; // 是否有pda 移动无线通讯设备 
    private String deltag = "0"; // 删除标记   1 已经作废 0 正常使用 
    private String station; // 单位
    private String standard; // 收派标准 

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

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone == null ? null : telephone.trim();
    }

    public String getHaspda() {
        return haspda;
    }

    public void setHaspda(String haspda) {
        this.haspda = haspda == null ? null : haspda.trim();
    }

    public String getDeltag() {
        return deltag;
    }

    public void setDeltag(String deltag) {
        this.deltag = deltag == null ? null : deltag.trim();
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station == null ? null : station.trim();
    }

    public String getStandard() {
        return standard;
    }

    public void setStandard(String standard) {
        this.standard = standard == null ? null : standard.trim();
    }

	@Override
	public String toString() {
		return "Staff [id=" + id + ", name=" + name + ", telephone="
				+ telephone + ", haspda=" + haspda + ", deltag=" + deltag
				+ ", station=" + station + ", standard=" + standard + "]";
	}
    
    
}