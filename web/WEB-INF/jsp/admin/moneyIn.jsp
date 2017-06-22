<%--
  Created by IntelliJ IDEA.
  User: mzzhang
  Date: 2017/5/29
  Time: 下午11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="head.jsp"/>

<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>订单缴费</h3>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>查看/编辑订单</h2>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <table id="userAdmiEdit-usersList">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function userAdminEdit(){
        $('#userAdmiEdit-usersList').bootstrapTable('refresh');
    }
    $($('#userAdmiEdit-usersList').bootstrapTable({
        afterLoad: function() {
            $.fn.editable.defaults.mode = 'popup';
            moneyInClick();
        },
        method: 'get',
        idField: 'id',
        url:'/admin/ordersListNotInMoney',
        classes: 'table table-striped table-condensed table-hover',
        columns: [{
            field: 'id',
            title: 'ID',
            align: 'center',
            valign: 'middle',
            visible: false
        }, {
            field: 'name',
            title: '姓名',
            align: 'center',
            valign: 'middle',
            editable:false,
            editableUrl: "post/userAdminEdit"
        }, {
            field: 'sfzh',
            title: '身份证',
            align: 'center',
            valign: 'middle',
            editable:false,
            editableUrl: "post/userAdminEdit",
            width: '15%'
        }, {
            field: 'inDate',
            title: '入住日期',
            align: 'center',
            valign: 'middle',
            editable:false,
            editableUrl: "post/userAdminEdit"
        },{
            field: 'type',
            title: '房型',
            align: 'center',
            valign: 'middle',
            width: '20%'
        }, {
            field: 'status',
            title: '状态',
            align: 'center',
            valign: 'middle',
            editable:false,
            editableUrl: "post/userAdminEdit",
            editableType: "textarea"
        }, {
            field: 'moneyIn',
            title: '缴费',
            align: 'center',
            valign: 'middle',
            width: '15%'
        }],
        pagination: true,
        sidePagination: 'client',
        pageSize: 20
    }));

    function moneyInClick() {
        $('#userAdmiEdit-usersList button').click(function (event) {
            var id = event.currentTarget.id;
            id = id.match(/(moneyIn-)([0-9]*)/)[2];
            id = parseInt(id);
            $.post('/admin/inMoney',{
                id: id,
            },function (res) {
                if(res.status == 1){
                    alert("缴费成功");
                }
                else {
                    alert(res.message);
                    console.log(res.message);
                }
            });
        });
    }


//    function moneyIn(orderId) {
//        var yes = function() {
//            $.post('/admin/inMoney', {
//                userId : userId
//            }, function (data) {
//                if(data.status == 0) {
//                    $('#errorAlert-content').html("删除失败："+data.message);
//                    $('#errorAlert').modal('show');
//                }
//                else userAdminEdit();
//            });
//        };
//        $('#confirmBox-yes').unbind();
//        $('#confirmBox-no').unbind();
//        $('#confirmBox-yes').click(yes);
//        $('#confirmBox-title').html("确认删除？");
//        $('#confirmBox-content').html("是否删除该用户？");
//        $('#confirmBox').modal('show');
//    }

</script>
<jsp:include page="footer.jsp"/>