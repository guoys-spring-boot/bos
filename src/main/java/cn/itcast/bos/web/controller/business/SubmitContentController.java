package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.Attachment;
import cn.itcast.bos.domain.business.SubmitContent;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.AttachmentService;
import cn.itcast.bos.service.business.SubmitContentService;
import cn.itcast.bos.utils.FileUtils;
import cn.itcast.bos.utils.UUIDUtils;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

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
}
