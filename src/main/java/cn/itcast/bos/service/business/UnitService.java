package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.business.UnitBean;

import java.util.List;

/**
 * Created by gys on 2017/4/3.
 */
public interface UnitService {

    void saveUnit(UnitBean bean);

    List<UnitBean> listUnit(UnitBean unitBean);

    int findTotalCount();

    int countUnit(UnitBean unitBean);

    UnitBean findById(String id);

    void update(UnitBean bean);
}
