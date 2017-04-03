package cn.itcast.bos.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itcast.bos.domain.Region;
import cn.itcast.bos.page.PaginationInfo;

@Controller
public class PageController {
	/**
	 * 通用页面访问方法
	 * @return
	 */
	@RequestMapping("/page.do")
	public String viewpage(String module, String resource){
		//System.out.println("访问页面....");
		return module+"/"+resource;
	}
	
}

