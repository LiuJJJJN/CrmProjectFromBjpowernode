package com.bjpn.crm.workbench.dao;

/**
 * ActivityRemark表的DAO接口
 * @author 刘嘉宁
 */
public interface ActivityRemarkDao {

    /**
     * 查询要删除的数量
     * @param ids 依据
     * @return 查询到的条数
     */
    int getCountByAids(String[] ids);

    /**
     * 删除备注数据
     * @param ids 依据
     * @return 删除成功的条数
     */
    int deleteByAids(String[] ids);
}
