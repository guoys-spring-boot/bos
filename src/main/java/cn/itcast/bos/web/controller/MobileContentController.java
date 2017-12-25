package cn.itcast.bos.web.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.itcast.bos.domain.business.AssessmentContent;
import cn.itcast.bos.domain.business.AssessmentStd;
import cn.itcast.bos.domain.business.SubmitContent;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.EnumService;
import cn.itcast.bos.service.business.AssessmentContentService;
import cn.itcast.bos.service.business.AttachmentService;
import cn.itcast.bos.service.business.ScoreService;
import cn.itcast.bos.service.business.SubmitContentService;
import cn.itcast.bos.service.business.UnitService;

@Controller
@RequestMapping("/mobile/content")
public class MobileContentController {

	@Autowired
	private UnitService unitService;
	@Autowired
	private AssessmentContentService assessmentContentService;
	@Autowired
	private ScoreService scoreService;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private SubmitContentService submitContentService;
	@Autowired
	private EnumService enumService;
	
	File tempFile;  
	private Logger logger = Logger.getLogger(MobileContentController.class);  
	@RequestMapping("/count")
	@ResponseBody
	//统计单位完成量
	public Map<String, Object> count(String sessionKey, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		//1,根据用户sessionKey查询当前单位信息
		UnitBean bean = unitService.findBySessionKey(sessionKey);
		if(bean == null){
			result.put("statu", "0");
			return result;
		}
		result.put("statu", "1");
		//2，根据单位信息查询出相关的数据
		int ywc_count = submitContentService.getYwcCount(bean.getId());//scoreService.getYwcCount(bean.getId());
		result.put("ywc_count", ywc_count);//已完成数量
		
		int wwc_count = 46;
		//int ysb_count = submitContentService.getYwcCount(bean.getId());
		if(ywc_count >= 0){
			wwc_count -= ywc_count;
		}
		result.put("wwc_count", wwc_count);//未完成数量
		Double score = scoreService.getScore(bean.getId());
		result.put("score", score);//总得分
		return result;
	}
	
	@RequestMapping("/getWwcList")
	@ResponseBody
	//获取未完成列表
	public List<AssessmentContent> getWwcList(String sessionKey, HttpServletRequest request){
		//1,根据用户sessionKey查询当前单位信息
		UnitBean bean = unitService.findBySessionKey(sessionKey);
		if(bean == null){
			return null;
		}
		List<AssessmentContent> list = assessmentContentService.getWwcList(bean.getId());
		Map<String, String> enumMap = enumService.getEnum("assessmentType");
		for(int i = list.size()-1; i>=0;i--){
			AssessmentContent contentItem = list.get(i);
			if(contentItem.getProjectName().length() < 30){
				list.get(i).setProjectName(i+1+","+contentItem.getProjectName());
			}else{
				list.get(i).setProjectName(i+1+","+contentItem.getProjectName().substring(0, 30)+"...");
			}
			
			list.get(i).setType(enumMap.get(contentItem.getType()));
		}
		return list;
	}
	
	@RequestMapping("/getYwcList")
	@ResponseBody
	//获取未完成列表
	public List<AssessmentContent> getYwcList(String sessionKey, HttpServletRequest request){
		//1,根据用户sessionKey查询当前单位信息
		UnitBean bean = unitService.findBySessionKey(sessionKey);
		if(bean == null){
			return null;
		}
		List<AssessmentContent> list = assessmentContentService.getYwcList(bean.getId());
		Map<String, String> enumMap = enumService.getEnum("assessmentType");
		for(int i = list.size()-1; i>=0;i--){
			AssessmentContent contentItem = list.get(i);
			if(contentItem.getProjectName().length() < 30){
				list.get(i).setProjectName(i+1+","+contentItem.getProjectName());
			}else{
				list.get(i).setProjectName(i+1+","+contentItem.getProjectName().substring(0, 30)+"...");
			}
			
			list.get(i).setType(enumMap.get(contentItem.getType()));
		}
		return list;
	}
	
