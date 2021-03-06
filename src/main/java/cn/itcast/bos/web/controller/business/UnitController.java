package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.UnitService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
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
    public String addUnit(UnitBean unit, BindingResult result, HttpServletRequest request){

        if(result.hasErrors()){
            System.out.println("校验失败");
            return "admin/userinfo";
        }
        //UnitBean unitBean = (UnitBean) request.getSession().getAttribute("user");
        //unit.setParentUnitCode(unitBean.getId());
        unitService.saveUnit(unit);
        return "admin/userlist";
    }

    @RequestMapping("/resetPwd")
    @ResponseBody
    public void resetPwd(UnitBean unitBean){
        if(StringUtils.isNotEmpty(unitBean.getId())){
            unitService.updatePassword(unitBean.getId(), "123456");
        }
    }

    @RequestMapping("/listUnit")
    @ResponseBody
    public Object listUnit(int page, int rows, UnitBean unitBean){
        Map<String, Object> result = new HashMap<String, Object>();
        Page<Object> page1 = PageHelper.startPage(page, rows);
        result.put("rows", unitService.listUnit(unitBean));
        result.put("total", page1.getTotal());
        return result;
    }

    @RequestMapping("/toAddUnit")
    public String toAddUnit(Model model, HttpServletRequest request){
        UnitBean unitBean = (UnitBean) request.getSession().getAttribute("user");
        UnitBean toAdd = new UnitBean();
        model.addAttribute("unit", toAdd);
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
    public String updateUnit(UnitBean unitBean, @RequestParam(value="from", required = false) String from){
        if(unitBean == null || StringUtils.isBlank(unitBean.getId())){
            return "admin/userlist";
        }
        unitService.update(unitBean);
        if("index".equalsIgnoreCase(from)){
            return "forward:/business/toUpdateUnit?unitId="+unitBean.getId()+"&from=" + from;
        }else{
            return "common/close";
        }
    }

    @ResponseBody
    @RequestMapping("/deleteUnit")
    public void deleteUnit(String ids){
        unitService.deleteBatch(ids);
    }

    @RequestMapping("/updatePassword")
    @ResponseBody
    public Object updatePassword(@RequestParam("password") String password, HttpServletRequest request){
        Map<String, Object> result = new HashMap<String, Object>();
        try{
            UnitBean unitBean = (UnitBean) request.getSession().getAttribute("user");
            unitService.updatePassword(unitBean.getId(), password);
            result.put("success", true);
            result.put("msg", "修改密码成功！");
        }catch (Exception e){
            result.put("success", false);
            result.put("msg", "修改密码失败！");
        }

        return result;

    }

    @RequestMapping("/listAllParentUnit")
    @ResponseBody
    public Object listAllParentUnit(){
        List<UnitBean> allParentUnit = unitService.findAllParentUnit();
        List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
        for (UnitBean unitBean : allParentUnit) {
            Map<String, Object> result = new HashMap<String, Object>();
            result.put("id", unitBean.getId());
            result.put("text", unitBean.getUnitShortName());
            results.add(result);
        }

        return results;
    }
}
