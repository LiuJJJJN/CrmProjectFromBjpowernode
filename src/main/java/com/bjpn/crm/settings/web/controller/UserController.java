package com.bjpn.crm.settings.web.controller;

import com.bjpn.crm.exception.LoginException;
import com.bjpn.crm.settings.domain.User;
import com.bjpn.crm.settings.service.UserService;
import com.bjpn.crm.settings.service.impl.UserServiceImpl;
import com.bjpn.crm.utils.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * User表对应的控制层、表示层
 * 这里使用了模板模式，让具体方法实现功能
 */
public class UserController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/settings/user/login.do".equals(path)){
            login(request, response);
        }
        if ("/settings/user/xxx.do".equals(path)){
            //xxx(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) {
        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        loginPwd = MD5Util.getMD5(loginPwd);
        String ip = request.getLocalAddr();

        //使用代理类形态的接口对象
        UserService service = (UserService) ServiceFactory.getService(new UserServiceImpl());

        try {
            User user = service.login(loginAct, loginPwd, ip);
            request.getSession().setAttribute("user", user);
            PrintJson.printJsonFlag(response, true);
        } catch (LoginException e) {
            String message = e.getMessage();
            Map<String, Object> map = new HashMap<>();
            map.put("success", false);
            map.put("msg", message);
            PrintJson.printJsonObj(response, map);
        }

    }

}
