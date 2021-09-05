package com.bjpn.crm.workbench.dao;

import com.bjpn.crm.utils.SqlSessionUtil;
import com.bjpn.crm.workbench.domain.Activity;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityDaoTest {
    @Test
    public void testDeleteById() {
        SqlSession sqlSession = null;
        try {
            sqlSession = SqlSessionUtil.getSqlSession();
            ActivityDao mapper = sqlSession.getMapper(ActivityDao.class);

            Integer totalByCondition = mapper.deleteById("5f627dd6e3ed41c88346ec21e38fda2f");
            System.out.println(totalByCondition);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
    }

    @Test
    public void testGetTotalByCondition() {
        SqlSession sqlSession = null;
        try {
            sqlSession = SqlSessionUtil.getSqlSession();
            ActivityDao mapper = sqlSession.getMapper(ActivityDao.class);
            Map<String, Object> map = new HashMap<>();
            map.put("skipCount", 0);
            map.put("pageSize", 2);
            map.put("name", '1');

            Integer totalByCondition = mapper.getTotalByCondition(map);
            System.out.println(totalByCondition);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }


    }

    @Test
    public void testGetActivityListByCondition() {
        SqlSession sqlSession = null;
        try {
            sqlSession = SqlSessionUtil.getSqlSession();
            ActivityDao mapper = sqlSession.getMapper(ActivityDao.class);
            Map<String, Object> map = new HashMap<>();
            map.put("skipCount", 0);
            map.put("pageSize", 2);
            map.put("name", "1");

            List<Activity> activityList = mapper.getActivityListByCondition(map);
            System.out.println(activityList);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sqlSession.close();
        }
    }

}
