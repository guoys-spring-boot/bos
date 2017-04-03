package cn.itcast.bos.domain;

import java.util.Date;

/**
 * 业务通知单
 * 
 * @author seawind
 * 
 */
public class NoticeBill {
	private String id; // 通知单编号
	private String customerId; // 客户编号
	private String customerName;// 客户姓名
	private String delegater; // 联系人
	private String telephone; // 电话
	private String pickaddress; // 取件地址
	private String arrivecity; // 到达城市
	private String product; // 货物
	private Date pickdate; // 取件日期
	private Integer num; // 数量
	private Double weight; // 重量
	private String volume; // 体积
	private String remark; // 备注
	private String ordertype; // 分单类型 （人工、自动）
	private String staffId; // 分单后取派员编号
	private String userId; // 受理人 （当前登录系统用户）

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId == null ? null : customerId.trim();
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName == null ? null : customerName.trim();
	}

	public String getDelegater() {
		return delegater;
	}

	public void setDelegater(String delegater) {
		this.delegater = delegater == null ? null : delegater.trim();
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone == null ? null : telephone.trim();
	}

	public String getPickaddress() {
		return pickaddress;
	}

	public void setPickaddress(String pickaddress) {
		this.pickaddress = pickaddress == null ? null : pickaddress.trim();
	}

	public String getArrivecity() {
		return arrivecity;
	}

	public void setArrivecity(String arrivecity) {
		this.arrivecity = arrivecity == null ? null : arrivecity.trim();
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product == null ? null : product.trim();
	}

	public Date getPickdate() {
		return pickdate;
	}

	public void setPickdate(Date pickdate) {
		this.pickdate = pickdate;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume == null ? null : volume.trim();
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark == null ? null : remark.trim();
	}

	public String getOrdertype() {
		return ordertype;
	}

	public void setOrdertype(String ordertype) {
		this.ordertype = ordertype == null ? null : ordertype.trim();
	}

	public String getStaffId() {
		return staffId;
	}

	public void setStaffId(String staffId) {
		this.staffId = staffId == null ? null : staffId.trim();
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId == null ? null : userId.trim();
	}
}