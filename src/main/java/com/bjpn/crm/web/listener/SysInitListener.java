package com.bjpn.crm.web.listener;

import com.bjpn.crm.settings.domain.DicValue;
import com.bjpn.crm.settings.service.DicService;
import com.bjpn.crm.settings.service.impl.DicServiceImpl;
import com.bjpn.crm.utils.ServiceFactory;
import org.apache.ibatis.session.SqlSessionFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SysInitListener implements ServletContextListener {
    /**
     * 该监听器在服务器启动创建全局作用域对象时被触发
     * @param sce 在什么监听器的参数中就能取的什么作用域对象
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        //取得全局作用域对象
        ServletContext application = sce.getServletContext();

        DicService ds = (DicService) ServiceFactory.getService(new DicServiceImpl());
        Map<String, List<DicValue>> map = ds.getAll();
        Set<String> typeCodes = map.keySet();
        for (String typeCode : typeCodes) {
            //将数据字典存入全局作用域对象中
            application.setAttribute(typeCode, map.get(typeCode));
        }
    }

}
