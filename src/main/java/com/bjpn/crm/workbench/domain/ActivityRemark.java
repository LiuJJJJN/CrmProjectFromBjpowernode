package com.bjpn.crm.workbench.domain;

import lombok.Data;

@Data
public class ActivityRemark {
    private String id;  //主键
    private String noteContent; //备注信息
    private String createTime;  //
    private String createBy;    //
    private String editTime;    //
    private String editBy;  //
    private String editFlag;    //是否修改过
    private String activityId;  //
}
