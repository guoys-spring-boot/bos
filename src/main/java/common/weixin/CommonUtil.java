package common.weixin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;

import javax.net.ssl.HttpsURLConnection;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.show.api.ShowApiRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class CommonUtil {
private static Logger log = LoggerFactory.getLogger(CommonUtil.class);
	

	public static JSONObject httpsRequestToJsonObject(String requestUrl, String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		try {
			StringBuffer buffer = httpsRequest(requestUrl, requestMethod, outputStr);
			 jsonObject = JSONObject.parseObject(buffer.toString());
		} catch (Exception ce) {
			ce.printStackTrace();
		}
		return jsonObject;
	}

	private static StringBuffer httpsRequest(String requestUrl, String requestMethod, String output)
			throws NoSuchAlgorithmException, NoSuchProviderException, KeyManagementException, MalformedURLException,
			IOException, ProtocolException, UnsupportedEncodingException {
		URL url = new URL(requestUrl);
		HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
		connection.setDoOutput(true);
		connection.setDoInput(true);
		connection.setUseCaches(false);
		connection.setRequestMethod(requestMethod);
		if (null != output) {
			OutputStream outputStream = connection.getOutputStream();
			outputStream.write(output.getBytes("UTF-8"));
			outputStream.close();
		}
		// 从输入流读取返回内容
		InputStream inputStream = connection.getInputStream();
		InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
		BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
		String str = null;
		StringBuffer buffer = new StringBuffer();
		while ((str = bufferedReader.readLine()) != null) {
			buffer.append(str);
		}
		bufferedReader.close();
		inputStreamReader.close();
		inputStream.close();
		inputStream = null;
		connection.disconnect();
		return buffer;
	}

	/**
	 * 获取用户的openId，并放入session
	 * 
	 * @param token
	 *            微信返回的code
	 */
	public static  String  getTicket(String token) {
		String ticket="";
		String ticket_url = Constants.ticket_url.replace("ACCESS_TOKEN", token);
		System.out.println("获得：ticket_url:"+ticket_url);
		JSONObject jsonObject = CommonUtil.httpsRequestToJsonObject(ticket_url, "POST", null);
		System.out.println("oauth_url返回数据:"+jsonObject);
		Object errorCode = jsonObject.get("errcode");
		ticket = jsonObject.getString("ticket");
		return ticket;
	}
	/**
	 * 获取用户的openId，并放入session
	 * 
	 * @param token
	 *            微信返回的code
	 */
	public static  JSONObject  getUserInfo(String token,String openId) {
		String oauth_url = Constants.user_url.replace("ACCESS_TOKEN", token).replace("OPENID", openId);
		System.out.println("token:"+oauth_url);
		JSONObject jsonObject = CommonUtil.httpsRequestToJsonObject(oauth_url, "POST", null);
		System.out.println("oauth_url返回数据:"+jsonObject);
		return jsonObject;
	}
	/**
	 * 获取用户的openId，并放入session
	 */
	public static  String  getAcessToken() {
		String token="";
		String oauth_url = Constants.token_url.replace("APPID", Constants.appid).replace("SECRET", Constants.appsecret);
		System.out.println("token:"+oauth_url);
		JSONObject jsonObject = CommonUtil.httpsRequestToJsonObject(oauth_url, "POST", null);
		System.out.println("oauth_url返回数据:"+jsonObject);
		Object errorCode = jsonObject.get("errcode");
		token = jsonObject.getString("access_token");
		return token;
	}
	
	/**
	 * 获取
	 * 
	 * @param userParam
	 *            微信返回的code
	 */
	public static  String  getQrCode(String userParam) {
		String rtn="";
		String token=getAcessToken();
		String oauth_url = Constants.qr_code_url.replace("TOKEN", token);
		System.out.println("token:"+oauth_url);
		String param="{\"action_name\": \"QR_LIMIT_STR_SCENE\", \"action_info\": {\"scene\": {\"scene_str\": \""+userParam+"\"}}}";
		JSONObject jsonObject = CommonUtil.httpsRequestToJsonObject(oauth_url, "POST", param);
		System.out.println("code返回数据:"+jsonObject);
		Object errorCode = jsonObject.get("errcode");
		if(errorCode==null||StringUtils.isEmpty(errorCode.toString())){
			rtn=jsonObject.getString("url");
		}
		return rtn;
	}
	public static boolean sendMsg(String msg){
		boolean rs=false;
		String token=getAcessToken();
		if(StringUtils.isNotEmpty(token)){
			String url=Constants.kf_message_url.replace("ACCESS_TOKEN", token);
			JSONObject jsonObject = CommonUtil.httpsRequestToJsonObject(url, "POST", msg);
			rs=true;
		}
		return rs;
	}
	/**
	 * 获取用户的openId，并放入session
	 * 
	 * @param code
	 *            微信返回的code
	 */
	public static  String  getOpenId(String code) {
		String oprnid="";
		String oauth_url = Constants.oauth_url.replace("APPID", Constants.appid).replace("SECRET", Constants.appsecret)
				.replace("CODE", code);
		System.out.println("获得：oauth_url:"+oauth_url);
		JSONObject jsonObject = CommonUtil.httpsRequestToJsonObject(oauth_url, "POST", null);
		System.out.println("oauth_url返回数据:"+jsonObject);
		Object errorCode = jsonObject.get("errcode");
		if (errorCode != null) {
			log.info("code不合法");
		} else {
			oprnid = jsonObject.getString("openid");
		}
		return oprnid;
	}
	public static String getEmsMsg(String com,String emsNo){
		String res=new ShowApiRequest(Constants.ems_url,"11235",Constants.ems_secret)
		           .addTextPara("com",com)
		           .addTextPara("nu",emsNo)
		           .post();
		return res;
	}
}
