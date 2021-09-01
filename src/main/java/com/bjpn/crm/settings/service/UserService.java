package com.bjpn.crm.settings.service;

import com.bjpn.crm.exception.LoginException;
import com.bjpn.crm.settings.domain.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface UserService {
    User login(String loginAct, String loginPwd, String ip) throws LoginException;
}
