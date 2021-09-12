package com.bjpn.crm.settings.service;

import com.bjpn.crm.settings.domain.DicValue;

import java.util.List;
import java.util.Map;

public interface DicService {

    /**
     * 获取所有字典数据
     * @return 所有字典数据
     */
    Map<String, List<DicValue>> getAll();
}
