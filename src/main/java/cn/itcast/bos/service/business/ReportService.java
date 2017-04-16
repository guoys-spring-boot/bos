package cn.itcast.bos.service.business;

import java.util.List;

import cn.itcast.bos.domain.business.ReportUpBean;

public interface ReportService {

    List<ReportUpBean> listUnit(ReportUpBean reportUpBaen);

    int findTotalCount();

    int countUnit(ReportUpBean reportUpBaen);

    ReportUpBean findById(String id);

    
}
