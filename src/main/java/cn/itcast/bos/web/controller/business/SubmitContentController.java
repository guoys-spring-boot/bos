package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.common.SessionHelpler;
import cn.itcast.bos.domain.business.*;
import cn.itcast.bos.domain.business.vo.MyReportVO;
import cn.itcast.bos.service.business.AttachmentService;
import cn.itcast.bos.service.business.SubmitContentService;
import cn.itcast.bos.utils.FileUtils;
import cn.itcast.bos.utils.UUIDUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

import static cn.itcast.bos.common.SessionHelpler.resolveYear;

/**
 * Created by gys on 2017/4/9.
 */

@Controller
@RequestMapping("/submitContent")
public class SubmitContentController {

    public SubmitContentController(SubmitContentService submitContentService, AttachmentService attachmentService){
        this.submitContentService = submitContentService;
        this.attachmentService = attachmentService;
    }
    private AttachmentService attachmentService;
    private SubmitContentService submitContentService;


    @ResponseBody
    @RequestMapping("/listAssessmentType")
    public Object listAssessmentType(String unitId, HttpServletRequest request){
        if(unitId == null || "".equals(unitId)){
            UnitBean unit = SessionHelpler.resolveUnit(request.getSession());
            unitId = unit.getId();
        }
        return submitContentService.listAssessmentTypeByUnitId(unitId);
    }


    @RequestMapping("/addSubmitContent")
    public String addSubmitContent(SubmitContent content, @RequestParam("needInsert") String needInsert, HttpServletRequest request,
                                   Model model){

        UnitBean bean =  (UnitBean)request.getSession().getAttribute("user");
        content.setUnitId(bean.getId());
        String year = resolveYear(request.getSession());

        if(submitContentService.checkAlreadySubmit(content.getProject().getId(), null, bean.getId(), year)){
            throw new RuntimeException("该项目已经上报完成");
        }


        content.setYear(resolveYear(request.getSession()));
        submitContentService.save(content, needInsert);
        model.addAttribute("saveSuccess", true);
        return "forward:/submitContent/toAddSubmitContent";
    }

    @RequestMapping("/toAddSubmitContent")
    public String toAddSubmitContent(Model model){
        model.addAttribute("submitContent", new SubmitContent());
        model.addAttribute("action", "add");
        return "submit/submitindex";
    }

    @ResponseBody
    @RequestMapping("/listSubmitContent")
    public Object listSubmitContent(Integer page, Integer rows, HttpServletRequest request){
        UnitBean bean = (UnitBean)request.getSession().getAttribute("user");
        page = page == null ? 0 : page;
        rows = rows == null ? Integer.MAX_VALUE : rows;
        Page<Object> page1 = PageHelper.startPage(page, rows);
        Map<String, Object> result = new HashMap<String, Object>();

        String year = resolveYear(request.getSession());

        result.put("rows", submitContentService.listSubmitContent(bean.getId(), year));
        result.put("total", page1.getTotal());
        List<Map<String, Object>> footer = new ArrayList<Map<String, Object>>();
        Map<String, Object> content = new HashMap<String, Object>();
        content.put("score", submitContentService.getAlreadyScore(bean.getId(), year));
        content.put("projectName", "总分:");
        footer.add(content);
        result.put("footer", footer);
        return result;
    }

    @ResponseBody
    @RequestMapping("/listSubmitContentWithProject")
    public Object listSubmitContentWithProject(Integer page, Integer rows, HttpServletRequest request, MyReportVO vo){
        UnitBean bean = (UnitBean)request.getSession().getAttribute("user");
        page = page == null ? 0 : page;
        rows = rows == null ? Integer.MAX_VALUE : rows;
        Page<Object> page1 = PageHelper.startPage(page, rows);

        String year = resolveYear(request.getSession());

        Map<String, Object> result = new HashMap<String, Object>();
        if(vo.getUnitId() == null || vo.getUnitId().equals("")){
            vo.setUnitId(bean.getId());
        }

        vo.setYear(year);
        result.put("rows", submitContentService.listSubmitContentWithProject(vo));
        result.put("total", page1.getTotal());


        Map<String, Object> content = new HashMap<String, Object>();
        content.put("score", submitContentService.getAlreadyScore(bean.getId(), year));
        content.put("projectName", "总分:");


        //result.put("footer", footer);
        return result;
    }

