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

        var grid = $("#grid");
        function doLookup(id, title) {
            var url = "${path}/submitContent/toLookupSubmitContent?id=" + id;
            $(window)._openTab("tabs", url, title, window.top);
        }

        function doEdit(id, title) {
            var url = "${path}/submitContent/toEditSubmitContent?id=" + id;
            $(window)._openTab("tabs", url, title, window.top);
        }


        // 工具栏
        var toolbar = '#toolbar';


        //定义冻结列
        var frozenColumns = [[]];

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
            sortable: false,
            formatter: function (value, row) {
                if(row.project){
                    return row.project.projectName;
                }
                return value;
            }
        },
            {
                field: 'type',
                title: '考核类型',
                width: 180,
                rowspan: 1,
                sortable: false,
                formatter: function (value, row, index) {
                    if(!row.project){
                        return value;
                    }
                    return assessmentType[row.project.type];
                }
            },{
            field: 'project.totalScore',
            title: '考核总分',
            width: 60,
            rowspan: 1,
            formatter: function (value, row, index) {
                if(row.project){
                    return row.project.totalScore;
                }
                return value;
            }
            },
            {
                field: 'score',
                title: '考核得分',
                width: 60,
                rowspan: 1
            }, {
                field: 'op',
                title: '上报内容',
                width: 100,
                formatter: function (value, row, index) {
                    if(!row.project){
                        return value;
                    }
                    if (row.score == undefined || isNaN(row.project.totalScore) || Number(row.project.totalScore) == 0) {
                        return "<a href='#' onclick='doEdit(\"" + row.id + "\", \"" + row.project.projectName + "\")'>修改上报内容</a>";
                    }
                    return "<a href='#' onclick='doLookup(\"" + row.id + "\", \"" + row.project.projectName + "\")'>查看上报内容</a>";

                }
            }]];

        var assessmentType = $.loadEnum('assessmentType');
        $(function () {
            var grid = $('#grid');
            // 初始化 datagrid
            // 创建grid
            grid.datagrid({
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
                url: "${path}/submitContent/listSubmitContent",
                idField: 'id',
                frozenColumns: frozenColumns,
                columns: columns,
                showFooter: true
            });

            grid.datagrid({
                view: detailview,
                detailFormatter:function(index,row){
                    return '<div style="padding:2px"><table class="ddv"></table></div>';
                },
                onExpandRow: function(index,row){
                    var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
                    ddv.datagrid({
                        url:'${path}/submitContent/listScoreDetails?contentId='+row.id,
                        fitColumns:true,
                        singleSelect:true,
                        rownumbers:true,
                        height:'auto',
                        striped: true,
                        nowrap: false,
                        columns:[[
                            {
                                field:'item',
                                title:'考核评分项',
                                width:200,
                                formatter: function (value, row, index) {
                                    if(row.assessmentStd){
                                        return row.assessmentStd.item;
                                    }
                                    return value;
                                }
                            },
                            {
                                field:'remark',
                                title:'备注',
                                width:200,
                                formatter: function (value, row, index) {
                                    if(row.assessmentStd){
                                        return row.assessmentStd.remark;
                                    }
                                    return value;
                                }
                            },
                            {
                                field:'score',
                                title:'总分',
                                width:50,
                                formatter: function (value, row, index) {
                                    if(row.assessmentStd){
                                        return row.assessmentStd.score;
                                    }
                                    return value;
                                }
                            },
                            {
                                field:'getScore',
                                title:'得分',
                                width:50,
                                formatter: function (value, row, index) {
                                    if(row.score){
                                        return row.score;
                                    }
                                    return value;
                                }
                            }
                        ]],
                        onResize:function(){
                            grid.datagrid('fixDetailRowHeight',index);
                        },
                        onLoadSuccess:function(){
                            setTimeout(function(){
                                grid.datagrid('fixDetailRowHeight',index);
                            },0);
                        }
                    });
                    grid.datagrid('fixDetailRowHeight',index);
                }
            });

            $("body").css({visibility: "visible"});

        });


    </script>
</head>
<body class="easyui-layout" style="visibility:hidden;">

<div region="center" border="false">
    <table id="grid"></table>
</div>
</body>
</html>