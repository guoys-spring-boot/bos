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
</head>
<body class="easyui-layout">
<div region="north" style="height:31px;overflow:hidden;" split="false" border="false">
    <div class="datagrid-toolbar">
        <c:if test="${action eq 'add'}">
            <a id="contentSave" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
        </c:if>
        <c:if test="${action eq 'update'}">
            <a id="update" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
        </c:if>
    </div>
</div>
<div region="center" style="overflow:auto;padding:5px;" border="false">
    <div region="north" border="false" style="overflow: auto">

        <form:form id="contentForm" method="post" commandName="assessmentContent"
                   action="${path}/busines/addScore">
            <table class="table-edit" width="95%" align="center">
                <tr>
                    <td>考核类型:</td>
                    <td><form:input path="type" disabled="true" type="text"
                                    required="true"/></td>
                    <td>考核总分:</td>
                    <td><form:input path="totalScore" disabled="true" type="text" class="easyui-numberbox" precision="2"
                                    required="true"/></td>
                </tr>
                <tr>
                    <td>考核项目:</td>
                    <td colspan="3">
                        <form:textarea path="projectName" disabled="true" rows="5" style="width:84%" required="true"/>
                    </td>

                </tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                </tr>

                <form:hidden path="id"/>
                <input type="hidden" id="scores" name="scores"/>
            </table>
        </form:form>

        <div style="width: 650px; height: 250px">
            <table id="grid"></table>
        </div>
    </div>
    <script type="text/javascript">
        var grid = $("#grid");

        $(function () {

            $("#contentSave").click(function () {
                var url = '${path}/business/addScore';
                var contentForm = $("#contentForm");
                var scores = [];
                var grid = $("#grid");
                var rows = grid.datagrid('getRows');
                for (var i = 0; i < rows.length; i++) {
                    var rowIndex = grid.datagrid('getRowIndex', rows[i]);
                    grid.datagrid('endEdit', rowIndex);
                }

                for (var j = 0; j < rows.length; j++) {
                    var update = rows[j];
                    var score = {};
                    score.stdId = update.id;
                    if (update.scored == null || isNaN(update.scored) || update.scored == '' || update.scored == undefined) {
                        $(this)._alert("分数为必填项");
                        return false;
                    }

                    if (update.scored > update.score) {
                        $(this)._alert("分数不能大于总分");
                        return false;
                    }
                    score.score = update.scored;
                    score.remark = update.beizhu;
                    score.contentId = '${contentId}';
                    scores.push(score);
                }
                $.ajax(url, {
                    type: 'post',
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(scores),
                    success: function () {
                        $(window).closeWindow('doExam');
                    },
                    async: false,
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(JSON.stringify(XMLHttpRequest, null, 4));
                    }
                });
            });

            $.enumCombobox('type', 'assessmentType');

        });


        function onClickCell(rowIndex, field) {
            grid.datagrid('beginEdit', rowIndex);
            var ed = grid.datagrid('getEditor', {index: rowIndex, field: field});
            $(ed.target).focus();
        }

        function deleteRow(target) {
            var tr = $(target).closest('tr.datagrid-row');
            var rowIndex = parseInt(tr.attr('datagrid-row-index'));
            grid.datagrid('deleteRow', rowIndex);
        }

        var itemCol = {
            field: 'item',
            title: '考核评分项',
            width: 190
        };

        var remarkCol = {
            field: 'remark',
            title: '报送说明',
            width: 200
        };


        var scoreCol = {
            field: 'score',
            title: '考核分数',
            width: 60
        };


        var columns = [[itemCol, remarkCol, scoreCol, {
            field: 'scored',
            title: '考核得分',
            width: 60,
            editor: {
                type: "numberbox",
                options: {
                    required: true,
                    precision: 2
                }
            }
        }, {
            field: 'beizhu',
            title: '备注',
            width: 150,
            editor: {
                type: "textarea"
            }
        }]];
        var toolbar = [];

        grid.datagrid({
            iconCls: 'icon-forward',
            border: false,
            rownumbers: true,
            height: 'auto',
            singleSelect: true,
            striped: true,
            toolbar: toolbar,
            nowrap: false,
            fit: true,
            fitColumns: true,
            onDblClickCell: onClickCell,

            url: "${path}/assessmentContent/listContentStd?contentId=${assessmentContent.id}",
            idField: 'id',
            columns: columns
        });


    </script>
</div>
</body>
</html>