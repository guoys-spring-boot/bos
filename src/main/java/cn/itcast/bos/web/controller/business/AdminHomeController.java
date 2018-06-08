package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.common.SessionHelpler;
import cn.itcast.bos.service.business.AdminHomeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by gys on 2018/5/31.
 */

@Controller
@RequestMapping("/admin2")
public class AdminHomeController {

    private AdminHomeService adminHomeService;
    public AdminHomeController(AdminHomeService adminHomeService){
        this.adminHomeService = adminHomeService;
    }



    @RequestMapping("/unitSubmitBar.do")
    @ResponseBody
    public Object unitSubmitBar(HttpServletRequest request){
        return adminHomeService.unitSubmitBar(SessionHelpler.resolveYear(request.getSession()));
    }

    @RequestMapping("/unitLevelSubmitPie.do")
    @ResponseBody
    public Object unitLevelSubmitPie(HttpServletRequest request){
        return adminHomeService.unitLevelSubmitPie(SessionHelpler.resolveYear(request.getSession()));
    }

    @RequestMapping("/privateUnitCount.do")
    @ResponseBody
    public int privateUnitCount(){
        return adminHomeService.privateUnitCount();
    }




}
