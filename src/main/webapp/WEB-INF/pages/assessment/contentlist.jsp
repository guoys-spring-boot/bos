<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- 导入jquery核心类库 -->
    <jsp:include page="${pageContext.request.contextPath}/common/reference.jsp"/>

    <script type="text/javascript">

        var dialogOptions = {
            onDestroy: function () {
                window.parent.reloadGrid();
                $("#addUserWindow").window('destroy');

            }
        };

        var grid = $("#grid");

        function openLookupPage(id) {

            var url = '${pageContext.request.contextPath}/assessmentContent/toLookupContent?contentId=' + id;
            $(window).openWindow('addUserWindow', url, 750, 770, '考核项目', dialogOptions);
        }

        function openEditPage(id) {
            if (!id) {
                alert("没有选中行");
                return;
            }
            var url = '${pageContext.request.contextPath}/assessmentContent/toUpdateContent?contentId=' + id;
            $(window).openWindow('addUserWindow', url, 750, 770, '考核项目', dialogOptions);

        }

        // 工具栏
        var toolbar = '#toolbar';


        //定义冻结列
        var frozenColumns = [];


        // 定义标题栏
        var columns = [[{
            field: 'id',
            checkbox: true,
            rowspan: 1
        }, {
            field: 'projectName',
            title: '考核项目',
            width: 400,
            rowspan: 1,
            sortable: false
        },
            {
                field: 'type',
                title: '考核类型',
                width: 180,
                rowspan: 1,
                sortable: false,
                formatter: function (value, row, index) {
                    return assessmentType[value];
                }
            }, {
                field: 'totalScore',
                title: '考核总分',
                width: 60,
                rowspan: 1
            }, {
                field: 'unitType',
                title: '是否上报',
                width: 70,
                rowspan: 1
            }, {
                field: 'unitProperty',
                title: '上报内容',
                width: 70,
                rowspan: 1
            }]];

        var assessmentType = $.loadEnum('assessmentType');

        // 双击
        function doDblClickRow(rowIndex, rowData) {
            openLookupPage(rowData.id);
        }
        // 单击
        function onClickRow(rowIndex) {
            //$("#grid").datagrid('beginEdit', rowIndex);
        }

        function doEdit() {
            var items = $('#grid').datagrid('getSelections');
            if (items.length <= 0) {
                $(this)._alert("没有选中行");
                return;
            }
            if (items.length > 1) {
                $(this)._alert("不能选中多行");
                return;
            }
            openEditPage(items[0].id);
        }


        function doAdd() {
            $(window).openWindow('addUserWindow', '${path}/assessmentContent/toAddContent', 750, 770, '考核项目', dialogOptions);

        }
        function doDelete() {
            var grid = $('#grid');
            var items = grid.datagrid('getSelections');
            if (items.length <= 0) {
                $(this)._alert("没有选中行");
                return;
            }
            $(this)._confirm("确定删除吗?", function () {
                var ids = [];

                for (var i = 0; i < items.length; i++) {
                    ids.push(items[i].id);
                }

                $.ajax("${path}/assessmentContent/deleteContent", {
                    data: {
                        ids: ids.join(",")
                    },
                    success: function (data) {
                        $("#grid").datagrid('reload');
                        //grid.datagrid('uncheckAll');
                    }
                });
            });

        }

        $(function () {
            // 初始化 datagrid
            // 创建grid
            $('#grid').datagrid({
                iconCls: 'icon-forward',
                pagination: true,
                pageSize: 20,
                fit: true,
                fitColumns: true,
                border: false,
                singleSelect: true,
                rownumbers: true,
                striped: true,
                toolbar: toolbar,
                height: 'auto',
                nowrap: false,
                url: "${path}/assessmentContent/listContent",
                idField: 'id',
                frozenColumns: frozenColumns,
                columns: columns,
                onClickRow: onClickRow,
                onDblClickRow: doDblClickRow
            });

            var pager = $("#grid").datagrid("getPager");
            if (pager) {
                pager.pagination({
                    onBeforeRefresh: function () {
                        //alert('before refresh');
                    }
                })
            }


            $("body").css({visibility: "visible"});

            $("#addUserWindow").window('close');

            $.enumCombobox('assessmentType', 'assessmentType', '', '请选择');

            $("#queryBtn").click(function () {
                $("#grid").datagrid('reload', {
                    type: $("input[name='assessmentType']").val()
                })
            })
        });

    </script>
</head>
<body class="easyui-layout" style="visibility:hidden;">
<div id="toolbar">
    <table class="table-edit" width="100%">
        <tr>
            <td>
                <b>考核类型</b><span class="operator"><a name="birthday-opt" opt="date"></a></span>
                <input id="assessmentType" name="assessmentType" value="">
                <a id="queryBtn" href="#" class="easyui-linkbutton" plain="true" icon="icon-search">查询</a>
            </td>
        </tr>
        <tr>
            <td>
                <a href="#" class="easyui-linkbutton" onclick="doEdit()" data-options="iconCls:'icon-edit',plain:true">修改</a>
                <a href="#" class="easyui-linkbutton" onclick="doAdd()"
                   data-options="iconCls:'icon-add',plain:true">新增</a>
                <a href="#" class="easyui-linkbutton" onclick="doDelete()"
                   data-options="iconCls:'icon-cancel',plain:true">删除</a>
            </td>
        </tr>
    </table>
</div>

<div region="center" border="false">
    <table id="grid"></table>
</div>
</body>
</html>