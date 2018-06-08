package cn.itcast.bos.web.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Created by gys on 2018/6/6.
 */

@WebListener
public class InitApplicationListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("context.properties");
        Properties p = new Properties();
        try {
            p.load(inputStream);
        } catch (IOException e) {
            throw new IllegalStateException("context.properties 加载出错， ", e);
        }
        sce.getServletContext().setAttribute("context", p);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
