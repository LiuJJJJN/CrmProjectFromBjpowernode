package com.bjpn.crm.workbench.service.impl;

import com.bjpn.crm.utils.SqlSessionUtil;
import com.bjpn.crm.workbench.dao.ActivityDao;
import com.bjpn.crm.workbench.domain.Activity;
import com.bjpn.crm.workbench.service.ActivityService;


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
}
