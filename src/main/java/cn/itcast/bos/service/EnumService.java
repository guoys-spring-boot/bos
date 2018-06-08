package cn.itcast.bos.service;

import cn.itcast.bos.domain.EnumBean;

import java.util.List;
import java.util.Map;

/**
 * Created by gys on 2017/4/3.
 */
public interface EnumService {

    Map<String, String> getEnum(String enumType);

    List<EnumBean> listEnum(String enumType);
}
