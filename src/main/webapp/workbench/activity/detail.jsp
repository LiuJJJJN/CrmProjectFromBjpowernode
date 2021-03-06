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
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">

        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;

        $(function () {
            $("#remark").focus(function () {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function () {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });

            $(".remarkDiv").mouseover(function () {
                $(this).children("div").children("div").show();
            });

            $(".remarkDiv").mouseout(function () {
                $(this).children("div").children("div").hide();
            });

            $(".myHref").mouseover(function () {
                $(this).children("span").css("color", "red");
            });

            $(".myHref").mouseout(function () {
                $(this).children("span").css("color", "#E6E6E6");
            });

            //页面加载完毕后，显示该页面的备注
            showRemarkList();

            //为备注添加动画效果
            $("#remarkBody").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            })
            $("#remarkBody").on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            })

            //点击备注信息的保存时
            $("#saveBtn").click(function(){
                $.post("workbench/activity/saveRemark.do", {
                    "noteContent":$("#remark")[0].value,
                    "activityId":"${a.id}"
                }, function (resp) {
                    /*
                        resp:
                            {"success":true/false
                             "ar":{"id":xxx,"name":xxx....}
                             }
                     */
                    if(resp.success){
                        $("#remarkDiv").before('' +
                            '<div id="'+resp.ar.id+'" class="remarkDiv" style="height: 60px;">' +
                            '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">' +
                            '<div style="position: relative; top: -40px; left: 40px;">' +
                            '<h5 id="e'+n.id+'">' + resp.ar.noteContent + '</h5>' +
                            '<font color="gray">市场活动</font> ' +
                            '<font color="gray">-</font> ' +
                            '<b>${a.name}</b> <small style="color: gray;" id="s'+n.id+'">' + (resp.ar.createTime) + ' 由 ' + (resp.ar.createBy) + '</small>' +
                            '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">' +
                            '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+resp.ar.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
                            '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+resp.ar.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>' +
                            '</div>' +
                            '</div>' +
                            '</div>'
                        );
                        $("#remark").val("");
                    }else{
                        alert("删除失败！");
                    }
                }, "json");
            });

            //点击备注修改中的更新按钮时
            $("#updateRemarkBtn").click(function (){
                $.post("workbench/activity/editRemark.do", {
                        "id": $("#remarkId").val(),
                        "noteContent": $("#noteContent")[0].value,
                        "editBy":"${user.name}"
                    }
                    , function (resp) {
                    /*
                        resp:
                            {
                                "success":"true/false
                                "ar":{"id":xxx,....}
                            }
                     */
                    if (resp.success){
                        //暂时修改页面内容
                        $("#e"+$("#remarkId").val()).text(resp.ar.noteContent);
                        $("#s"+$("#remarkId").val()).text(resp.ar.editTime+" 由 "+resp.ar.editBy);
                        //关闭修改备注的模态窗口
                        $("#editRemarkModal").modal("hide");
                    }else{
                        alert("修改失败！");
                    }
                }, "json");
            });

        });

        //显示该页面的备注
        function showRemarkList() {
            //使用ajax获取备注列表,更新页面备注信息
            $.get("workbench/activity/getRemarkListByAid.do", "id=${a.id}", function (resp) {
                $.each(resp, function (i, n) {
                    $("#remarkBefore").after('' +
                        '<div id="'+n.id+'" class="remarkDiv" style="height: 60px;">' +
                        '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">' +
                        '<div style="position: relative; top: -40px; left: 40px;">' +
                        '<h5 id="e'+n.id+'">' + n.noteContent + '</h5>' +
                        '<font color="gray">市场活动</font> ' +
                        '<font color="gray">-</font> ' +
                        '<b>${a.name}</b> <small style="color: gray;" id="s'+n.id+'">' + (n.editFlag == 0 ? n.createTime : n.editTime) + ' 由 ' + (n.editFlag == 0 ? n.createBy : n.editBy) + '</small>' +
                        '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">' +
                        '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>&nbsp;&nbsp;&nbsp;&nbsp;' +
                        '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>' +
                        '</div>' +
                        '</div>' +
                        '</div>'
                    );
                })
            }, "json");
        }

        //删除备注
        function deleteRemark(id){
            $.post("workbench/activity/deleteRemark.do", "id="+id, function (resp) {
                /*
                    resp:
                        {"success":true/false}
                 */
                if(resp.success){
                    $("#"+id).remove();
                }else{
                    alert("删除失败！");
                }

            }, "json");
        }

        //修改备注
        function editRemark(id){
            //将id存入模态窗口的隐藏域中，以便模态窗口打开后读取
            $("#remarkId").val(id);

            //获取noteContent
            var noteContent = $("#e"+id).text();

            //将noteContent赋值给模态窗口中的textarea
            $("#noteContent")[0].value = noteContent;

            //打开修改备注的模态窗口
            $("#editRemarkModal").modal("show");
        }

    </script>

</head>
<body>

<!-- 修改市场活动备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="remarkId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="noteContent">
                            <%--这里是备注的内容--%>
                            </textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
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
                <h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
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
                            <input type="text" class="form-control" id="edit-startTime" value="2020-10-10">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-endTime" value="2020-10-20">
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

<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>市场活动-${a.name} <small>2020-10-10 ~ 2020-10-20</small></h3>
    </div>
    <div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
    </div>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${a.name}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>

    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">开始日期</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.startDate}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${a.endDate}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">成本</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${a.cost}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${a.createBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${a.createTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${a.editBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${a.editTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${a.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div style="position: relative; top: 30px; left: 40px;" id="remarkBody">
    <div class="page-header" id="remarkBefore">
        <h4>备注</h4>
    </div>

    <%--    在此异步添加备注--%>

    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>
