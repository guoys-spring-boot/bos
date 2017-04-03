package cn.itcast.bos.domain;

/**
 * 区域信息
 * 
 * @author seawind
 * 
 */
public class Region {
	private String id; // 　区域编号 （有意义的） ---- 手动指定
	private String province; // 省
	private String city; // 市
	private String district; // 区域
	private String postcode; // 邮编
	private String shortcode; // 简码
	private String citycode; // 城市编码

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province == null ? null : province.trim();
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city == null ? null : city.trim();
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district == null ? null : district.trim();
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode == null ? null : postcode.trim();
	}

	public String getShortcode() {
		return shortcode;
	}

	public void setShortcode(String shortcode) {
		this.shortcode = shortcode == null ? null : shortcode.trim();
	}

	public String getCitycode() {
		return citycode;
	}

	public void setCitycode(String citycode) {
		this.citycode = citycode == null ? null : citycode.trim();
	}

	public String getName() {
		return province + "," + city + "," + district;
	}
}