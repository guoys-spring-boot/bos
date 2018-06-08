package cn.itcast.bos.common;

import cn.itcast.bos.domain.business.UnitBean;

import javax.servlet.http.HttpSession;

/**
 * Created by gys on 2018/4/19.
 */
public final class SessionHelpler {

    /**
     * 获取年度
     * @param session
     * @return
     */
    public static String resolveYear(HttpSession session){
        return (String) session.getAttribute("year");
    }

    public static void saveYear(HttpSession session, String year){
        session.setAttribute("year", year);
    }

    public static UnitBean resolveUnit(HttpSession session){
        return (UnitBean) session.getAttribute("user");
    }

}
