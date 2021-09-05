package com.bjpn.crm.workbench.dao;

import com.bjpn.crm.settings.domain.User;
import com.bjpn.crm.workbench.domain.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

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

    /**
     * 查询符合要求的信息条数
     * @param map 查询依据
     * @return 符合的条数
     */
    Integer getTotalByCondition(Map<String, Object> map);

    /**
     * 查询符合要求的信息
     * @param map 查询依据
     * @return 符合要求的数据
     */
    List<Activity> getActivityListByCondition(Map<String, Object> map);

    /**
     * 根据id删除记录
     * @param s id值
     * @return 删除成功的条数
     */
    int deleteById(String s);

    /**
     * 获取子表中删除关联数量
     * @param ids 主键
     * @return 数量
     */
    int getCountByAids(String[] ids);

    /**
     * 删除字表数据
     * @param ids 主键
     * @return 删除成功条数
     */
    int delete(String[] ids);

    /**
     * 查询活动
     * @param id 活动的id
     * @return 活动
     */
    Activity getActivityById(String id);

    /**
     * 更新活动
     * @param activity 活动信息
     * @return 更新成功条数
     */
    int update(Activity activity);
}
