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
        <c:set var="url" value="${path}/assessmentContent/listContentAsTree2"/>
    </c:if>
    <c:if test="${!sessionScope.user.needSubmit()}">
        <c:set var="url" value="${path}/assessmentContent/listContentAsTree2?type=10"/>
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
            panelWidth: 650,
            idField: 'id',
            striped: true,
            labelPosition:'left',
            value:'${submitContent.project.id}',
            nowrap: true,
            treeField:'projectName',
            textField: 'projectName',
            url: '${url}',
            onSelect: onSelect,
            columns: [[
                {
                    field: 'projectName',
                    title: '考核项目',
                    width: 470
                },
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

        function onSelect(row) {
            if(!row._parentId){
                throw new Error();
            }
            $("#contentDetails").datagrid('load', {
                "contentId" : row.id
            });
            //throw new Error();
        }

        $(function () {
            $("#assessmentProject").combotreegrid(options);
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

            if(${disabled}){
                toolbar = [];
            }


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
                    <select id="assessmentProject" disabled="disabled" required="true" class="easyui-combogrid" name="project.id" style="width:430px;"></select>
                </c:if>
                <c:if test="${!disabled}">
                    <select id="assessmentProject" required="true" class="easyui-combogrid" name="project.id" style="width:430px;"></select>
                </c:if>
            </div>
        </div>
        <div region="center" align="center" split="false" border="false">

            <div region="north" align="center" split="false" border="false">
                <table class="easyui-datagrid" id="contentDetails" style="height:100px"
                       data-options="url:'${path}/assessmentContent/listContentStd',fitColumns:true,singleSelect:true,striped: true,nowrap:false">
                    <thead>
                    <tr>
                        <th data-options="field:'item',width:70">考核评分项</th>
                        <th data-options="field:'remark',width:100">报送说明</th>
                        <th data-options="field:'score',width:30">总分</th>
                    </tr>
                    </thead>
                </table>
            </div>

            <div region="center" align="center" split="false" border="false">
            <form:textarea style="display:none"  path="content"  disabled="${disabled}"  />
            <script type="text/javascript">
                var width = $(window).width() * 0.85;
                var height = $(window).height() * 0.63;
                //$("#content").val('${submitContent.content}');
                //$("#assessmentProject").val('${project.id}');
                try {
                    var ue = UE.getEditor('content', {
                        initialFrameWidth: width,
                        initialFrameHeight: height,
                        readonly:${disabled}
                    });

                    ue.ready(function () {
                       $("#content").show();
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
        </div>
        <input id="needInsert" name="needInsert" type="hidden" />
        <input name="needDelete" id="needDelete" type="hidden" />
        <input name="id" id="id" type="hidden" value="${submitContent.id}" />
    </form:form>
</div>
</body>
</html>