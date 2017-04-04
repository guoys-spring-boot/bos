package cn.itcast.bos.service.impl;

import cn.itcast.bos.dao.EnumDao;
import cn.itcast.bos.domain.EnumBean;
import cn.itcast.bos.service.EnumService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by gys on 2017/4/3.
 */

@Service
public class EnumServiceImp implements EnumService {

    private EnumDao enumDao;

    public EnumServiceImp(EnumDao enumDao){
        this.enumDao = enumDao;
    }

    @Override
    public Map<String, String> getEnum(String enumType) {
        List<EnumBean> lists = enumDao.findByEnumType(enumType);
        Map<String, String> result = new HashMap<String, String>();
        for (EnumBean bean : lists) {
            result.put(bean.getEnumCode(), bean.getEnumText());
        }

        return result;
    }
}
