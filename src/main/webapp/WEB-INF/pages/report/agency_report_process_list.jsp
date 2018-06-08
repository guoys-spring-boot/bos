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
                reload();
                $("#doExam").window('destroy');

            }
        };

        function doExam(id, projectId) {
            var url = "${path}/business/toExamPage?contentId=" + id + "&projectId=" + projectId;
            $(window).openWindow('doExam', url, 750, 570, '审核', dialogOptions);
        }

        function doOpenUnreportedPage(id, name) {
            var url = "${path}/page.do?module=report&resource=unreported_assessment_list&unitId=" + id;
            $(window)._openTab("tabs", url, name, window.top);
        }


        //定义冻结列
        var columns = [[{
            field: 'id',
            checkbox: true,
            rowspan: 1
        },
            {
                field: 'unitFullName',
                title: '单位名称',
                width: 330,
                rowspan: 1,
                sortable: false
            },
            {
                field: 'unitLevelText',
                title: '单位类型',
                width: 100,
                rowspan: 1,
                sortable: false
            },
            {
                field: 'totalContent',
                title: '总题目数',
                width: 130,
                rowspan: 1,
                sortable: false
            },
            {
                field: 'reported',
                title: '已上报题目数',
                width: 130,
                rowspan: 1,
                sortable: false
            },
            {
                field: 'scored',
                title: '已打分题目数',
                width: 130,
                rowspan: 1,
                sortable: false
            },
            {
                field: 'totalScore',
                title: '总分',
                width: 130,
                rowspan: 1,
                sortable: false
            }, {
                field: 'op',
                title: '操作',
                width: 130,
                rowspan: 1,
                sortable: false,
                formatter: function (i, row) {
                    return "<a href='#' onclick='doOpenUnreportedPage(\""+row.id+"\", \""+row.unitFullName+"\")'>审核此单位</a>"
                }
            }
        ]];

        function reload() {
            $("#grid").datagrid('reload', {
                unitFullName: $("#unitFullName").val()
            });
        }

        // 定义标题栏
        var frozenColumns = [[]];

        var assessmentType = $.loadEnum('assessmentType');
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
                toolbar: '#toolbar',
                height: 'auto',
                nowrap: true,
                url: "/business/listUnitProcess?unitId=${preParam.unitId}&unitLevel=${preParam.unitLevel}&privateUnit=${preParam.privateUnit}",
                idField: 'id',
                frozenColumns: frozenColumns,
                columns: columns
            });



            $("body").css({visibility: "visible"});

            $("#doExam").window('close');
            $("#queryBtn").click(reload);


        });

    </script>
</head>
<body class="easyui-layout" style="visibility:hidden;">


<div id="toolbar">
    <table class="table-edit" width="100%">
        <tr>
            <td>

                <b>单位名称</b><span class="operator"><a name="gender-opt" opt="all"></a></span>
                <input id="unitFullName" class="easyui-textbox" name="unitFullName" value="">

                <a id="queryBtn" href="#" class="easyui-linkbutton" plain="true" icon="icon-search">查询</a>
            </td>
        </tr>
    </table>
</div>
<div region="center" border="false">
    <table id="grid"></table>
</div>
</body>
</html>