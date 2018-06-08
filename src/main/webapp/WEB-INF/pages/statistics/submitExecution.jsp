<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <jsp:include page="${pageContext.request.contextPath}/common/reference.jsp"/>
    <script type="text/javascript">
        $(function () {
            $("#grid").treegrid({
                toolbar: '#toolbar',
                url: '${pageContext.request.contextPath}/statistics/listSubmitExecutions',
                idField: 'id',
                fit: true,
                fitColumns: true,
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
                        title: '完成进度',
                        align: 'left',
                        width: 50,
                        formatter: function (value, row) {
                            var progress = 0;
                            if(!row.totalCount || Number(row.totalCount) == 0){
                                progress = 0;
                            }else{
                                progress = Math.round((row.completedCount / row.totalCount) * 100);
                            }

                            var str = progress + '%';
                            return '<progress value="'+progress+'" max="100" style="width: 95%"><span>'+str+'</span>></progress>';
                            //return '<div class="easyui-progressbar" data-options="value:' + progress + '" style="width: auto" ></div>'
                        }
                    }
                ]]
            });
            $.enumComboboxFromUrl('unitId', '${path}/business/listAllParentUnit');
            $("#queryBtn").click(function () {
                $("#grid").treegrid('load', {
                    unitId: $("input[name='unitId']").val()
                })

                $(".easyui-progressbar").progressbar();
            });
            $("#excel").click(function () {
                window.location = '${path}/statistics/excelSubmitExecutions?unitId=' + $("input[name='unitId']").val();
            });
        });
    </script>
</head>
<body class="easyui-layout">
<div id="toolbar">
    <table class="table-edit" width="100%" >
        <tr>
            <td>
                <b>单位</b><span class="operator"><a name="birthday-opt" opt="date"></a></span>

                <c:if test="${sessionScope.user.isAdmin()}">
                    <input type="text" id="unitId" value="${sessionScope.user.id}" name="unitId"/>
                </c:if>
                <c:if test="${!sessionScope.user.isAdmin()}">
                    <input readonly="readonly" type="text" id="unitId" value="${sessionScope.user.id}" name="unitId"/>
                </c:if>

                <a id="queryBtn" href="#" class="easyui-linkbutton" plain="true" icon="icon-search">查询</a>
                <a id="excel" href="#" class="easyui-linkbutton" plain="true" icon="icon-search">导出excel</a>
            </td>
        </tr>
    </table>
</div>
<div data-options="region:'center'">
    <table id="grid"></table>
</div>
</body>
</html>