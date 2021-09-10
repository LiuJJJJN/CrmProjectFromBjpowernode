package com.bjpn.crm.workbench.web.controller;

import com.bjpn.crm.settings.domain.User;
import com.bjpn.crm.settings.service.UserService;
import com.bjpn.crm.settings.service.impl.UserServiceImpl;
import com.bjpn.crm.utils.DateTimeUtil;
import com.bjpn.crm.utils.PrintJson;
import com.bjpn.crm.utils.ServiceFactory;
import com.bjpn.crm.utils.UUIDUtil;
import com.bjpn.crm.vo.PaginationVO;
import com.bjpn.crm.workbench.domain.Activity;
import com.bjpn.crm.workbench.domain.ActivityRemark;
import com.bjpn.crm.workbench.service.ActivityService;
import com.bjpn.crm.workbench.service.impl.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Clue表对应的控制层、表示层
 * 这里使用了模板模式，让具体方法实现功能
 */
public class ClueController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        System.out.println(path);
        if ("/workbench/clue/xxx.do".equals(path)) {
            //xxx(request, response);
        }
    }
}