    @RequestMapping("/toLookupSubmitContent")
    public String toLookupSubmitContent(String id, Model model){

        if(StringUtils.isBlank(id)){
            return "submit/submitindex";
        }

        model.addAttribute("disabled", true);
        model.addAttribute("action", "lookup");
        SubmitContent submitContent = submitContentService.findById(id);
        if(submitContent != null && submitContent.getContent() != null){
            submitContent.setContent(submitContent.getContent().replace("\n", "\\n"));
        }
        model.addAttribute("submitContent", submitContent);

        return "submit/submitindex";
    }

    @RequestMapping("/toEditSubmitContent")
    public String toEditSubmitContent(@RequestParam("id") String id, @RequestParam(value="saveSuccess",required=false)String saveSuccess  ,Model model){
        if(StringUtils.isBlank(id)){
            return "submit/submitindex";
        }

        if(saveSuccess != null && saveSuccess.toLowerCase().equals("true")){
            model.addAttribute("saveSuccess", true);
        }
        model.addAttribute("disabled", false);
        model.addAttribute("action", "edit");
        model.addAttribute("submitContent", submitContentService.findById(id));
        return "submit/submitindex";
    }

    @RequestMapping("/upload")
    @ResponseBody
    public Object uploadContent(MultipartFile file, HttpServletRequest request) throws IOException{
        Attachment attachment = new Attachment();
        String id = UUIDUtils.generatePrimaryKey();
        String actualName = id + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String rootpath = request.getSession().getServletContext().getRealPath("/");
        String path = FileUtils.generateDir("upload");

        File realFile = new File(rootpath + "/" + path + actualName);
        if(!realFile.exists()){
            if(!realFile.getParentFile().exists()){
                realFile.getParentFile().mkdirs();
            }
            realFile.createNewFile();
        }
        FileOutputStream outputStream = new FileOutputStream(realFile);
        outputStream.write(file.getBytes());
        outputStream.flush();
        outputStream.close();

        attachment.setId(id);
        attachment.setForeignKey(null);
        attachment.setName(file.getOriginalFilename());
        attachment.setUri(path + actualName);
        attachmentService.insert(attachment);
        return attachment;
    }

    @ResponseBody
    @RequestMapping("/listAttachment")
    public Object listAttachment(String foreignKey){

        HashMap<String, Object> result = new HashMap<String, Object>();
        result.put("total", 0);
        result.put("rows", attachmentService.findByForeignKey(foreignKey));
        return result;
    }

    @RequestMapping("/downloadAttachment")
    public void downloadAttachment(String id, HttpServletRequest request ,HttpServletResponse response) throws IOException{
        Attachment attachment = attachmentService.findById(id);
        if(attachment == null){
            throw new IOException("文件不存在");
        }
        String path = request.getServletContext().getRealPath("/") + "/" + attachment.getUri();
        InputStream inputStream = new FileInputStream(path);
        response.setHeader("conent-type", "application/octet-stream");
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=" + FileUtils.encodeDownloadFilename(attachment.getName(), request.getHeader("user-agent")));
        OutputStream os = response.getOutputStream();

        IOUtils.copy(inputStream, os);
        inputStream.close();
    }

    @RequestMapping("/updateSubmitContent")
    @ResponseBody
    public String updateSubmitContent(SubmitContent content, @RequestParam("needInsert") String needInsert,
                                    @RequestParam("needDelete")String needDelete, HttpServletRequest request){

        String year = resolveYear(request.getSession());

        UnitBean bean =  (UnitBean)request.getSession().getAttribute("user");
        if(submitContentService.checkAlreadyScored( content.getProject().getId(), content.getId(), bean.getId(), year)){
            throw new RuntimeException("该项目已经打分完成");
        }
        submitContentService.update(content, needInsert, needDelete);
        //model.addAttribute("saveSuccess", true);
        return "redirect:/submitContent/toEditSubmitContent?id=" + content.getId() + "&saveSuccess=true";
    }

    @RequestMapping("/checkAlreadySubmit")
    @ResponseBody
    public Object checkAlreadySubmit(@RequestParam(value = "contentId", required = false) String contentId, HttpSession session,
                                     @RequestParam(value = "projectId", required = false) String projectId){
        String unitId = ((UnitBean) session.getAttribute("user")).getId();
        String year = resolveYear(session);

        return submitContentService.checkAlreadySubmit(projectId, contentId, unitId, year);
    }

    @RequestMapping("/listScoreDetails")
    @ResponseBody
    public Object listScoreDetails(String contentId, HttpSession session){
        return submitContentService.listScoresByContentId(contentId, resolveYear(session));
    }
}
