package com.bjpn.crm.workbench.dao;

import com.bjpn.crm.settings.domain.User;
import com.bjpn.crm.workbench.domain.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Activity表的DAO接口
 * @author 刘嘉宁
 */
public interface ActivityDao {

    /**
     *添加活动的方法
     * @param activity 要添加的活动
     * @return 添加成功条数
     */
    int save(Activity activity);
}
