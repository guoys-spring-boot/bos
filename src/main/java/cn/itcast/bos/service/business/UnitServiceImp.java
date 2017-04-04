package cn.itcast.bos.service.business;

import cn.itcast.bos.dao.business.UnitDao;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.utils.MD5Utils;
import cn.itcast.bos.utils.UUIDUtils;
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
        bean.setId(UUIDUtils.generatePrimaryKey());
        bean.setPassword(MD5Utils.md5(bean.getPassword()));
        unitDao.insert(bean);
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
        unitDao.update(bean);
    }

}
