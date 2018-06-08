<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- 导入jquery核心类库 -->
    <!-- 导入jquery核心类库 -->
    <jsp:include page="${pageContext.request.contextPath}/common/reference.jsp"/>
    <script type="text/javascript">

        var dialogOptions = {
            onDestroy: function () {
                $("#editRoleWindow").window('destroy');

            }
        };

        function doEdit() {
            var item = $('#grid').datagrid('getSelected');
            var id = item.id;

            var url = '${pageContext.request.contextPath}/role_toEdit?id=' + id;
            $(window).openWindow('editRoleWindow', url, 750, 570, '用户管理', dialogOptions);

        }

        $(function () {
            $("#addRoleWindow").window('close');
            // 数据表格属性
            $("#grid").datagrid({
                toolbar: [
                    {
                        id: 'add',
                        text: '添加角色',
                        iconCls: 'icon-add',
                        handler: function () {
                            var roleWindow = $("#addRoleWindow");
                            //location.href='${pageContext.request.contextPath}/page.do?module=admin&resource=role_add';
                            roleWindow.window('refresh', '${pageContext.request.contextPath}/page.do?module=admin&resource=role_add');
                            roleWindow.window('open');

                        }
                    }, {
                        id: 'edit',
                        text: '修改',
                        iconCls: 'icon-edit',
                        handler: doEdit
                    }
                ],
                url: '${pageContext.request.contextPath}/role_list.do',
                singleSelect:true,
                columns: [[
                    {
                        field: 'id',
                        title: '编号',
                        width: 200,
                        hidden: true
                    },
                    {
                        field: 'name',
                        title: '名称',
                        width: 200
                    },
                    {
                        field: 'description',
                        title: '描述',
                        width: 200
                    }
                ]]
            });
        });
    </script>
</head>
<body class="easyui-layout">

<div class="easyui-window" title="角色管理" id="addRoleWindow" collapsible="false" minimizable="false" maximizable="false"
     style="top:20px;left:100px;width: 800px; height: 500px; z-index: 1000">
</div>

<div data-options="region:'center'">
    <table id="grid"></table>
</div>
</body>
</html>