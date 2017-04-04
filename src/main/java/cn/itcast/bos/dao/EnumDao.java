package cn.itcast.bos.dao;

import cn.itcast.bos.domain.EnumBean;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by gys on 2017/4/3.
 */

@Mapper
public interface EnumDao {

    List<EnumBean> findByEnumType(@Param("enumType") String type);
}
