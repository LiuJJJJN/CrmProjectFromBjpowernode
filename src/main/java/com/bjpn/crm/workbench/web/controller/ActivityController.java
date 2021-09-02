package com.bjpn.crm.workbench.web.controller;

import com.bjpn.crm.settings.domain.User;
import com.bjpn.crm.settings.service.UserService;
import com.bjpn.crm.settings.service.impl.UserServiceImpl;
import com.bjpn.crm.utils.PrintJson;
import com.bjpn.crm.utils.ServiceFactory;
import com.bjpn.crm.workbench.service.impl.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Activity表对应的控制层、表示层
 * 这里使用了模板模式，让具体方法实现功能
 */
public class ActivityController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/workbench/activity/getUserList.do".equals(path)){
            getUserList(request, response);
        }
        if ("/workbench/activity/xxx.do".equals(path)){
            //xxx(request, response);
        }
    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {
        //使用动态代理，拿张三取李四
        UserService service = (UserService) ServiceFactory.getService(new UserServiceImpl());

        List<User> userList = service.getUserList();

        PrintJson.printJsonObj(response, userList);
    }

}

