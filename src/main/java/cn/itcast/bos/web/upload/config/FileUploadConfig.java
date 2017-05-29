package cn.itcast.bos.web.upload.config;

import cn.itcast.bos.web.upload.resolver.CustomMultipartResolver;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.web.multipart.MultipartResolver;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by gys on 2017/5/23.
 */

@Configuration
public class FileUploadConfig {

    private Environment environment;

    public FileUploadConfig(Environment environment){
        this.environment = environment;
    }

    @Bean(name = "multipartResolver")
    public MultipartResolver multipartResolver(){

        CustomMultipartResolver resolver = new CustomMultipartResolver();
        //CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setDefaultEncoding("UTF-8");
        resolver.setResolveLazily(true);//resolveLazily属性启用是为了推迟文件解析，以在在UploadAction中捕获文件大小异常
        String maxSize = environment.getProperty("spring.http.multipart.maxFileSize");

        resolver.setMaxInMemorySize(40960);

        resolver.setMaxUploadSize(this.convert2Long(maxSize));//上传文件大小 50M 50*1024*1024
        return resolver;
    }

    private long convert2Long(String maxSize){
        try{
            return Long.parseLong(maxSize);
        }catch (NumberFormatException e){
            maxSize = maxSize.toUpperCase();
            long GB = 1024 * 1024 * 1024;
            if(maxSize.endsWith("GB")){
                return Long.parseLong(maxSize.substring(0, maxSize.length()-2)) * GB;
            }

            if(maxSize.endsWith("G")){
                return Long.parseLong(maxSize.substring(0, maxSize.length()-1)) * GB;
            }
            long MB = 1024 * 1024;
            if(maxSize.endsWith("MB")){
                return Long.parseLong(maxSize.substring(0, maxSize.length()-2)) * MB;
            }

            if(maxSize.endsWith("M")){
                return Long.parseLong(maxSize.substring(0, maxSize.length()-1)) * MB;
            }

            long KB = 1024;
            if(maxSize.endsWith("KB")){
                return Long.parseLong(maxSize.substring(0, maxSize.length()-2)) * MB;
            }

            if(maxSize.endsWith("K")){
                return Long.parseLong(maxSize.substring(0, maxSize.length()-1)) * MB;
            }

            throw e;

        }

    }
}
