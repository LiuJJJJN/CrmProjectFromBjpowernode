package com.bjpn.crm.workbench.service.impl;

import com.bjpn.crm.settings.dao.UserDao;
import com.bjpn.crm.utils.SqlSessionUtil;
import com.bjpn.crm.vo.PaginationVO;
import com.bjpn.crm.workbench.dao.ActivityDao;
import com.bjpn.crm.workbench.dao.ActivityRemarkDao;
import com.bjpn.crm.workbench.domain.Activity;
import com.bjpn.crm.workbench.domain.ActivityRemark;
import com.bjpn.crm.workbench.service.ActivityService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ActivityServiceImpl implements ActivityService {
    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);
    private ActivityRemarkDao activityRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkDao.class);
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public Boolean save(Activity activity) {
        int count = activityDao.save(activity);

        if (count == 1){
            return true;
        }

        return false;
    }

    @Override
    public PaginationVO pageList(Map<String, Object> map) {
        PaginationVO vo = new PaginationVO();

        int pageNo = Integer.parseInt((String) map.get("pageNo"));
        Integer pageSize = Integer.parseInt((String) map.get("pageSize"));
        Integer skipCount = (pageNo-1) * pageSize;
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        Integer total = activityDao.getTotalByCondition(map);

        List<Activity> dataList = activityDao.getActivityListByCondition(map);

        vo.setTotal(total);
        vo.setDataList(dataList);

        return vo;
    }

    @Override
    public boolean delete(String[] ids) {
        boolean flag = true;

        //查询需要删除的备注
        int count1 = activityRemarkDao.getCountByAids(ids);
        //删除备注，返回删除的条数
        int count2 = activityRemarkDao.deleteByAids(ids);

        if (count1 != count2){
            flag = false;
        }

        //删除市场活动
        int count3 = activityDao.delete(ids);

        if (count3 != ids.length){
            flag = false;
        }

        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndActivity(String id) {
        Map<String, Object> map = new HashMap<>();
        map.put("uList", userDao.getUserList());
        map.put("a", activityDao.getActivityById(id));

        return map;
    }

    @Override
    public Boolean update(Activity activity) {
        int count = activityDao.update(activity);

        if (count == 1){
            return true;
        }

        return false;
    }

    @Override
    public Activity detail(String id) {
        Activity a = null;

        a = activityDao.getDetailById(id);

        return a;
    }

    @Override
    public List getRemarkListByAid(String id) {
        List<ActivityRemark> list = activityRemarkDao.getRemarkListByAid(id);
        return list;
    }

    @Override
    public Boolean deleteRemark(String id) {
        if(activityRemarkDao.deleteRemark(id) == 1){
            return true;
        }
        return false;
    }

    @Override
    public Boolean saveActivityRemark(ActivityRemark ar) {
        if (activityRemarkDao.saveActivityRemark(ar) == 1){
            return true;
        }
        return false;
    }

    @Override
    public Boolean editRemark(Map<String, Object> map) {
        if (activityRemarkDao.editRemark(map) == 1){
            return true;
        }
        return false;
    }
}
