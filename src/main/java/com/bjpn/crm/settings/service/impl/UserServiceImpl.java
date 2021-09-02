package com.bjpn.crm.settings.service.impl;

import com.bjpn.crm.exception.LoginException;
import com.bjpn.crm.settings.dao.UserDao;
import com.bjpn.crm.settings.domain.User;
import com.bjpn.crm.settings.service.UserService;
import com.bjpn.crm.utils.DateTimeUtil;
import com.bjpn.crm.utils.SqlSessionUtil;

import java.util.List;

public class UserServiceImpl implements UserService {
    //通过代理创建userDao实例
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public User login(String loginAct, String loginPwd, String ip) throws LoginException {

        User user = null;
        try {
            user = userDao.selectByLoginActAndLoginPwd(loginAct, loginPwd);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //验证账户密码
        if (user == null){
            //System.out.println("账户密码有误");
            throw new LoginException("账号或密码错误");
        }

        //验证锁定状态
        String sysTime = DateTimeUtil.getSysTime();
        if (sysTime.compareTo(user.getExpireTime()) > 0){
            throw new LoginException("账户处于锁定状态，无法登录");
        }

        //验证ip地址
        if (!user.getAllowIps().contains(ip)){
            throw new LoginException("当前IP非允许登录设备");
        }

        //放行
        return user;
    }

    @Override
    public List<User> getUserList() {
        List<User> userList = userDao.getUserList();

        return userList;
    }
}
