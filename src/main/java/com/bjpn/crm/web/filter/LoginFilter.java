package com.bjpn.crm.web.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);

        //检查是否是登陆操作
        String servletPath = request.getServletPath();
        if ("/login.jsp".equals(servletPath) || "/settings/user/login.do".equals(servletPath)) {
            filterChain.doFilter(servletRequest, servletResponse);

        //检测是否登录过（session）
        }else if (session != null) {
            filterChain.doFilter(servletRequest, servletResponse);

        //都没有就重新登录
        }else {
            response.sendRedirect(request.getContextPath()+"/login.jsp");
        }

    }
}
