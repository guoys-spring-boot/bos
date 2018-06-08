package cn.itcast.bos.web.controller;

import com.google.common.collect.Maps;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;


@Controller
public class PageController {
	/**
	 * 通用页面访问方法
	 * @return
	 */
	@RequestMapping("/page.do")
	public String viewpage(String module, String resource, HttpServletRequest request){
		//System.out.println("访问页面....");
        Map<String, String[]> map = request.getParameterMap();
        request.setAttribute("preParam", transfer(map));

        return module+"/"+resource;
	}

	@RequestMapping("/sleep.do")
	public void sleep(long mills){
		if(mills <= 0){
			mills = 1000L * 60;
		}
		try{
			Thread.sleep(mills);
		}catch (InterruptedException e){
			// do nothing
		}
	}

	private Map<String, Object> transfer(Map<String, String[]> m){

        HashMap<String, Object> result = Maps.newHashMap();
        for (Map.Entry<String, String[]> entry : m.entrySet()) {
            if(entry.getValue() != null){
                if(entry.getValue().length == 1){
                    result.put(entry.getKey(), entry.getValue()[0]);
                }else {
                    result.put(entry.getKey(), entry.getValue());
                }
            }
        }

        return result;
    }
	
}

