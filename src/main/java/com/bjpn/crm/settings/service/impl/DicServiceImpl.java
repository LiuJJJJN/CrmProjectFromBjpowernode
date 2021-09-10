package com.bjpn.crm.settings.service.impl;

import com.bjpn.crm.settings.dao.DicTypeDao;
import com.bjpn.crm.settings.dao.DicValueDao;
import com.bjpn.crm.settings.service.DicService;
import com.bjpn.crm.utils.SqlSessionUtil;

public class DicServiceImpl implements DicService {
    private DicTypeDao dicTypeDao = SqlSessionUtil.getSqlSession().getMapper(DicTypeDao.class);
    private DicValueDao dicValueDao = SqlSessionUtil.getSqlSession().getMapper(DicValueDao.class);


}
