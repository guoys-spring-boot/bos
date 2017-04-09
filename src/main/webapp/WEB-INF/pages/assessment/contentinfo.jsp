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
<div region="center" style="height:600px;overflow:auto;padding:5px;" border="false">
    <div region="north" border="false" style="overflow: auto">

    <form:form id="contentForm" method="post" commandName="assessmentContent"
               action="${path}/assessmentContent/addContent">
            <table class="table-edit" width="95%" align="center">
                <tr>
                    <td>考核类型:</td>
                    <td><form:input path="type" disabled="${disabled}" type="text"
                                    required="true"/></td>
                    <td>考核总分:</td>
                    <td><form:input path="totalScore" disabled="${disabled}" type="text" class="easyui-numberbox" precision="2"
                                    required="true"/></td>
                </tr>
                <tr>
                    <td>考核项目:</td>
                    <td colspan="3">
                        <form:textarea path="projectName" disabled="${disabled}" rows="5" style="width:84%" required="true"/>
                    </td>

                </tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                </tr>
                <tr class="title">
                    <td colspan="4">考核评审标准:</td>
                </tr>
                <tr >
                    <td colspan="4">

                    </td>
                </tr>
                <form:hidden path="id"/>
            </table>
    </form:form>

        <div style="width: 700px; height: 250px">
                <table id="grid" ></table>
            </div>
        </div>
    <script type="text/javascript">
        var grid = $("#grid");

        $(function () {

            $("#contentSave").click(function () {

                if(!$("#projectName").val()){
                    $(this)._alert("考核项目不能为空");
                    return;
                }

                var contentForm = $("#contentForm");
                contentForm._addGridChanges("grid", "assessmentStdList", "inserted");
                if (contentForm.form('validate')) {
                    contentForm.form('submit', {
                        success:function () {
                           $(window).closeWindow('addUserWindow');
                        }
                    });
                }
                //contentForm.submit();
            });

            $("#update").click(function () {
                if(!$("#projectName").val()){
                    $(this)._alert("考核项目不能为空");
                    return;
                }
                var contentForm = $("#contentForm");
                contentForm._addGridChanges("grid", "needInserts", "inserted");
                contentForm._addGridChanges("grid", "needUpdates", "updated");
                contentForm._addGridChanges("grid", "needDeletes", "deleted");
                if (contentForm.form('validate')) {
                    contentForm.attr("action", "${path}/assessmentContent/updateContent");
                    contentForm.form('submit', {
                        success:function () {
                            $(window).closeWindow('addUserWindow');
                        }
                    })
                }
            });

            $.enumCombobox('type', 'assessmentType');

        });

        function doAdd() {
            grid.datagrid('insertRow', {row:{}});
        }

        function onClickCell(rowIndex, field) {
            grid.datagrid('beginEdit', rowIndex);
            var ed = grid.datagrid('getEditor', {index:rowIndex,field:field});
            $(ed.target).focus();
        }

        function deleteRow(target) {
            var tr = $(target).closest('tr.datagrid-row');
            var rowIndex =  parseInt(tr.attr('datagrid-row-index'));
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
            width: 335
        };


        var scoreCol = {
            field: 'score',
            title: '考核分数',
            width: 60
        };

        var delRow = {
            field: 'delRow',
            title: '操作',
            width: 50,
            formatter : function(value, row, rowIndex){
                return "<a href='#' onclick='deleteRow(this)'>删除</a>";
            }
        };
        var columns = [[itemCol, remarkCol, scoreCol]];
        var toolbar = [];
        if('${action}' == 'add' || '${action}' == 'update'){
            itemCol.editor = {
                type: "textarea",
                options:{
                    required: true
                }
            };
            remarkCol.editor = {
                type: "textarea",
                options:{
                    required: true
                }
            };
            scoreCol.editor = {
                type: "numberbox",
                options:{
                    required: true,
                    precision: 2

                }
            };
            columns[0].push(delRow);

            toolbar = [{
                id: 'button-add-row',
                text: '新增一行',
                iconCls: 'icon-add',
                handler: doAdd
            }];

        }


        grid.datagrid({
            iconCls: 'icon-forward',
            border: false,
            rownumbers:true,
            height: 'auto',
            singleSelect: true,
            striped: true,
            toolbar: toolbar,
            nowrap: false,
            fit:true,
            onDblClickCell : onClickCell,

            url : "${path}/assessmentContent/listContentStd?contentId=${assessmentContent.id}",
            idField: 'id',
            columns: columns
        });


    </script>
</div>
</body>
</html>