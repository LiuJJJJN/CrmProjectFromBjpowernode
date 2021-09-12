package com.bjpn.crm.settings.service.impl;

import com.bjpn.crm.settings.dao.DicTypeDao;
import com.bjpn.crm.settings.dao.DicValueDao;
import com.bjpn.crm.settings.domain.DicType;
import com.bjpn.crm.settings.domain.DicValue;
import com.bjpn.crm.settings.service.DicService;
import com.bjpn.crm.utils.SqlSessionUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DicServiceImpl implements DicService {
    private DicTypeDao dicTypeDao = SqlSessionUtil.getSqlSession().getMapper(DicTypeDao.class);
    private DicValueDao dicValueDao = SqlSessionUtil.getSqlSession().getMapper(DicValueDao.class);


    @Override
    public Map<String, List<DicValue>> getAll() {
        Map<String, List<DicValue>> map = new HashMap<>();
        List<DicType> dtList = dicTypeDao.getTypeList();
        for (DicType dicType : dtList) {
            //取得字典类型
            String code = dicType.getCode();
            //取得每个字典类型的值列表
            List<DicValue> dvList = dicValueDao.getValueByCode(code);
            //将结果保存到map中
            map.put(code, dvList);
        }

        return map;
    }
}
