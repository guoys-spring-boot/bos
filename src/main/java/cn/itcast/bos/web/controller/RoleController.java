package cn.itcast.bos.web.controller;

import cn.itcast.bos.domain.Role;
import cn.itcast.bos.service.RoleService;
import cn.itcast.bos.service.UserService;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by gys on 2017/4/3.
 */

@Controller
public class RoleController {

    private RoleService roleService;

    public RoleController(RoleService roleService){
        this.roleService = roleService;
    }

    @RequestMapping("/role_list")
    @ResponseBody
    public Object listRole(){
        Map<String, Object> result = new HashMap<String, Object>();
        List<Role> roles = roleService.listRole();
        result.put("total", roles.size());
        result.put("rows", roles);
        return result;
    }

    @RequestMapping("/role_save")
    public String saveRole(Role role, String functionIds){
        roleService.saveRole(role, functionIds);
        return "admin/role";
    }

    @RequestMapping("/listRoleAsEnum")
    @ResponseBody
    public Object listRoleAsEnum(){
        List<Map<String, String>> result = new ArrayList<Map<String, String>>();
        List<Role> roles = roleService.listRole();
        for (Role role : roles) {
            Map<String, String> map = new HashMap<String, String>();
            map.put("id", role.getId());
            map.put("text", role.getName());
            result.add(map);
        }

        return result;
    }
}
