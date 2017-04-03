package cn.itcast.crm.service;

import java.util.List;

import cn.itcast.crm.domain.Customer;

public interface CustomerService {
	/**
	 * 查询没有关联定区的客户
	 * 
	 * @return
	 */
	public List<Customer> findNoAssociationCustomers();

	/**
	 * 查询已经关联到定区的客户
	 * 
	 * @param decidedZoneId
	 * @return
	 */
	public List<Customer> findHasAssociationCustomers(String decidedZoneId);

	/**
	 * 将这些客户关联 定区上
	 * 
	 * @param customerIds
	 * @param decidedZoneId
	 */
	public void assignCustomersToDecidedZone(String[] customerIds, String decidedZoneId);

	/**
	 * 根据地址匹配 定区
	 * 
	 * @param address
	 * @return
	 */
	public String findDecidedZoneIdByAddress(String address);

}
