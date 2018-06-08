package cn.itcast.bos.dao.business;

import cn.itcast.bos.domain.echars.CommonModel;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * Created by gys on 2018/5/31.
 */

@Mapper
public interface AdminHomeDao {

    List<CommonModel> unitSubmitBar(String year);

    List<CommonModel> unitLevelSubmitPie(String year);

    int privateUnitCount();
}
