package com.bjpn.crm.web.filter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;

public class EncodingFilter implements javax.servlet.Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain filterChain) throws IOException, ServletException {
        //设置字符集
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        //放行
        filterChain.doFilter(req, resp);
    }
}
