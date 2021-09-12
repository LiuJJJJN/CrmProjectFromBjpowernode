package com.bjpn.crm.settings.dao;

import com.bjpn.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {
    /**
     * 根据字典类型获取字典值
     * @param code 字典类型
     * @return 当前字典类型的值列表
     */
    List<DicValue> getValueByCode(String code);
}
