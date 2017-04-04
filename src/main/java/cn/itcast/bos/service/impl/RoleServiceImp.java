package cn.itcast.bos.service.impl;

import cn.itcast.bos.dao.RoleDao;
import cn.itcast.bos.domain.Role;
import cn.itcast.bos.service.RoleService;
import cn.itcast.bos.utils.UUIDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by gys on 2017/4/3.
 */

@Service
@Transactional
public class RoleServiceImp implements RoleService {

    public RoleServiceImp(RoleDao roleDao){
        this.roleDao = roleDao;
    }

    private RoleDao roleDao;

    @Override
    public List<Role> listRole() {
        return roleDao.findAll();
    }

    @Override
    public void saveRole(Role role, String functionIds) {
        String roleId = UUIDUtils.generatePrimaryKey();
        role.setId(roleId);
        roleDao.insert(role);

        if(StringUtils.isNotBlank(functionIds)){
            for (String s : functionIds.split(",")) {
                roleDao.insertRoleAndFunction(roleId, s);
            }
        }
    }
}
