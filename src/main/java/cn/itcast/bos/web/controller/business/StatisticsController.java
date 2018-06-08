package cn.itcast.bos.web.controller.business;

import cn.itcast.bos.domain.business.SubmitExecution;
import cn.itcast.bos.domain.business.UnitBean;
import cn.itcast.bos.service.business.StatisticsServcie;
import cn.itcast.bos.utils.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cn.itcast.bos.common.SessionHelpler.resolveYear;


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
        String year = resolveYear(session);

        Map<String, Object> result = new HashMap<String, Object>();
        List<SubmitExecution> submitExecutions = statisticsServcie.listSubmitExecutions(_unitId, year);
        if(submitExecutions.size() > 0){
            submitExecutions.get(0).set_parentId(null);
        }

        result.put("total", submitExecutions.size());
        result.put("rows", submitExecutions);

        return result;
    }

    @RequestMapping("/excelSubmitExecutions")
    public void excelSubmitExecutions(@RequestParam(value = "unitId", required = false) String unitId, HttpSession session,
                                      HttpServletRequest request, HttpServletResponse response) throws IOException {
        String _unitId = null;
        if(StringUtils.isEmpty(unitId)){
            _unitId = ((UnitBean) session.getAttribute("user")).getId();
        }else{
            _unitId = unitId;
        }
        String year = resolveYear(session);

        List<String> headerRow = new ArrayList<String>();
        headerRow.add("单位名称");
        headerRow.add("单位类型");
        headerRow.add("总题目数");
        headerRow.add("已完成题目数");
        headerRow.add("未完成题目数");
        headerRow.add("得分情况");
        headerRow.add("完成率");
        List<SubmitExecution> submitExecutions = statisticsServcie.listSubmitExecutions(_unitId, year);

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("完成情况表");

        HSSFRow row = sheet.createRow(0);
        int i = 0;
        for (String s : headerRow) {

            HSSFCell cell = row.createCell(i);
            sheet.autoSizeColumn(i);
            cell.setCellValue(s);
            i++;
        }

        int j = 1;
        for (SubmitExecution submitExecution : submitExecutions) {
            HSSFRow row1 = sheet.createRow(j++);
            createStringCell(row1, 0, submitExecution.getUnitName());
            createStringCell(row1, 1, submitExecution.getUnitType());
            createStringCell(row1, 2, submitExecution.getTotalCount());
            createStringCell(row1, 3, submitExecution.getCompletedCount());
            createStringCell(row1, 4, submitExecution.getUnCompleteCount());
            createStringCell(row1, 5, submitExecution.getTotalScore() + "");
            createStringCell(row1, 6, submitExecution.getCompetePercent());

        }

        response.setHeader("conent-type", "application/octet-stream");
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=" +
                FileUtils.encodeDownloadFilename("执行完成情况表.xls", request.getHeader("user-agent")));
        workbook.write(response.getOutputStream());
    }

    private void createStringCell(HSSFRow row, int index, String cellValue){
        HSSFCell cell = row.createCell(index);
        cell.setCellValue(cellValue);
    }


}


