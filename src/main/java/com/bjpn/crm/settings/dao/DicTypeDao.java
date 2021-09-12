package com.bjpn.crm.settings.dao;

import com.bjpn.crm.settings.domain.DicType;

import java.util.List;

public interface DicTypeDao {
    /**
     * 获取要用的类型
     * @return 所有将要在DicValue中用的类型数据
     */
    List<DicType> getTypeList();
}
