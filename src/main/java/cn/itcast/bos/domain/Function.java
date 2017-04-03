package cn.itcast.bos.domain;


import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

public class Function {
	@Override
	public String toString() {
		return "Function [id=" + id + ", name=" + name + "]";
	}

	private String id;

	private String name;

	private String description;

	private String page;

	private String generatemenu;

	private Long zindex;

	@JsonProperty(value = "_parentId")
	private String pid;

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


	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description == null ? null : description.trim();
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page == null ? null : page.trim();
	}


	public String getGeneratemenu() {
		return generatemenu;
	}

	public void setGeneratemenu(String generatemenu) {
		this.generatemenu = generatemenu == null ? null : generatemenu.trim();
	}


	public Long getZindex() {
		return zindex;
	}

	public void setZindex(Long zindex) {
		this.zindex = zindex;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid == null ? null : pid.trim();
	}
}