package cn.itcast.bos.dao;

import cn.itcast.bos.domain.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * Created by gys on 2017/4/3.
 */

@Mapper
public interface RoleDao extends BaseDAO<Role> {
    void insertRoleAndFunction(@Param("roleId") String roleId, @Param("functionId") String functionId);
}
