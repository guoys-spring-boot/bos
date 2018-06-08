package cn.itcast.bos.service.business.impl;

import java.util.List;

import cn.itcast.bos.dao.business.AgencyReportProcessDao;
import cn.itcast.bos.domain.business.AgencyReportProcess;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.itcast.bos.dao.business.ReportDao;
import cn.itcast.bos.domain.business.ReportUpBean;
import cn.itcast.bos.service.business.ReportService;

@Service
@Transactional
public class ReportServiceImp implements ReportService{
    private ReportDao reportdao;
	private AgencyReportProcessDao agencyReportProcessDao;
    
    public ReportServiceImp(ReportDao reportdao, AgencyReportProcessDao p){
    	this.reportdao = reportdao;
    	this.agencyReportProcessDao = p;
    }
	@Override
	public List<ReportUpBean> listUnit(ReportUpBean reportUpBaen) {
		return reportdao.findAll(reportUpBaen);
	}

	@Override
	public int findTotalCount() {
		// TODO Auto-generated method stub
		return reportdao.findTotalCount();
	}

	@Override
	public int countUnit(ReportUpBean reportUpBaen) {
		// TODO Auto-generated method stub
		return reportdao.totalCountByCondition(reportUpBaen);
	}

	@Override
	public ReportUpBean findById(String id) {
		    ReportUpBean reportUpBaen = reportdao.findById(id);
	        if(reportUpBaen == null){
	        	reportUpBaen = new ReportUpBean();
	        }
	        return reportUpBaen;
	}

	@Override
	public List<AgencyReportProcess> findAgency(AgencyReportProcess p) {
		return agencyReportProcessDao.findByCondition(p);
	}
}
