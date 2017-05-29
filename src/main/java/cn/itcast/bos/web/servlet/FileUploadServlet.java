package cn.itcast.bos.web.servlet;

import cn.itcast.bos.domain.business.Attachment;
import cn.itcast.bos.service.business.AttachmentService;
import cn.itcast.bos.utils.FileUtils;
import cn.itcast.bos.utils.UUIDUtils;
import com.baidu.ueditor.ActionEnter;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

/**
 * Created by gys on 2017/5/26.
 */

@WebServlet(name = "fileUploadServlet", urlPatterns = "/file/upload")
public class FileUploadServlet extends HttpServlet {

    private MultipartResolver multipartResolver;


    private AttachmentService attachmentService;

    public FileUploadServlet(AttachmentService attachmentService, MultipartResolver resolver){
        this.attachmentService = attachmentService;
        this.multipartResolver = resolver;
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/json;charset=utf-8");
        if(!multipartResolver.isMultipart(request)){
            response.getWriter().write("无效的访问");
            return;
        }
        MultipartHttpServletRequest multipart = multipartResolver.resolveMultipart(request);
        for (Map.Entry<String, MultipartFile> entry : multipart.getFileMap().entrySet()) {
            MultipartFile file = entry.getValue();
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
            ObjectMapper mapper = new ObjectMapper();
            response.getWriter().write(mapper.writeValueAsString(attachment));
        }

    }
}
