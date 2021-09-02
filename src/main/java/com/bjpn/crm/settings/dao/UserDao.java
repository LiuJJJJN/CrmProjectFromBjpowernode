package com.bjpn.crm.settings.dao;

import com.bjpn.crm.settings.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * User用户表的DAO接口
 * @author 刘嘉宁
 */
public interface UserDao {
    /**
     * 登录验证查询，查询用户名密码对应的用户信息
     * @param loginAct 用户名
     * @param loginPwd 密码
     * @return 未查询到返回null 查询到返回User
     */
    User selectByLoginActAndLoginPwd(@Param("act") String loginAct, @Param("pwd") String loginPwd);

    /**
     * 获取所有用户信息的方法
     * @return User表中所有信息
     */
    List<User> getUserList();
}
