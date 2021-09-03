package com.bjpn.crm.workbench.service.impl;

import com.bjpn.crm.utils.SqlSessionUtil;
import com.bjpn.crm.vo.PaginationVO;
import com.bjpn.crm.workbench.dao.ActivityDao;
import com.bjpn.crm.workbench.domain.Activity;
import com.bjpn.crm.workbench.service.ActivityService;

import java.util.List;
import java.util.Map;


public class ActivityServiceImpl implements ActivityService {
    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);


    @Override
    public Boolean save(Activity activity) {
        int count = activityDao.save(activity);

        if (count == 1){
            return true;
        }

        return false;
    }

    @Override
    public PaginationVO pageList(Map<String, Object> map) {
        PaginationVO vo = new PaginationVO();

        int pageNo = Integer.parseInt((String) map.get("pageNo"));
        Integer pageSize = Integer.parseInt((String) map.get("pageSize"));
        Integer skipCount = (pageNo-1) * pageSize;
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        Integer total = activityDao.getTotalByCondition(map);

        List<Activity> dataList = activityDao.getActivityListByCondition(map);

        vo.setTotal(total);
        vo.setDataList(dataList);

        return vo;
    }
}
