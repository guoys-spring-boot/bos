package cn.itcast.bos.domain;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 工作单
 * 
 * @author seawind
 * 
 */
public class WorkOrderManage {
	private String id; // 编号
	private String arrivecity; // 到达城市
	private String product; // 货物
	private BigDecimal num; // 数量
	private Object weight; // 重量
	private String floadreqr; // 配置要求 （无、禁航，禁铁路）

	private String prodtimelimit;

	private String prodtype;

	private String sendername;

	private String senderphone;

	private String senderaddr;

	private String receivername;

	private String receiverphone;

	private String receiveraddr;

	private BigDecimal feeitemnum;

	private Object actlweit;

	private String vol;

	private String managercheck;

	private Date updatetime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
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

	public BigDecimal getNum() {
		return num;
	}

	public void setNum(BigDecimal num) {
		this.num = num;
	}

	public Object getWeight() {
		return weight;
	}

	public void setWeight(Object weight) {
		this.weight = weight;
	}

	public String getFloadreqr() {
		return floadreqr;
	}

	public void setFloadreqr(String floadreqr) {
		this.floadreqr = floadreqr == null ? null : floadreqr.trim();
	}

	public String getProdtimelimit() {
		return prodtimelimit;
	}

	public void setProdtimelimit(String prodtimelimit) {
		this.prodtimelimit = prodtimelimit == null ? null : prodtimelimit.trim();
	}

	public String getProdtype() {
		return prodtype;
	}

	public void setProdtype(String prodtype) {
		this.prodtype = prodtype == null ? null : prodtype.trim();
	}

	public String getSendername() {
		return sendername;
	}

	public void setSendername(String sendername) {
		this.sendername = sendername == null ? null : sendername.trim();
	}

	public String getSenderphone() {
		return senderphone;
	}

	public void setSenderphone(String senderphone) {
		this.senderphone = senderphone == null ? null : senderphone.trim();
	}

	public String getSenderaddr() {
		return senderaddr;
	}

	public void setSenderaddr(String senderaddr) {
		this.senderaddr = senderaddr == null ? null : senderaddr.trim();
	}

	public String getReceivername() {
		return receivername;
	}

	public void setReceivername(String receivername) {
		this.receivername = receivername == null ? null : receivername.trim();
	}

	public String getReceiverphone() {
		return receiverphone;
	}

	public void setReceiverphone(String receiverphone) {
		this.receiverphone = receiverphone == null ? null : receiverphone.trim();
	}

	public String getReceiveraddr() {
		return receiveraddr;
	}

	public void setReceiveraddr(String receiveraddr) {
		this.receiveraddr = receiveraddr == null ? null : receiveraddr.trim();
	}

	public BigDecimal getFeeitemnum() {
		return feeitemnum;
	}

	public void setFeeitemnum(BigDecimal feeitemnum) {
		this.feeitemnum = feeitemnum;
	}

	public Object getActlweit() {
		return actlweit;
	}

	public void setActlweit(Object actlweit) {
		this.actlweit = actlweit;
	}

	public String getVol() {
		return vol;
	}

	public void setVol(String vol) {
		this.vol = vol == null ? null : vol.trim();
	}

	public String getManagercheck() {
		return managercheck;
	}

	public void setManagercheck(String managercheck) {
		this.managercheck = managercheck == null ? null : managercheck.trim();
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
}