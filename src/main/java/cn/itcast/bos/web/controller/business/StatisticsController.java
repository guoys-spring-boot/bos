package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.SubmitExecution;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.StatisticsServcie;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by gys on 2017/6/3.
 */

@Controller
@RequestMapping("/statistics")
public class StatisticsController {

    private StatisticsServcie statisticsServcie;

    public StatisticsController(StatisticsServcie statisticsServcie){
        this.statisticsServcie = statisticsServcie;
    }

    @RequestMapping("/listSubmitExecutions")
    @ResponseBody
    public Object listSubmitExecutions(@RequestParam(value = "unitId", required = false) String unitId, HttpSession session){
        String _unitId = null;
        if(StringUtils.isEmpty(unitId)){
            _unitId = ((UnitBean) session.getAttribute("user")).getId();
        }else{
            _unitId = unitId;
        }
        Map<String, Object> result = new HashMap<String, Object>();
        List<SubmitExecution> submitExecutions = statisticsServcie.listSubmitExecutions(_unitId);
        if(submitExecutions.size() > 0){
            submitExecutions.get(0).set_parentId(null);
        }
        result.put("total", submitExecutions.size());
        result.put("rows", submitExecutions);

        return result;
    }
}
