package cn.itcast.bos.service.business;

import cn.itcast.bos.domain.echars.CommonModel;

import java.util.List;

/**
 * Created by gys on 2018/5/31.
 */
public interface AdminHomeService {

    List<CommonModel> unitSubmitBar(String year);


    List<CommonModel> unitLevelSubmitPie(String year);

    int privateUnitCount();
}
