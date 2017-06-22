<%--
  Created by IntelliJ IDEA.
  User: mzzhang
  Date: 2017/5/29
  Time: 下午11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #roomRadios input{
        margin:0 30px;
    }
</style>
<jsp:include page="head.jsp"/>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">入住</h4>
            </div>
            <div class="modal-body" id="roomRadios">
                <%--<input type="radio" />--%>
            </div>
            <div class="modal-footer">
                <button id="roomOk" type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>


<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>房间入住</h3>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>查看/编辑入住情况</h2>
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
            roomInClick();
        },
        method: 'get',
        idField: 'id',
        url:'/admin/ordersListNotInRoom',
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
            field: 'roomIn',
            title: '选房',
            align: 'center',
            valign: 'middle',
            width: '15%'
        }],
        pagination: true,
        sidePagination: 'client',
        pageSize: 20
    }));

    function roomInClick() {
        $('#userAdmiEdit-usersList button').click(function (event) {
            var id = event.currentTarget.id;
            id = id.match(/(roomIn-)([0-9]*)/)[2];
            id = parseInt(id);
            $.post('/admin/roomNumberListCanSelect',{
                "order_id": id
            },function (roomList) {
                var radiosHtml = '';
                for(var i=0; i<roomList.length; i++){
                    radiosHtml += '<label><input type="radio" name="roomIn" value="' +roomList[i].id+ '"/>'+ roomList[i].roomNumber +'</label>';
                }
                $('#roomRadios').html(radiosHtml);
            });
            yes = function(){
                var okId = $("input[name='roomIn']:checked").val();
                $.post('/admin/checkIn',{
                    order_id: id,
                    roomNumberId: okId
                },function (res) {
                    if(res.status == 1){
                        $('#userAdmiEdit-usersList').bootstrapTable('refresh');
                    }
                    else {
                        alert(res.message);
                    }
                });
            }
            $('#roomOk').click(yes);
        });
    }

</script>
<jsp:include page="footer.jsp"/>