package cn.itcast.bos.domain;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class User {
	private String id;

	private String username;

	private String password;

	@NumberFormat(pattern = "###0.00")
	private BigDecimal salary;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthday;

	private String gender;

	private String station;

	private String telephone;

	private String remark;

	private List<Role> roles;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username == null ? null : username.trim();
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password == null ? null : password.trim();
	}

	public BigDecimal getSalary() {
		return salary;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", roles=" + roles + "]";
	}

	public void setSalary(BigDecimal salary) {
		this.salary = salary;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender == null ? null : gender.trim();
	}

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station == null ? null : station.trim();
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone == null ? null : telephone.trim();
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark == null ? null : remark.trim();
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
}