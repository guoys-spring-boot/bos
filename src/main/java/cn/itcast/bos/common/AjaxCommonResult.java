package cn.itcast.bos.common;

/**
 * Created by gys on 2018/6/2.
 */
public class AjaxCommonResult {

    private int status;

    private String msg;

    public AjaxCommonResult(int status, String msg){
        this.status = status;
        this.msg = msg;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public static AjaxCommonResult newAjaxResult(int code, String msg){
        return new AjaxCommonResult(code, msg);
    }
}
