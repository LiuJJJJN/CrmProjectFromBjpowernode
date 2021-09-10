package com.bjpn.crm.workbench.service.impl;

import com.bjpn.crm.utils.SqlSessionUtil;
import com.bjpn.crm.workbench.dao.ClueDao;
import com.bjpn.crm.workbench.service.ClueService;

public class ClueServiceImpl implements ClueService {
    private ClueDao clueDao = SqlSessionUtil.getSqlSession().getMapper(ClueDao.class);
}
