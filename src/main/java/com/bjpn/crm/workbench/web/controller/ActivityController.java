package com.bjpn.crm.workbench.web.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Activity表对应的控制层、表示层
 * 这里使用了模板模式，让具体方法实现功能
 */
public class ActivityController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/workbench/activity/xxx.do".equals(path)){
            //xxx(request, response);
        }
        if ("/workbench/activity/xxx.do".equals(path)){
            //xxx(request, response);
        }
    }

}
