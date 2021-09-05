package com.bjpn.crm.workbench.service;

import com.bjpn.crm.vo.PaginationVO;
import com.bjpn.crm.workbench.domain.Activity;

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
}
