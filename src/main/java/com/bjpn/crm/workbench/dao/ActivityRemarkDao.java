package com.bjpn.crm.workbench.dao;

import com.bjpn.crm.workbench.domain.ActivityRemark;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

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

    /**
     * 查询活动id包含的所有备注
     * @param id 活动id
     * @return 备注列表
     */
    List<ActivityRemark> getRemarkListByAid(@Param("aid") String id);

    /**
     * 删除备注
     * @param id 备注id
     * @return 删除成功的条数
     */
    int deleteRemark(String id);

    /**
     * 添加备注
     * @param ar 备注信息
     * @return 添加成功的条数
     */
    int saveActivityRemark(ActivityRemark ar);

    /**
     * 修改备注
     * @param map 备注 id 与要修改的 noteContent
     * @return 修改成功的条数
     */
    int editRemark(Map<String, Object> map);
}
