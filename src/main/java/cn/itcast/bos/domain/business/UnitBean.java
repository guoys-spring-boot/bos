package cn.itcast.bos.domain.business;

import cn.itcast.bos.domain.Role;

/**
 * Created by gys on 2017/4/3.
 */
public class UnitBean {

    private String id;

    /**
     * 上级单位
     */
    private String parentUnitCode;

    /**
     * 归属区域
     */
    private String ascriptionArea;

    /**
     * 机构代码
     */
    private String organizationCode;


    /**
     * 单位全称
     */
    private String unitFullName;

    /**
     * 单位简称
     */
    private String unitShortName;

    /**
     * 单位类型
     */
    private String unitType;

    /**
     * 单位性质
     */
    private String unitProperty;

    /**
     * 单位等级
     */
    private String unitLevel;

    /**
     * 单位人数
     */
    private int unitPersonCount;

    /**
     * 单位法人
     */
    private String legalEntity;

    /**
     * 单位法人电话
     */
    private String legalEntityTelNum;

    /**
     * 分管领导
     */
    private String leader;

    /**
     * 分管领导电话
     */
    private String leaderTelNum;

    /**
     * 单位联系人
     */
    private String unitContactPerson;

    /**
     * 单位联系人电话
     */
    private String unitContactPersonTelNum;

    /**
     * 单位联系人qq
     */
    private String contactQQ;

    /**
     * 单位联系人email
     */
    private String contactEmail;

    /**
     * 用户名
     */
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * 审核状态
     */
    private String auditingStatus;

    /**
     * 是否区域管理
     */
    private String isAdmin;

    private String unitAddress;

    private Role role;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getParentUnitCode() {
        return parentUnitCode;
    }

    public void setParentUnitCode(String parentUnitCode) {
        this.parentUnitCode = parentUnitCode;
    }

    public String getAscriptionArea() {
        return ascriptionArea;
    }

    public void setAscriptionArea(String ascriptionArea) {
        this.ascriptionArea = ascriptionArea;
    }

    public String getOrganizationCode() {
        return organizationCode;
    }

    public void setOrganizationCode(String organizationCode) {
        this.organizationCode = organizationCode;
    }

    public String getUnitFullName() {
        return unitFullName;
    }

    public void setUnitFullName(String unitFullName) {
        this.unitFullName = unitFullName;
    }

    public String getUnitShortName() {
        return unitShortName;
    }

    public void setUnitShortName(String unitShortName) {
        this.unitShortName = unitShortName;
    }

    public String getUnitType() {
        return unitType;
    }

    public void setUnitType(String unitType) {
        this.unitType = unitType;
    }

    public String getUnitProperty() {
        return unitProperty;
    }

    public void setUnitProperty(String unitProperty) {
        this.unitProperty = unitProperty;
    }

    public String getUnitLevel() {
        return unitLevel;
    }

    public void setUnitLevel(String unitLevel) {
        this.unitLevel = unitLevel;
    }

    public int getUnitPersonCount() {
        return unitPersonCount;
    }

    public void setUnitPersonCount(int unitPersonCount) {
        this.unitPersonCount = unitPersonCount;
    }

    public String getLegalEntity() {
        return legalEntity;
    }

    public void setLegalEntity(String legalEntity) {
        this.legalEntity = legalEntity;
    }

    public String getLegalEntityTelNum() {
        return legalEntityTelNum;
    }

    public void setLegalEntityTelNum(String legalEntityTelNum) {
        this.legalEntityTelNum = legalEntityTelNum;
    }

    public String getLeader() {
        return leader;
    }

    public void setLeader(String leader) {
        this.leader = leader;
    }

    public String getLeaderTelNum() {
        return leaderTelNum;
    }

    public void setLeaderTelNum(String leaderTelNum) {
        this.leaderTelNum = leaderTelNum;
    }

    public String getUnitContactPerson() {
        return unitContactPerson;
    }

    public void setUnitContactPerson(String unitContactPerson) {
        this.unitContactPerson = unitContactPerson;
    }

    public String getUnitContactPersonTelNum() {
        return unitContactPersonTelNum;
    }

    public void setUnitContactPersonTelNum(String unitContactPersonTelNum) {
        this.unitContactPersonTelNum = unitContactPersonTelNum;
    }

    public String getContactQQ() {
        return contactQQ;
    }

    public void setContactQQ(String contactQQ) {
        this.contactQQ = contactQQ;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAuditingStatus() {
        return auditingStatus;
    }

    public void setAuditingStatus(String auditingStatus) {
        this.auditingStatus = auditingStatus;
    }

    public String getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(String isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getUnitAddress() {
        return unitAddress;
    }

    public void setUnitAddress(String unitAddress) {
        this.unitAddress = unitAddress;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    /**
     *  考核内容是否需要打分
     * @return true or false
     */
    public boolean needSubmit(){
        return "1".equals(this.getUnitLevel()) || "2".equals(this.getUnitLevel());
    }

    @Override
    public String toString() {
        return "UnitBean{" +
                "id='" + id + '\'' +
                ", parentUnitCode='" + parentUnitCode + '\'' +
                ", ascriptionArea='" + ascriptionArea + '\'' +
                ", organizationCode='" + organizationCode + '\'' +
                ", unitFullName='" + unitFullName + '\'' +
                ", unitShortName='" + unitShortName + '\'' +
                ", unitType='" + unitType + '\'' +
                ", unitProperty='" + unitProperty + '\'' +
                ", unitLevel='" + unitLevel + '\'' +
                ", unitPersonCount=" + unitPersonCount +
                ", legalEntity='" + legalEntity + '\'' +
                ", legalEntityTelNum='" + legalEntityTelNum + '\'' +
                ", leader='" + leader + '\'' +
                ", leaderTelNum='" + leaderTelNum + '\'' +
                ", unitContactPerson='" + unitContactPerson + '\'' +
                ", unitContactPersonTelNum='" + unitContactPersonTelNum + '\'' +
                ", contactQQ='" + contactQQ + '\'' +
                ", contactEmail='" + contactEmail + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", auditingStatus='" + auditingStatus + '\'' +
                ", isAdmin='" + isAdmin + '\'' +
                ", unitAddress='" + unitAddress + '\'' +
                '}';
    }
}
