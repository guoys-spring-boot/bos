package cn.itcast.bos.service;

import cn.itcast.bos.domain.Role;

import java.util.List;

/**
 * Created by gys on 2017/4/3.
 */
public interface RoleService {

    List<Role> listRole();

    void saveRole(Role role, String functionIds);
}
