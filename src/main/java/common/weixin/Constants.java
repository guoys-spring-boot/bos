package common.weixin;

/**
 * 常量类
 * @author rory.wu
 *
 */
public class Constants {
 // 第三方用户唯一凭证
 public static String appid = "wx30fb9b39182af063";
 // 第三方用户唯一凭证密钥
 public static String appsecret = "99287803948738b72722a4de82b65edb";
 //商户ID
 public static String mch_id="1320943301";
 
 public static String Scope="snsapi_base";
 
 public static String redirect_uri=" http://wulingjiu.funglian.com/wljapi/index";
 
 public static String code_url="https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect";
 
 
 public static String state="true";
 
 public static String cookie_openid_key="openid-wlj";
 
 public static String default_open_id="oWaP9w_DG2b-uu1d5p82Tc1Q-Y64";
 //获取openId
 public static String oauth_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
 
//获取token
public static String token_url =  "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=SECRET";
//获取ticket
public static String ticket_url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
//获取二维码
public static String qr_code_url = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=TOKEN";

//获取用户信息
public static String user_url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN";

//获取用户信息
public static String kf_message_url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=ACCESS_TOKEN";


public static String ems_url="http://route.showapi.com/64-19";

public static String ems_app_id="11235";

public static String ems_secret="d8c1fe9c7de545b68bb7acb0a8568720";
 static{
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
//	 appid=StringUtils.isNotEmpty(WebUrlUtils.getValue(""))?WebUrlUtils.getValue(""):appid;
 }
 
}