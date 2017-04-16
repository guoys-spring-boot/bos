package cn.itcast.bos.web.controller.business;

import java.util.*;

import cn.itcast.bos.domain.business.*;
import cn.itcast.bos.service.business.AssessmentContentService;
import cn.itcast.bos.service.business.ScoreService;
import com.github.pagehelper.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;

import cn.itcast.bos.service.business.ReportService;

import javax.servlet.http.HttpServletRequest;


@RequestMapping("/business")
@Controller
public class ReportController {
     
		private ReportService reportService;

		private AssessmentContentService assessmentContentService;

		private ScoreService scoreService;
		  
		public ReportController(ReportService reportService, AssessmentContentService assessmentContentService,
                                ScoreService scoreService){
		        this.reportService = reportService;
		        this.assessmentContentService = assessmentContentService;
		        this.scoreService = scoreService;
		}
	  
	    @RequestMapping("/listReport")
	    @ResponseBody
	    public Object listReport(int page, int rows, ReportUpBean reportUpBean, HttpServletRequest request){
	        Map<String, Object> result = new HashMap<String, Object>();
			UnitBean unitBean = (UnitBean)request.getSession().getAttribute("user");
			if(reportUpBean == null){
				reportUpBean = new ReportUpBean();
			}
			reportUpBean.setDwid(unitBean.getId());
			Page<Object> page1 = PageHelper.startPage(page, rows);
			result.put("rows", reportService.listUnit(reportUpBean));
	        result.put("total", page1.getTotal());
	        return result;
	    }

	    @RequestMapping("/toExamPage")
	    public String toExamPage(@RequestParam("contentId") String contentId, @RequestParam("projectId") String projectId,
                                        Model model){
            AssessmentContent assessmentContent = assessmentContentService.findById(projectId);
            model.addAttribute("assessmentContent", assessmentContent);
            model.addAttribute("contentId", contentId);
            model.addAttribute("disabled", false);
            model.addAttribute("action", "add");
            return "report/reportinfo";
        }

        @RequestMapping("/addScore")
        @ResponseBody
        public Object addScore(@RequestBody Score[] scores, HttpServletRequest request){
            UnitBean unitBean = (UnitBean) request.getSession().getAttribute("user");
            for (Score score : scores) {
                score.setUnitId(unitBean.getId());
            }
            scoreService.insert(Arrays.asList(scores));
            return true;
        }

}
