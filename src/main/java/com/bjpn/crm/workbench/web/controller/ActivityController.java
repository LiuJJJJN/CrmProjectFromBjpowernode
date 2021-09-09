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
 * Activity表对应的控制层、表示层
 * 这里使用了模板模式，让具体方法实现功能
 */
public class ActivityController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        System.out.println(path);
        if ("/workbench/activity/getUserList.do".equals(path)){
            getUserList(request, response);
        }
        if ("/workbench/activity/save.do".equals(path)){
            save(request, response);
        }
        if ("/workbench/activity/pageList.do".equals(path)){
            pageList(request, response);
        }
        if ("/workbench/activity/delete.do".equals(path)){
            delete(request, response);
        }
        if ("/workbench/activity/getUserListAndActivity.do".equals(path)){
            getUserListAndActivity(request, response);
        }
        if ("/workbench/activity/update.do".equals(path)){
            update(request, response);
        }
        if ("/workbench/activity/detail.do".equals(path)){
            detail(request, response);
        }
        if ("/workbench/activity/getRemarkListByAid.do".equals(path)){
            getRemarkListByAid(request, response);
        }
    }

    private void getRemarkListByAid(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");

        System.out.println("id : "+id);

        ActivityService service = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        List list =  service.getRemarkListByAid(id);
        PrintJson.printJsonObj(response, list);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        ActivityService service = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Activity a = service.detail(id);
        request.setAttribute("a", a);

        request.getRequestDispatcher("/workbench/activity/detail.jsp").forward(request, response);
    }

    private void update(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String cost = request.getParameter("cost");
        String description = request.getParameter("description");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

        Activity activity = new Activity();
        activity.setId(id);
        activity.setOwner(owner);
        activity.setName(name);
        activity.setStartDate(startDate);
        activity.setEndDate(endDate);
        activity.setCost(cost);
        activity.setDescription(description);
        activity.setEditTime(editTime);
        activity.setEditBy(editBy);

        ActivityService service = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Boolean flag = service.update(activity);
        PrintJson.printJsonFlag(response, flag);
    }

    private void getUserListAndActivity(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        ActivityService service = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Map<String, Object> map = service.getUserListAndActivity(id);
        PrintJson.printJsonObj(response, map);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        String[] ids = request.getParameterValues("id");

        ActivityService service = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = service.delete(ids);

        if(flag){
            PrintJson.printJsonFlag(response, true);
        }else{
            PrintJson.printJsonFlag(response, false);
        }
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        String pageNo = request.getParameter("pageNo");
        String pageSize = request.getParameter("pageSize");
        String name = request.getParameter("name");
        String owner = request.getParameter("owner");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        ActivityService service = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        Map<String, Object> map = new HashMap<>();
        map.put("pageNo", pageNo);
        map.put("pageSize", pageSize);
        map.put("name", name);
        map.put("owner", owner);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        PaginationVO vo = service.pageList(map);

        PrintJson.printJsonObj(response, vo);

    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        String id = UUIDUtil.getUUID();
        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String cost = request.getParameter("cost");
        String description = request.getParameter("description");
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        //String editTime;
        //String editBy;

        Activity activity = new Activity();
        activity.setId(id);
        activity.setOwner(owner);
        activity.setName(name);
        activity.setStartDate(startDate);
        activity.setEndDate(endDate);
        activity.setCost(cost);
        activity.setDescription(description);
        activity.setCreateTime(createTime);
        activity.setCreateBy(createBy);

        ActivityService service = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Boolean flag = service.save(activity);
        PrintJson.printJsonFlag(response, flag);

    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {
        //使用动态代理，拿张三取李四
        UserService service = (UserService) ServiceFactory.getService(new UserServiceImpl());

        List<User> userList = service.getUserList();

        PrintJson.printJsonObj(response, userList);
    }

}

