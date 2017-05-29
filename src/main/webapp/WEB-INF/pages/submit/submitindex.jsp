<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <style type="text/css">

        .spinner {
            margin: 100px auto;
            width: 50px;
            height: 60px;
            text-align: center;
            font-size: 10px;
        }

        .spinner > div {
            background-color: #67CF22;
            height: 100%;
            width: 6px;
            display: inline-block;

            -webkit-animation: stretchdelay 1.2s infinite ease-in-out;
            animation: stretchdelay 1.2s infinite ease-in-out;
        }

        .spinner .rect2 {
            -webkit-animation-delay: -1.1s;
            animation-delay: -1.1s;
        }

        .spinner .rect3 {
            -webkit-animation-delay: -1.0s;
            animation-delay: -1.0s;
        }

        .spinner .rect4 {
            -webkit-animation-delay: -0.9s;
            animation-delay: -0.9s;
        }

        .spinner .rect5 {
            -webkit-animation-delay: -0.8s;
            animation-delay: -0.8s;
        }

        @-webkit-keyframes stretchdelay {
            0%, 40%, 100% { -webkit-transform: scaleY(0.4) }
            20% { -webkit-transform: scaleY(1.0) }
        }

        @keyframes stretchdelay {
            0%, 40%, 100% {
                transform: scaleY(0.4);
                -webkit-transform: scaleY(0.4);
            }  20% {
                   transform: scaleY(1.0);
                   -webkit-transform: scaleY(1.0);
               }
        }

        #mask {
            position: absolute; top: 0px; filter: alpha(opacity=60); background-color: #777;
            z-index: 9999; left: 0px;
            opacity:0.5; -moz-opacity:0.5;
            display: none;
        }
    </style>
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

            if("${saveSuccess}" == "true"){
                $(this)._alert("保存成功");
            }
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
            rowStyler: function (row) {
                if(row.alreadySubmit){
                    return 'background-color:#FF0000;';
                }
            },
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

        String.prototype.endWith=function(str){
            var reg=new RegExp(str+"$");
            return reg.test(this);
        };
        var images = ['.png', '.jpg', '.jpeg'];
        var previews = ['.doc', '.xls', '.docx', '.xlsx'];
        function _download(id, name) {
            var url = '${path}/submitContent/downloadAttachment?id=' + id;
            if(name == null || name == undefined){
                location.href = url;
                return;
            }

            if(isImage(name)){
                $("#imagePreview").find("img").attr("src", url);
                $("#imagePreview").window('open');
                return;
            }
            if(isPreview(name)){
                var previewUrl = 'http://ow365.cn/?i=12491&furl=http://61.136.205.130:8089' + url;
                $(window)._openTab("tabs", previewUrl, "预览", window.top);
                return;
            }
            location.href = url;
        }

        function isPreview(name) {
            if(name == null || name == undefined){
                return false;
            }
            var result = false;
            $.each(previews, function (index, item) {

                if(name.toLowerCase().endWith(item)){
                    result = true;
                }
            });

            return result;
        }

        function isImage(name) {
            if(name == null || name == undefined){
                return false;
            }
            var result = false;
            $.each(images, function (index, item) {

                if(name.toLowerCase().endWith(item)){
                    result = true;
                }
            });

            return result;
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

        function checkAlreadySubmit() {
            var contentId = $("#id").val();
            var projectId = $("input[name='project.id']").val();

            var result = false;
            $.ajax("${path}/submitContent/checkAlreadySubmit", {
                data: {
                    contentId: contentId,
                    projectId: projectId
                },
                async : false,
                success: function (data) {
                    if(data == true || data == "true"){
                        result = true;
                    }
                },
                error: function (jqXHR) {
                    alert(JSON.stringify(jqXHR, null, 4));
                    result = true;
                }

            });
            if(result){
                $(this)._alert("该考核项目已经上报过");
                return false;
            }

            return true;
        }

        function showMask() {
            $("#mask").css("height",$(document).height());
            $("#mask").css("width",$(document).width());
            $("#mask").show();
        }

        function hideMask() {
            $("#mask").hide();
        }

        $(function () {
            $("#assessmentProject").combotreegrid(options);
            $("#save").click(function () {
                showMask();
                if(!$("input[name='project.id']").val()){
                    $(this)._alert("考核项目不能为空");
                    hideMask();
                    return;
                }

                if(!checkAlreadySubmit()){
                    hideMask();
                    return false;
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
                showMask();
                if(!$("input[name='project.id']").val()){
                    $(this)._alert("考核项目不能为空");
                    hideMask();
                    return;
                }

                if(!checkAlreadySubmit()){
                    hideMask();
                    return false;
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
                    return "<a href='#' onclick='_download(\""+row.id+"\", \""+value+"\")'>"+value+"</a>"
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

            function download() {
                var grid = $("#attachmentGrid");
                var selections = grid.datagrid('getSelections');
                if(selections.length == 0 || selections.length > 1){
                    $(this)._alert("请选择一条记录");
                    return;
                }
                var url = '${path}/submitContent/downloadAttachment?id=' + selections[0].id;
                window.location = url;

            }
            var toolbar = [{
                id: 'button-add-row',
                text: '删除',
                iconCls: 'icon-cancel',
                handler: doDelete
            }, {
                id: 'button-download-row',
                text: '下载',
                iconCls: 'icon-edit',
                handler: download
            }];

            if(${disabled}){
                toolbar = [{
                    id: 'button-download-row',
                    text: '下载',
                    iconCls: 'icon-edit',
                    handler: download
                }];
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
    <div id="uploadProgress" class="easyui-progressbar" style="width:150px;"></div>
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
                <c:if test="${disabled or action eq 'edit'}">
                    <select id="assessmentProject" disabled="disabled" required="true" class="easyui-combogrid" style="width:430px;"></select>
                    <input type="hidden" name="project.id" value="${submitContent.project.id}" />
                </c:if>
                <c:if test="${!disabled and !(action eq 'edit')}">
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
                        action:"${path}/file/upload",
                        progressBar:$("#uploadProgress"),
                        onComplete: function(filename, response) {
                            $("#attachmentGrid").datagrid('insertRow', {
                                row:response
                            });
                            $("#uploadProgress").progressbar('setValue', 100);
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
<div id="mask">
    <div class="spinner">
        <div class="rect1"></div>
        <div class="rect2"></div>
        <div class="rect3"></div>
        <div class="rect4"></div>
        <div class="rect5"></div>
    </div>
</div>

<div id="imagePreview" class="easyui-window" title="图片预览" collapsible="false" minimizable="false" modal="true" closed="true" resizable="false"
     maximizable="false" icon="icon-save"  style="display: none;width: 900px; height: 500px">
    <img src="" alt="" />
</div>
</body>
</html>