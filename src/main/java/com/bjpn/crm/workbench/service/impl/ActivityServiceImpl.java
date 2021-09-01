package com.bjpn.crm.workbench.service.impl;

import com.bjpn.crm.utils.SqlSessionUtil;
import com.bjpn.crm.workbench.dao.ActivityDao;

public class ActivityServiceImpl {
    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);

}
