package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.domain.business.AssessmentStd;
import cn.itcast.bos.domain.business.SubmitContent;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.EnumService;
import cn.itcast.bos.service.business.AssessmentContentService;
import cn.itcast.bos.service.business.SubmitContentService;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Created by gys on 2017/4/5.
 */

@Controller
@RequestMapping("/assessmentContent")
public class AssessmentContentController {

    private AssessmentContentService contentService;

    private SubmitContentService submitContentService;

    private EnumService enumService;

    public AssessmentContentController(AssessmentContentService service, EnumService enumService, SubmitContentService contentService){
        this.contentService = service;
        this.enumService = enumService;
        this.submitContentService = contentService;
    }

    @RequestMapping("/listContent")
    @ResponseBody
    public Object listContent(Integer page, Integer rows, String type){
        page = page == null ? 0 : page;
        rows = rows == null ? Integer.MAX_VALUE : rows;
        rows = rows <= 0 ? Integer.MAX_VALUE : rows;
        page = page < 0 ? 0 : page;
        PageHelper.startPage(page, rows);
        List<AssessmentContent> list = contentService.list(type);
        int total = contentService.count(type);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("rows", list);
        result.put("total", total);
        return result;
    }
    @RequestMapping("/listContentAsTree")
    @ResponseBody
    public Object listContentAsTree(String type){
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        List<AssessmentContent> list = contentService.list(type);
        Map<String, String> assessmentType = enumService.getEnum("assessmentType");
        Map<String, Object> currentType = null;
        for (AssessmentContent content : list) {
            if(currentType == null || !currentType.get("id").equals(content.getType())){
                currentType = new HashMap<String, Object>();
                currentType.put("id", content.getType());
                currentType.put("projectName", assessmentType.get(content.getType()));
                rows.add(currentType);
            }

            Map<String, Object> record = new HashMap<String, Object>();
            record.put("id", content.getId());
            record.put("projectName", content.getProjectName());
            record.put("type", content.getType());
            record.put("_parentId", content.getType());
            rows.add(record);

        }
        return rows;
    }

    @RequestMapping("/listContentAsTree2")
    @ResponseBody
    public Object listContentAsTree2(@RequestParam(value = "type", required = false) String type, HttpSession session){
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        List<AssessmentContent> list = contentService.list(type);
        Map<String, String> assessmentType = enumService.getEnum("assessmentType");
        UnitBean user = (UnitBean) session.getAttribute("user");
        List<SubmitContent> submitContents = submitContentService.listSubmitContent(user.getId());
        List<String> alreadySubmitAssess = new ArrayList<String>(submitContents.size());
        for (SubmitContent submitContent : submitContents) {
            if(submitContent.getProject() != null){
                alreadySubmitAssess.add(submitContent.getProject().getId());
            }

        }

        Map<String, Object> currentType = null;
        for (AssessmentContent content : list) {
            if(currentType == null || !currentType.get("id").equals(content.getType())){
                currentType = new LinkedHashMap<String, Object>();
                currentType.put("id", content.getType());
                currentType.put("projectName", assessmentType.get(content.getType()));
                List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
                currentType.put("children", children);
                rows.add(currentType);
            }

            Map<String, Object> record = new LinkedHashMap<String, Object>();
            record.put("id", content.getId());
            record.put("projectName", content.getProjectName());
            record.put("type", content.getType());
            record.put("_parentId", content.getType());
            record.put("alreadySubmit", alreadySubmitAssess.contains(content.getId()));
            ((List<Map<String, Object>>) currentType.get("children")).add(record);

        }
        return rows;
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
