package cn.itcast.bos.service.business.impl;

import cn.itcast.bos.dao.business.AdminHomeDao;
import cn.itcast.bos.domain.echars.CommonModel;
import cn.itcast.bos.service.business.AdminHomeService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by gys on 2018/5/31.
 */

@Service
public class AdminHomeServiceImpl implements AdminHomeService {

    private AdminHomeDao adminHomeDao;
    public AdminHomeServiceImpl(AdminHomeDao dao){
        this.adminHomeDao = dao;
    }

    @Override
    public List<CommonModel> unitSubmitBar(String year) {
        return adminHomeDao.unitSubmitBar(year);
    }

    @Override
    public List<CommonModel> unitLevelSubmitPie(String year) {
        return adminHomeDao.unitLevelSubmitPie(year);
    }

    @Override
    public int privateUnitCount() {
        return adminHomeDao.privateUnitCount();
    }
}
