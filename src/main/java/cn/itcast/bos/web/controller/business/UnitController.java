package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.UnitService;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by gys on 2017/4/3.
 */

@RequestMapping("/business")
@Controller
public class UnitController {


    private UnitService unitService;

    public UnitController(UnitService unitService){
        this.unitService = unitService;
    }

    @RequestMapping("/addUnit")
    public String addUnit(UnitBean unit, BindingResult result){

        if(result.hasErrors()){
            System.out.println("校验失败");
            return "admin/userinfo";
        }
        unitService.saveUnit(unit);
        return "admin/userlist";
    }

    @RequestMapping("/listUnit")
    @ResponseBody
    public Object listUnit(int page, int rows, UnitBean unitBean){
        Map<String, Object> result = new HashMap<String, Object>();
        PageHelper.startPage(page, rows);
        result.put("rows", unitService.listUnit(unitBean));
        result.put("total", unitService.countUnit(unitBean));
        return result;
    }

    @RequestMapping("/toAddUnit")
    public String toAddUnit(Model model){
        model.addAttribute("unit", new UnitBean());
        model.addAttribute("action", "add");
        return "admin/userinfo";
    }

    @RequestMapping("/toLookupUnit")
    public String toLookupUnit(String unitId, Model model){
        if(StringUtils.isBlank(unitId)){
            return "admin/userinfo";
        }
        UnitBean unitBean = unitService.findById(unitId);
        model.addAttribute("disabled", "true");
        model.addAttribute("unit", unitBean);
        model.addAttribute("action", "lookup");
        return "admin/userinfo";
    }

    @RequestMapping("/toUpdateUnit")
    public String toUpdateUnit(String unitId, Model model){
        if(StringUtils.isBlank(unitId)){
            return "admin/userinfo";
        }
        UnitBean unitBean = unitService.findById(unitId);
        model.addAttribute("disabled", "false");
        model.addAttribute("unit", unitBean);
        model.addAttribute("action", "update");
        return "admin/userinfo";
    }
    @RequestMapping("/updateUnit")
    public String updateUnit(UnitBean unitBean){
        if(unitBean == null || StringUtils.isBlank(unitBean.getId())){
            return "admin/userlist";
        }



        return "admin/userlist";
    }
}
