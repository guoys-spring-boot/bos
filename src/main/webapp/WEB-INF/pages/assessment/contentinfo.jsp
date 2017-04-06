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
            <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
        </c:if>
        <c:if test="${action eq 'update'}">
            <a id="update" icon="icon-save" href="#" class="easyui-linkbutton" plain="true">保存</a>
        </c:if>
    </div>
</div>
<div region="center" style="height:600px;overflow:auto;padding:5px;" border="false">
    <form:form id="contentForm" method="post" commandName="assessmentContent"
               action="${path}/assessmentContent/addContent">
        <div region="north" border="false" style="overflow: auto">
            <table class="table-edit" width="95%" align="center">
                <tr>
                    <td>考核类型:</td>
                    <td><form:input path="type" disabled="${disabled}" type="text" class="easyui-validatebox"
                                    required="true"/></td>
                    <td>考核总分:</td>
                    <td><form:input path="totalScore" disabled="${disabled}" type="text" class="easyui-validatebox"
                                    required="true"/></td>
                </tr>
                <tr>
                    <td>考核项目:</td>
                    <td colspan="3">
                        <form:textarea path="projectName" disabled="${disabled}" style="width:84%" required="true"/>
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
            <div style="width: 670px; height: 300px">
                <table id="grid" ></table>
            </div>
        </div>
    </form:form>
    <script type="text/javascript">
        var grid = $("#grid");


        $(function () {

            $("#save").click(function () {
                var contentForm = $("#contentForm");
                if (contentForm.form('validate')) {
                    contentForm.submit();
                }
            });

            $("#update").click(function () {
                var userForm = $("#useForm");
                if (userForm.form('validate')) {
                    userForm.attr("action", "${path}/business/updateUnit");
                    userForm.submit();
                }
            });

            $.enumCombobox('type', 'assessmentType');

        });

        function doAdd() {

            grid.datagrid('insertRow', {row:{}});

        }

        function onClickRow(rowIndex) {
            $("#grid").datagrid('beginEdit', rowIndex);
        }

        function deleteRow(rowIndex) {
            alert($(this).html());
            $("#grid").datagrid('deleteRow', rowIndex);
        }

        var columns = [[{
            field: 'totalScore',
            title: '考核评分项',
            width: 190,
            editor:{
                type: "textarea",
                options:{
                    required: true
                }
            }
        }, {
            field: 'unitType',
            title: '报送说明',
            width: 335
        }, {
            field: 'unitProperty',
            title: '考核分数',
            width: 60
        },{
            field: 'delRow',
            title: '操作',
            width: 50,
            formatter : function(value, row, rowIndex){
                return "<a href='#' onclick='deleteRow("+rowIndex+")'>删除</a>"
            }
        }]];

        var toolbar = [{
            id: 'button-add',
            text: '新增一行',
            iconCls: 'icon-add',
            handler: doAdd
        }];

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
            onClickRow : onClickRow,
            data: [{
                "id":"id",
                "totalScore": "单位没有建立精神文明建设组织领导机构的扣1分",
                "unitType": "上传单位建立精神文明建设组织领导机构的文稿电子版，落款处有单位印章",
                "unitProperty": "1.0",
                "delRow":""
            }],
            //url : "/assessmentContent/listContent",
            idField: 'id',
            columns: columns
        });


    </script>
</div>
</body>
</html>