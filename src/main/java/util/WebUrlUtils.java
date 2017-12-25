package util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.lang3.StringUtils;

import common.weixin.Constants;

public class WebUrlUtils {

	public static String getWebSite(HttpServletRequest request) {
		String returnUrl = request.getScheme() + "://" + request.getServerName();
		if (request.getServerPort() != 80) {
			returnUrl = returnUrl + ":" + request.getServerPort();
		}
		returnUrl = returnUrl + request.getContextPath();
		return returnUrl;
	}

	public static String getOpenId(HttpServletRequest request) {
		String openid = "";
		try {
			HttpSession session = request.getSession();
			String openId=(String) session.getAttribute("newOpenId");
//			String openId = (String) session.getAttribute("wlj_weixin_openid");
			System.out.println("ttttt:"+openId);
			if(StringUtils.isNotEmpty(openId)){
				return  openId;
			}
			Cookie[] cookies = request.getCookies();// 这样便可以获取一个cookie数组
			if(cookies!=null&& cookies.length>0){
				for (Cookie cookie : cookies) {
					if (Constants.cookie_openid_key.equalsIgnoreCase(cookie.getName()))
						openid = cookie.getValue(); // get the cookie value
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("000000000000:"+openid);
		return openid;
	}

	public static String getRemoteByUrl(String url, Map<String, String> params) {
//		Map<String, String> map = new HashMap<String, String>();
		try {
			HttpClient client = new HttpClient();
			PostMethod method = new PostMethod(url);
			if (params != null) {
				for (String key : params.keySet()) {
					((PostMethod) method).addParameter(key, params.get(key));
				}
			}
			HttpMethodParams param = method.getParams();
			param.setContentCharset("UTF-8");

			client.executeMethod(method);
			// 打印服务器返回的状态
			System.out.println(method.getStatusLine());
			InputStream stream = method.getResponseBodyAsStream();

			BufferedReader br = new BufferedReader(new InputStreamReader(stream, "UTF-8"));
			StringBuffer buf = new StringBuffer();
			String line;
			while (null != (line = br.readLine())) {
				buf.append(line).append("\n");
				//System.out.println(line);
			}
			System.out.println(buf.toString());
			// 释放连接
			method.releaseConnection();
			return buf.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
		
	}

	public static void main(String[] args) {
		//https://api.weixin.qq.com/sns/jscode2session?appid=APPID&secret=SECRET&js_code=JSCODE&grant_type=authorization_code
		// getRemoteByUrl(getValue("weixin.index")+"&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect",null);
	}

}
