package cn.itcast.bos;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.ComponentScan;


/**
 * Created by gys on 2017/3/28.
 */

@SpringBootApplication
@ServletComponentScan
@ComponentScan
public class Application {

    public static void main(String[] args){
        SpringApplication.run(Application.class, args);
    }

}
