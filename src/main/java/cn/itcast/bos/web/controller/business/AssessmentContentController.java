package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.service.business.AssessmentContentService;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by gys on 2017/4/5.
 */

@Controller
@RequestMapping("/assessmentContent")
public class AssessmentContentController {

    private AssessmentContentService contentService;

    public AssessmentContentController(AssessmentContentService service){
        this.contentService = service;
    }

    @RequestMapping("/listContent")
    @ResponseBody
    public Object listContent(int page, int rows, String type){
        rows = rows <= 0 ? 10 : rows;
        page = page < 0 ? 0 : page;
        PageHelper.startPage(page, rows);
        List<AssessmentContent> list = contentService.list(type);
        int total = contentService.count(type);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("rows", list);
        result.put("total", total);
        return result;
    }

    @RequestMapping("/toAddContent")
    public String toAddContent(Model model){
        model.addAttribute("assessmentContent", new AssessmentContent());
        model.addAttribute("action", "add");
        return "assessment/contentinfo";
    }
}
