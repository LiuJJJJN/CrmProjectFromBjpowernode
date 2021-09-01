package com.bjpn.crm.settings.dao;

import com.bjpn.crm.settings.domain.User;
import com.bjpn.crm.utils.SqlSessionUtil;
import org.junit.Test;

public class UserDaoTest {
    private UserDao mapper = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Test
    public void loginTest() {
        User zs = mapper.selectByLoginActAndLoginPwd("zs", "202cb962ac59075b964b07152d234b70");
        System.out.println(zs);
    }
}
