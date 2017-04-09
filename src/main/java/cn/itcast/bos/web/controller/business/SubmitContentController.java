package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.SubmitContent;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.SubmitContentService;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by gys on 2017/4/9.
 */

@Controller
@RequestMapping("/submitContent")
public class SubmitContentController {

    public SubmitContentController(SubmitContentService submitContentService){
        this.submitContentService = submitContentService;
    }

    private SubmitContentService submitContentService;

    @RequestMapping("/addSubmitContent")
    @ResponseBody
    public void addSubmitContent(SubmitContent content, HttpServletRequest request){

        UnitBean bean =  (UnitBean)request.getSession().getAttribute("user");
        content.setUnitId(bean.getId());
        submitContentService.save(content);
    }

    @RequestMapping("/toAddSubmitContent")
    public String toAddSubmitContent(Model model){
        model.addAttribute("submitContent", new SubmitContent());
        return "submit/submitindex";
    }

    @ResponseBody
    @RequestMapping("/listSubmitContent")
    public Object listSubmitContent(Integer page, Integer rows, HttpServletRequest request){
        UnitBean bean = (UnitBean)request.getSession().getAttribute("user");
        page = page == null ? 0 : page;
        rows = rows == null ? Integer.MAX_VALUE : rows;
        PageHelper.startPage(page, rows);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("total", 10);
        result.put("rows", submitContentService.listSubmitContent(bean.getId()));
        return result;
    }

    @RequestMapping("/toLookupSubmitContent")
    public String toLookupSubmitContent(String id, Model model){
        if(StringUtils.isBlank(id)){
            return "submit/submitindex";
        }
        model.addAttribute("disabled", true);
        model.addAttribute("submitContent", submitContentService.findById(id));
        return "submit/submitindex";
    }
}