	/**
	 * 获取考核项目
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/getKhObj")
	@ResponseBody
	public AssessmentContent getKhObj(String id, HttpServletRequest request){
		AssessmentContent assessmentContent = assessmentContentService.findById(id);
//		List<AssessmentStd> assessmentStdList = new ArrayList<AssessmentStd>();
		List<AssessmentStd> assessmentStdLst = assessmentContentService.listStds(assessmentContent.getId());
		/*for(AssessmentStd assessmentStd : assessmentStdLst){
			AssessmentStd assessmentStdItem = new AssessmentStd();
			assessmentStdItem.setItem(assessmentStd.getItem());
			assessmentStdItem.setRemark(assessmentStd.getRemark());
			assessmentStdList.add(assessmentStdItem);
		}*/
		assessmentContent.setAssessmentStdList(assessmentStdLst);
		return assessmentContent;
	}
	
	
	/**
	 * 获取考核项目
	 * @param id
	 * @param request
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value="/uploadImg")
	@ResponseBody
	public String uploadImg(HttpServletRequest request, @RequestParam(value = "file", required = false) MultipartFile file, String sessionKey, HttpServletResponse response) throws IOException{
        try {
            request.setCharacterEncoding("UTF-8"); 
            //1、创建一个DiskFileItemFactory工厂  
            DiskFileItemFactory factory = new DiskFileItemFactory();  
            //2、创建一个文件上传解析器  
            ServletFileUpload upload = new ServletFileUpload(factory);
            //解决上传文件名的中文乱码  
            upload.setHeaderEncoding("UTF-8");   
            // 1. 得到 FileItem 的集合 items  
            List<FileItem> items = upload.parseRequest(request);
            logger.info("图片集合"+items.size());
            // 2. 遍历 items:  
            for (FileItem item : items) {  
                String name = item.getFieldName();  
                logger.info("fieldName:"+name);
            }
        }catch(Exception e){
        	e.printStackTrace();
        }
        return "";
//		System.out.println("执行upload");  
//        request.setCharacterEncoding("UTF-8");  
//        logger.info("执行图片上传");  
//        //UnitBean bean = unitService.findBySessionKey(sessionKey);
//        logger.info("sessionKey:"+sessionKey);  
//        Attachment attachment = new Attachment();
//        if(!file.isEmpty()) {  
//            logger.info("成功获取照片");  
//            String id = UUIDUtils.generatePrimaryKey();
//            String actualName = id + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
//            String rootpath = request.getSession().getServletContext().getRealPath("/");
//            String path = FileUtils.generateDir("upload");
//
//            File realFile = new File(rootpath + "/" + path + actualName);
//            if(!realFile.exists()){
//                if(!realFile.getParentFile().exists()){
//                    realFile.getParentFile().mkdirs();
//                }
//                realFile.createNewFile();
//            }
//            FileOutputStream outputStream = new FileOutputStream(realFile);
//            outputStream.write(file.getBytes());
//            outputStream.flush();
//            outputStream.close();
//            
//            attachment.setId(id);
//            attachment.setForeignKey(null);
//            attachment.setName(file.getOriginalFilename());
//            attachment.setUri(path + actualName);
//            attachmentService.insert(attachment);
//            logger.info("附件上传完成");
//        }else {  
//            logger.info("没有找到相对应的文件");  
//            return "error";  
//        }  
//	
//        return attachment.getUri();
	}
	
	/**
	 * 
	 * @param id
	 * @param text
	 * @param imgs
	 * @param sessionKey
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/subContent")
	@ResponseBody
	public Map<String, String> subContent(String id, String text, String[] imgs, String sessionKey, HttpServletRequest request){
		Map<String, String> result = new HashMap<String, String>();
		if(!"".equals(sessionKey) || !"".equals(id)){
			UnitBean bean = unitService.findBySessionKey(sessionKey);
			AssessmentContent assessmentContent = assessmentContentService.findById(id);
			SubmitContent content = new SubmitContent();
			content.setContent(text);
			content.setProject(assessmentContent);
			content.setScore(assessmentContent.getTotalScore());
			content.setUnitId(bean.getId());

			String needInsert = "";
//			if(StringUtils.isNotBlank(imgs)){
//				String [] imgUrls = imgs.split(",");
//				for (String imgUrl : imgUrls) {
//					needInsert += imgUrl.substring(imgUrl.lastIndexOf("/")+1, imgUrl.lastIndexOf(".")) + ",";
//				}
//			}
			for (String imgUrl : imgs) {
				needInsert += imgUrl.substring(imgUrl.lastIndexOf("/")+1, imgUrl.lastIndexOf(".")) + ",";
			}
			if(StringUtils.isNotBlank(needInsert)){
				needInsert = needInsert.substring(0,needInsert.lastIndexOf(","));
			}
			result.put("status", "0");
			result.put("msg", "资料上报完成");
			submitContentService.save(content, needInsert);
		}else{
			result.put("status", "1");
			result.put("msg", "基础信息加载失败");
			
		}
		return result;
	}
}
