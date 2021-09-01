package com.bjpn.crm.settings.domain;

import lombok.Data;

@Data
public class User {

    /*
    关于登录验证：
        验证账号密码
        User user = select * from tbl_user where loginAct = ? and loginPwd = ?;

        user为null：账号密码错误
        user不为null：账号密码争取，需验证其他字段信息
        验证其他字段信息：
            expireTime 验证失效时间
            lockState  验证锁定状态
            allowIps   验证IP地址

    */
    private String id;  //编号 主键
    private String loginAct;    //登录账号
    private String name;    //真实姓名
    private String loginPwd;    //登录密码
    private String email;   //邮箱
    private String expireTime;  //失效时间 19位表示日期时间的字符串
    private String lockState;   //锁定状态 0：锁定 1：未锁定
    private String deptno;  //部门编号
    private String allowIps;    //允许访问的IP地址
    private String createTime;  //创建时间 19位表示日期时间的字符串
    private String createBy;    //创建人
    private String editTime;    //修改时间 19位表示日期时间的字符串
    private String editBy;  //修改人

}
