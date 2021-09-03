package com.bjpn.crm.vo;

import java.util.List;

/**
 * VO : 抽象出来的业务对象,实现业务层的数据传递
 * @param <T> 元素
 * @author 刘嘉宁
 */
public class PaginationVO<T> {
    private Integer total; //list长度
    private List<T> dataList; //list数据

    public Integer getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    @Override
    public String toString() {
        return "paginationVO{" +
                "total=" + total +
                ", dataList=" + dataList +
                '}';
    }
}
