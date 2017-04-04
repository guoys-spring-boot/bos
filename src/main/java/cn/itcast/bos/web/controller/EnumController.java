package cn.itcast.bos.web.controller;

import cn.itcast.bos.service.EnumService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

/**
 * Created by gys on 2017/4/3.
 */

@RequestMapping("/base")
@Controller
public class EnumController {

    private EnumService enumService;

    public EnumController(EnumService enumService){
        this.enumService = enumService;
    }

    @RequestMapping("/loadEnum")
    @ResponseBody
    public Object loadEnum(String id){
        if(id == null){
            return new HashMap<String, String>();
        }
        return enumService.getEnum(id);
    }
}
