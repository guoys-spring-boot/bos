package cn.itcast.bos.page;

import java.util.List;
import java.util.Map;


/**
 * 分页 实体类 （封装分页请求和结果数据）
 * 
 * @author seawind
 * 
 */
public class PaginationInfo<T> {
	/** 请求参数 */
	private int pagesize; // 每页记录条数
	private int pageno; // 页码

	private Map<String, Object> condition; // 通用条件对象

	/** 结果数据 */
	private int total; // 总记录数
	private List<T> rows; // 当前页显示数据

	//@JsonIgnore
	public int getPagesize() {
		return pagesize;
	}

	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}

	//@JsonIgnore
	public int getPageno() {
		return pageno;
	}

	public void setPageno(int pageno) {
		this.pageno = pageno;
	}

	//@JsonIgnore
	public Map<String, Object> getCondition() {
		return condition;
	}

	public void setCondition(Map<String, Object> condition) {
		this.condition = condition;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	// 计算 first 和 last
	//@JsonIgnore
	public int getFirst() {
		return (pageno - 1) * pagesize;
	}

	//@JsonIgnore
	public int getLast() {
		return pageno * pagesize;
	}
}
