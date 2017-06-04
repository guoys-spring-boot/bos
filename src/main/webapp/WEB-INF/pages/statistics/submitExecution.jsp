<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <jsp:include page="${pageContext.request.contextPath}/common/reference.jsp"/>
    <script type="text/javascript">
        $(function () {
            $("#grid").treegrid({
                toolbar: [],
                url: '${pageContext.request.contextPath}/statistics/listSubmitExecutions',
                idField: 'id',
                treeField: 'unitName',
                columns: [[
                    {
                        field: 'id',
                        title: '编号',
                        width: 100,
                        hidden: true
                    },
                    {
                        field: 'unitName',
                        title: '单位名称',
                        width: 400
                    },
                    {
                        field: 'unitType',
                        title: '单位类型',
                        width: 60
                    },
                    {
                        field: 'totalCount',
                        title: '总题目数',
                        align: 'right',
                        width: 60
                    },
                    {
                        field: 'completedCount',
                        title: '已完成题目数',
                        align: 'right',
                        width: 80
                    },
                    {
                        field: 'unCompleteCount',
                        title: '未完成题目数',
                        align: 'right',
                        width: 80
                    },
                    {
                        field: 'totalScore',
                        title: '得分情况',
                        align: 'right',
                        width: 60
                    },
                    {
                        field: 'completePercent',
                        title: '完成率',
                        align: 'right',
                        width: 50,
                        formatter: function (value, row) {
                            if(!row.totalCount || Number(row.totalCount) == 0){
                                return '';
                            }
                            return Math.round((row.completedCount / row.totalCount) * 100) + '%';
                        }
                    }
                ]]
            });
        });
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'center'">
    <table id="grid"></table>
</div>
</body>
</html>