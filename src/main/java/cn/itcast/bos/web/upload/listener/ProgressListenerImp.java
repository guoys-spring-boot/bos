package cn.itcast.bos.web.upload.listener;

import cn.itcast.bos.web.upload.UploadStatus;
import org.apache.commons.fileupload.ProgressListener;

import javax.servlet.http.HttpSession;

/**
 * Created by gys on 2017/5/23.
 */
public class ProgressListenerImp implements ProgressListener {

    public  static final String UPLOADSTATUS_KEY = "common.uploadStatus";
    private HttpSession session;

    public ProgressListenerImp(HttpSession session){
        this.session = session;
    }

    @Override
    public void update(long pBytesRead, long pContentLength, int pItems) {
        UploadStatus status = this.getUploadStatus();
        status.setAlreayRead(pBytesRead);
        status.setSize(pContentLength);
        status.setItems(pItems);
    }

    private UploadStatus getUploadStatus(){

        UploadStatus status = (UploadStatus)session.getAttribute(UPLOADSTATUS_KEY);
        if(status == null){
            status = new UploadStatus(0l, 0l, 0);
            session.setAttribute(UPLOADSTATUS_KEY, status);
        }
        return status;
    }
}
