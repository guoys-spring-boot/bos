<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <c:if test="${disabled != true}">
        <c:set var="disabled" value="false"/>
    </c:if>

    <c:if test="${sessionScope.user.needSubmit()}">
        <c:set var="url" value="${path}/assessmentContent/listContent"/>
    </c:if>
    <c:if test="${!sessionScope.user.needSubmit()}">
        <c:set var="url" value="${path}/assessmentContent/listContent?type=10"/>
    </c:if>
    <!-- 导入jquery核心类库 -->
    <jsp:include page="${pageContext.request.contextPath}/common/reference.jsp"/>
    <script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${path}/js/ueditor/ueditor.all.min.js"></script>

    <script type="text/javascript" src="${path}/js/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript">
        $(function () {
            $("body").css({visibility: "visible"});
        });


        var assessmentType = $.loadEnum('assessmentType');
        var options = {
            panelWidth: 670,
            idField: 'id',
            striped: true,
            value:'${submitContent.project.id}',
            nowrap: false,
            textField: 'projectName',
            pagination: true,
            url: '${url}',
            columns: [[
                {field: 'projectName', title: '考核项目', width: 470},
                {
                    field: 'type',
                    title: '考核类型',
                    width: 160,
                    formatter: function (value, row, index) {
                        return assessmentType[value];
                    }
                }
            ]]
        };

        function _download(id) {
            location.href = '${path}/submitContent/downloadAttachment?id=' + id;
        }

        $(function () {
            $("#assessmentProject").combogrid(options);
            $("#save").click(function () {

                if(!$("input[name='project.id']").val()){
                    $(this)._alert("考核项目不能为空");
                    return;
                }
                var changes = $("#attachmentGrid").datagrid('getChanges', 'inserted');
                var ids = [];
                for(var i = 0; i< changes.length; i++){
                    var record = changes[i];
                    ids.push(record.id);
                }
                $("input[name='content']").val(UE.getEditor('content').getContent());
                $("#needInsert").val(ids.join(","));
                $("#submitContentForm").submit();
            });

            $("#edit").click(function () {
                if(!$("input[name='project.id']").val()){
                    $(this)._alert("考核项目不能为空");
                    return;
                }
                var grid = $("#attachmentGrid");
                var changes = grid.datagrid('getChanges', 'inserted');
                var ids = [];
                for(var i = 0; i< changes.length; i++){
                    var record = changes[i];
                    ids.push(record.id);
                }
                $("input[name='content']").val(UE.getEditor('content').getContent());
                $("#needInsert").val(ids.join(","));

                var needDeletes = grid.datagrid('getChanges', 'deleted');
                var needDeleteIds = [];
                for(var j = 0; j< needDeletes.length; j++){
                    var deleteRecord = needDeletes[j];
                    needDeleteIds.push(deleteRecord.id);
                }

                $("#needDelete").val(needDeleteIds.join(","));

                $("#submitContentForm").attr("action", "${path}/submitContent/updateSubmitContent");
                $("#submitContentForm").submit();
            });

            var columns = [[{
                field : 'id',
                checkbox : true,
                rowspan : 1
            }, {
                field : 'name',
                title : '名称',
                width : 150,
                rowspan : 1,
                sortable : false,
                formatter: function (value, row, index) {
                    return "<a href='#' onclick='_download(\""+row.id+"\")'>"+value+"</a>"
                }
            }]];

            function doDelete() {
                var grid = $("#attachmentGrid");
                var selections = grid.datagrid('getSelections');
                for(var i = 0; i<selections.length; i++){
                    var index = grid.datagrid('getRowIndex', selections[i]);
                    grid.datagrid('deleteRow', index);
                }
            }


            var toolbar = [{
                id: 'button-add-row',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: doDelete
            }];


            $('#attachmentGrid').datagrid( {
                iconCls : 'icon-forward',
                fit : true,
                border : false,
                singleSelect:false,
                striped : true,
                toolbar : toolbar,
                height:'auto',
                nowrap:false,
                url : "${path}/submitContent/listAttachment?foreignKey=${submitContent.id}",
                idField : 'id',
                columns : columns
            });
        })
    </script>
</head>
<body class="easyui-layout" style="visibility:hidden;">
<div region="east" title="附件列表" icon="icon-forward" style="width:180px;overflow:auto;" split="false" border="true">
    <div style="width: 200px; height: 500px">
        <table id="attachmentGrid" ></table>
    </div>
    <input type="file" id="file" name="file">

</div>
<div region="center" style="overflow:hidden;" border="false">
    <form:form commandName="submitContent" id="submitContentForm" action="${path}/submitContent/addSubmitContent" method="post">
        <div region="north" style="height:41px;overflow:hidden;" split="false" border="false">
            <div class="datagrid-toolbar">
                <c:if test="${action eq 'add'}">
                    <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
                </c:if>
                <c:if test="${action eq 'edit'}">
                    <a id="edit" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
                </c:if>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <label for="assessmentProject">考核项目：</label>
                <c:if test="${disabled}">
                    <select id="assessmentProject" disabled="disabled" required="true" class="easyui-combogrid" name="project.id" style="width:400px;"></select>
                </c:if>
                <c:if test="${!disabled}">
                    <select id="assessmentProject" required="true" class="easyui-combogrid" name="project.id" style="width:400px;"></select>
                </c:if>
            </div>
        </div>
        <div region="center" split="false" border="false">
            <form:textarea  path="content"  disabled="${disabled}" />
            <script type="text/javascript">
                var width = $(window).width() * 0.80;
                var height = $(window).height() * 0.71;
                //$("#content").val('${submitContent.content}');
                //$("#assessmentProject").val('${project.id}');
                try {
                    var ue = UE.getEditor('content', {
                        initialFrameWidth: width,
                        initialFrameHeight: height,
                        readonly:${disabled}
                    });

                    $("#file").AjaxFileUpload({
                        action:"${path}/submitContent/upload",
                        onComplete: function(filename, response) {
                            $("#attachmentGrid").datagrid('insertRow', {
                                row:response
                            });
                            $("#file").val('');
                        }
                    })
                } catch (error) {
                    alert(error);
                }

            </script>
        </div>
        <input id="needInsert" name="needInsert" type="hidden" />
        <input name="content" type="hidden" />
        <input name="needDelete" id="needDelete" type="hidden" />
        <input name="id" id="id" type="hidden" value="${submitContent.id}" />
    </form:form>
</div>
</body>
</html>