package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.common.AjaxCommonResult;
import cn.itcast.bos.domain.business.Notice;
import cn.itcast.bos.service.business.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

import static cn.itcast.bos.common.AjaxCommonResult.newAjaxResult;

/**
 * Created by gys on 2018/6/1.
 */
@Controller
@RequestMapping("notice")
public class NoticeController {


    private NoticeService noticeService;
    private NoticeController(NoticeService noticeService){
        this.noticeService = noticeService;
    }

    @RequestMapping("/findAll")
    @ResponseBody
    public Object findAll(){
        return noticeService.findAll();
    }


    @RequestMapping("/saveNotice.do")
    @ResponseBody
    public Object saveNotice(Notice notice){
        if(notice.getName() == null){
            return newAjaxResult(400, "名称不能为空");
        }

        if(notice.getAttachment() == null || notice.getAttachment().getId() == null){
            return newAjaxResult(400, "附件不能为空");
        }
        noticeService.saveNotice(notice);
        return newAjaxResult(200, "保存成功");
    }

    @RequestMapping("/delete.do")
    @ResponseBody
    public String delete(String id){
        noticeService.delete(id);
        return "删除成功";
    }

}
