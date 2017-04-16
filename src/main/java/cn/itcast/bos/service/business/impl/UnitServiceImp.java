package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.UnitDao;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.UnitService;
import cn.itcast.bos.utils.MD5Utils;
import cn.itcast.bos.utils.UUIDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/4/3.
 */

@Service
@Transactional
public class UnitServiceImp implements UnitService {

    private UnitDao unitDao;

    public UnitServiceImp(UnitDao unitDao) {
        this.unitDao = unitDao;
    }

    @Override
    public void saveUnit(UnitBean bean) {

        if(StringUtils.isBlank(bean.getUsername())){
            throw new RuntimeException("用户名不能为空");
        }
        if(this.findByUsername(bean.getUsername()) != null){
            throw new RuntimeException("用户名已存在");
        }

        bean.setId(UUIDUtils.generatePrimaryKey());
        bean.setPassword(MD5Utils.md5(bean.getPassword()));
        unitDao.insert(bean);

        if(bean.getRole() != null && StringUtils.isNotBlank(bean.getRole().getId())){
            unitDao.saveUnitRole(bean.getId(), bean.getRole().getId());
        }
    }

    @Override
    public List<UnitBean> listUnit(UnitBean bean) {
        return unitDao.findUnitByCondition(bean);
    }

    @Override
    public int findTotalCount() {
        return unitDao.findTotalCount();
    }

    @Override
    public int countUnit(UnitBean unitBean) {
        return unitDao.totalCountByCondition(unitBean);
    }

    @Override
    public UnitBean findById(String id){
        UnitBean unitBean = unitDao.findById(id);
        if(unitBean == null){
            unitBean = new UnitBean();
        }
        return unitBean;
    }

    @Override
    public void update(UnitBean bean){

        UnitBean _bean = this.findByUsername(bean.getUsername());

        if(StringUtils.isNotBlank(bean.getUsername()) && _bean != null && !bean.getId().equals(_bean.getId())){
            throw new RuntimeException("username already existed");
        }
        unitDao.deleteRoleByUnitId(bean.getId());
        unitDao.update(bean);
        if(bean.getRole() != null && StringUtils.isNotBlank(bean.getRole().getId())){
            unitDao.saveUnitRole(bean.getId(), bean.getRole().getId());
        }

    }

    @Override
    public void deleteBatch(String ids) {
        if(StringUtils.isBlank(ids)){
            return;
        }

        for (String s : ids.split(",")) {
            UnitBean bean = new UnitBean();
            bean.setId(s);
            unitDao.delete(bean);
        }

    }

    @Override
    public UnitBean findByUsername(String username) {
        if(StringUtils.isBlank(username)){
            return null;
        }
        return unitDao.findByUserName(username);
    }

    @Override
    public void updatePassword(String unitId, String password) {
        unitDao.updatePassword(unitId, MD5Utils.md5(password));
    }
}
