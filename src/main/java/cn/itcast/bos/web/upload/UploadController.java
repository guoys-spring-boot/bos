package cn.itcast.bos.web.upload;

import cn.itcast.bos.web.upload.listener.ProgressListenerImp;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Created by gys on 2017/5/26.
 */

@Controller
@RequestMapping("/file")
public class UploadController {

    @RequestMapping("/getProgressBar")
    @ResponseBody
    public double getProgressBar(HttpSession session){
        UploadStatus status = (UploadStatus) session.getAttribute(ProgressListenerImp.UPLOADSTATUS_KEY);
        if(status == null){
            return 0d;
        }
        return  status.getPercent();
    }
}
