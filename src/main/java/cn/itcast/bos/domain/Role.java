package cn.itcast.bos.domain;

import java.util.List;

public class Role {
	private String id;

	@Override
	public String toString() {
		return "Role [id=" + id + ", name=" + name + ", functions=" + functions + "]";
	}

	private String name;

	private String description;

	private String homePage;

	private String homePageTitle;

	private List<Function> functions;

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

	public List<Function> getFunctions() {
		return functions;
	}

	public String getHomePage() {
		return homePage;
	}

	public void setHomePage(String homePage) {
		this.homePage = homePage;
	}

    public String getHomePageTitle() {
        return homePageTitle;
    }

    public void setHomePageTitle(String homePageTitle) {
        this.homePageTitle = homePageTitle;
    }

    public void setFunctions(List<Function> functions) {
		this.functions = functions;
	}
}