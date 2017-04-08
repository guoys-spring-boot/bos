package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.domain.business.AssessmentStd;
import cn.itcast.bos.service.business.AssessmentContentService;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
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

    @RequestMapping("/toUpdateContent")
    public String toUpdateContent(Model model, String contentId){

        if(StringUtils.isBlank(contentId)){
            return "assessment/contentinfo";
        }

        model.addAttribute("assessmentContent", contentService.findById(contentId));
        model.addAttribute("action", "update");
        model.addAttribute("disabled", false);

        return "assessment/contentinfo";
    }

    @RequestMapping("/updateContent")
    public String updateContent(AssessmentContent content){
        contentService.update(content);
        return "assessment/contentinfo";
    }

    @RequestMapping("/addContent")
    public void addContent(AssessmentContent content){
        contentService.save(content);
    }

    @RequestMapping("/toLookupContent")
    public String toLookupContent(Model model, String contentId){
        model.addAttribute("assessmentContent", contentService.findById(contentId));
        model.addAttribute("action", "lookup");
        model.addAttribute("disabled", true);
        return "assessment/contentinfo";
    }
    @RequestMapping("/deleteContent")
    @ResponseBody
    public void deleteContent(String ids){
        if(StringUtils.isBlank(ids)){
            return;
        }
        contentService.deleteBatch(ids);
    }

    @RequestMapping("/listContentStd")
    @ResponseBody
    public Object listContentStd(String contentId){
        return contentService.listStds(contentId);
    }
}
