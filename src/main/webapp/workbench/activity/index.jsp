<%--
  Created by IntelliJ IDEA.
  User: 刘嘉宁
  Date: 2021/9/2
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <%--    <base href="<%=basePath%>">--%>

    <link href="../../jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="../../jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript" src="../../jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="../../jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="../../jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="../../jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <link rel="stylesheet" type="text/css" href="/jquery/bs_pagination/jquery.bs_pagination.min.css"/>
    <script type="text/javascript" src="/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="/jquery/bs_pagination/en.js"></script>

    <script type="text/javascript">

        $(function () {
            //页面加载时：刷新活动列表
            pageList(1, 2);

            //为所有日期相关输入框弹出日期选择器
            $(".time").datetimepicker({
                minView: "month",
                language: "zh-CN",
                format: "yyyy-mm-dd",
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });

            //点击查询时
            $("#searchBtn").click(function () {
                pageList(1, 2);
            });

            //点击添加时
            $("#addBtn").click(function () {

                //获取所有者数据
                $.ajax({
                    url: "getUserList.do",
                    data: "",
                    dataType: "json",
                    type: "get",
                    success: function (resp) {
                        var html = $("#create-marketActivityOwner");
                        html.empty();
                        $.each(resp, function (index, element) {
                            html.append("<option value=" + element.id + ">" + element.name + "</option>");
                        });
                        //设置默认所有者为当前登录用户
                        $("#create-marketActivityOwner").val("${user.id}");
                    }
                });
                //打开模态窗口
                $("#createActivityModal").modal("show");

            });

            //点击保存时执行添加操作
            $("#saveBtn").click(function () {
                $.ajax({
                    url: "save.do",
                    data: {
                        "owner": $("#create-marketActivityOwner").val().trim(),
                        "name": $("#create-marketActivityName").val().trim(),
                        "startDate": $("#create-startTime").val().trim(),
                        "endDate": $("#create-endTime").val().trim(),
                        "cost": $("#create-cost").val().trim(),
                        "description": $("#create-describe").val().trim()
                    },
                    type: "post",
                    dataType: "json",
                    success: function (resp) {
                        if (resp.success) {
                            //刷新市场活动列表
                            pageList(1, 2);

                            //关闭模态窗口
                            $("#createActivityModal").modal("hide");

                            //清空模态窗口数据
                            $("#activityAddForm")[0].reset();

                        } else {
                            alert("添加失败");
                        }
                    }
                })
            });

        });

        /**
         * 分页方法
         * @param pageNo 第几页
         * @param pageSize 每页几条记录
         */
        function pageList(pageNo, pageSize) {
            $.ajax({
                url: "pageList.do",
                data: {
                    "pageNo": pageNo,
                    "pageSize": pageSize,
                    "name": $("#search-name").val().trim(),
                    "owner": $("#search-owner").val().trim(),
                    "startDate": $("#search-startDate").val().trim(),
                    "endDate": $("#search-endDate").val().trim()
                },
                dataType: "json",
                type: "get",
                success: function (resp) {

                    $("#activityBody").empty();
                    $.each(resp.dataList, function (i, n) {
                        $("#activityBody").append('<tr class="active">' +
                            '<td><input type="checkbox" value="' + n.id + '"/></td>' +
                            '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'detail.html\';">' + n.name + '</a></td>' +
                            '<td>' + n.owner + '</td>' +
                            '<td>' + n.startDate + '</td>' +
                            '<td>' + n.endDate + '</td>' +
                            '</tr>');
                    });

                    //计算总页数
                    var totalPages = resp.total%pageSize == 0 ? resp.total/pageSize : parseInt(resp.total/pageSize)+1;

                    //分页插件
                    $("#activityPage").bs_pagination({
                        currentPage: pageNo, // 页码
                        rowsPerPage: pageSize, // 每页显示的记录条数
                        maxRowsPerPage: 20, // 每页最多显示的记录条数
                        totalPages: totalPages, // 总页数
                        totalRows: resp.total, // 总记录条数
                        visiblePageLinks: 3, // 显示几个卡片
                        showGoToPage: true,
                        showRowsPerPage: true,
                        showRowsInfo: true,
                        showRowsDefaultInfo: true,
                        onChangePage: function (event, data) {
                            pageList(data.currentPage, data.rowsPerPage);
                        }
                    });

                }
            });
        }

    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="activityAddForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">
                                <%--ajax添加内容--%>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label time">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="create-startTime">
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label time">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="create-endTime">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <option>zhangsan</option>
                                <option>lisi</option>
                                <option>wangwu</option>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName" value="发传单">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="edit-startTime" value="2020-10-10">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="edit-endTime" value="2020-10-20">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" value="5,000">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe">市场活动Marketing，是指品牌主办或参与的展览会议与公关市场活动，包括自行主办的各类研讨会、客户交流会、演示会、新产品发布会、体验会、答谢会、年会和出席参加并布展或演讲的展览会、研讨会、行业交流会、颁奖典礼等</textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" type="text" id="search-name">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" type="text" id="search-owner">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control time" type="text" id="search-startDate"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control time" type="text" id="search-endDate">
                    </div>
                </div>

                <button type="button" class="btn btn-default" id="searchBtn">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="addBtn" type="button" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="activityBody">

                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">
            <div id="activityPage">
                <%--此处使用分页组件--%>

            </div>

        </div>

    </div>

</div>
</body>
</html>
