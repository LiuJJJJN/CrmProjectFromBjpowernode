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
    <base href="<%=basePath%>">

    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css"/>
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

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
                //将查询内容存起来
                $("#hidden-name").val($("#search-name").val());
                $("#hidden-owner").val($("#search-owner").val());
                $("#hidden-startDate").val($("#search-startDate").val());
                $("#hidden-endDate").val($("#search-endDate").val());

                pageList(1, 2);
            });

            //点击添加时
            $("#addBtn").click(function () {

                //获取所有者数据
                $.ajax({
                    url: "workbench/activity/getUserList.do",
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
                    url: "workbench/activity/save.do",
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
                            pageList($("#activityPage").bs_pagination('getOption', 'currentPage') ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

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

            //点击全选时
            $("#chooseAll").click(function () {
                $(":checkbox:gt(0)").prop("checked", this.checked);
            });

            // 有效外层元素jq对象.on( "事件" , 需绑定元素的jq对象    , 回调函数)
            $("#activityBody").on("click", $(":checkbox:gt(0)"), function () {
                $("#chooseAll").prop("checked", $(":checkbox:gt(0)").length == $(":checkbox:gt(0):checked").length);
            });

            //点击删除按钮时
            $("#deleteBtn").click(function () {
                if ($(":checkbox:gt(0):checked").length == 0) {
                    alert("请选中至少一条数据！");
                } else {
                    if (confirm("确认删除吗？")) {
                        //请求参数
                        var param = "";
                        $.each($(":checkbox:gt(0):checked"), function (i, n) {

                            param += "id=" + n.value + "&"
                        });
                        param = param.substring(0, param.length - 1);

                        $.ajax({
                            url: "workbench/activity/delete.do",
                            data: param,
                            type: "post",
                            dataType: "json",
                            success: function (resp) {
                                if (resp.success) {
                                    pageList(1 ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                                } else {
                                    alert("删除失败！");
                                }
                            }
                        });
                    }
                }
            });

            //当点击修改按钮时
            $("#editBtn").click(function () {
                if ($(":checkbox:gt(0):checked").length != 1) {
                    alert("请选中一条数据！");
                } else {
                    var id = $(":checkbox:gt(0):checked").val();
                    //获取所有者数据
                    $.ajax({
                        url: "workbench/activity/getUserListAndActivity.do",
                        data: {
                            "id": id
                        },
                        dataType: "json",
                        type: "post",
                        success: function (resp) {
                            /*
                                resp:
                                    uList
                                    a
                             */
                            //刷新所有者列表
                            var html = $("#edit-owner");
                            html.empty();
                            $.each(resp.uList, function (index, element) {
                                html.append("<option value=" + element.id + ">" + element.name + "</option>");
                            });
                            //更新修改信息
                            $("#edit-id").val(resp.a.id);
                            $("#edit-name").val(resp.a.name);
                            $("#edit-owner").val(resp.a.owner);
                            $("#edit-startDate").val(resp.a.startDate);
                            $("#edit-endDate").val(resp.a.endDate);
                            $("#edit-cost").val(resp.a.cost);
                            $("#edit-description").val(resp.a.description);
                            //打开模态窗口
                            $("#editActivityModal").modal("show");
                        }
                    });
                }
            });

            //点击修改按钮时
            $("#updateBtn").click(function(){
                $.ajax({
                    url: "workbench/activity/update.do",
                    data: {
                        "id":$("#edit-id").val().trim(),
                        "owner": $("#edit-owner").val().trim(),
                        "name": $("#edit-name").val().trim(),
                        "startDate": $("#edit-startDate").val().trim(),
                        "endDate": $("#edit-endDate").val().trim(),
                        "cost": $("#edit-cost").val().trim(),
                        "description": $("#edit-description").val().trim()
                    },
                    type: "post",
                    dataType: "json",
                    success: function (resp) {
                        if (resp.success) {
                            //刷新市场活动列表
                                     //维持在当前页
                            pageList($("#activityPage").bs_pagination('getOption', 'currentPage') ,
                                     //维持每页记录数量
                                     $("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                            //关闭模态窗口
                            $("#editActivityModal").modal("hide");
                        } else {
                            alert("修改失败");
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
            //将全选的勾干掉
            $("#chooseAll").prop("checked", false);

            //将上次搜索的内容放到搜索框中搜索
            $("#search-name").val($("#hidden-name").val());
            $("#search-owner").val($("#hidden-owner").val());
            $("#search-startDate").val($("#hidden-startDate").val());
            $("#search-endDate").val($("#hidden-endDate").val());

            $.ajax({
                url: "workbench/activity/pageList.do",
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
                            '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.do?id='+n.id+'\';">' + n.name + '</a></td>' +
                            '<td>' + n.owner + '</td>' +
                            '<td>' + n.startDate + '</td>' +
                            '<td>' + n.endDate + '</td>' +
                            '</tr>');
                    });

                    //计算总页数
                    var totalPages = resp.total % pageSize == 0 ? resp.total / pageSize : parseInt(resp.total / pageSize) + 1;

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
<%--隐藏域，用于记录上次搜索内容--%>
<input type="hidden" id="hidden-name"/>
<input type="hidden" id="hidden-owner"/>
<input type="hidden" id="hidden-startDate"/>
<input type="hidden" id="hidden-endDate"/>


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
                    <input type="hidden" id="edit-id" />
                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-owner">

                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="edit-startDate">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="edit-endDate"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateBtn">更新</button>
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
                <button type="button" class="btn btn-default" id="editBtn"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" id="deleteBtn" class="btn btn-danger"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="chooseAll"/></td>
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
