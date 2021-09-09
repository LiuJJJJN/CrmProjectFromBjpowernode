package com.bjpn.crm.workbench.service;

import com.bjpn.crm.vo.PaginationVO;
import com.bjpn.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityService {

    /**
     * 添加活动
     * @param activity 活动信息
     * @return 是否添加成功
     */
    Boolean save(Activity activity);

    /**
     * 分页查询
     * @param map 查询依据
     * @return 查询结果
     */
    PaginationVO pageList(Map<String, Object> map);

    /**
     * 删除活动
     * @param id 按照id们删除
     * @return 删除成功的条数
     */
    boolean delete(String[] id);

    /**
     * 查询用户信息和id对应的活动列表
     * @param id 活动id
     * @return 用户名称信息和id对应的活动列表
     */
    Map<String, Object> getUserListAndActivity(String id);

    /**
     * 更新活动信息
     * @param activity 活动信息
     * @return 更新是否成功
     */
    Boolean update(Activity activity);

    /**
     * 跳转至详情页面所需的数据
     * @param id 活动的id
     * @return 活动的内容
     */
    Activity detail(String id);

    /**
     * 根据活动id获取活动的备注
     * @param id 活动id
     * @return 对应的备注列表
     */
    List getRemarkListByAid(String id);
}
