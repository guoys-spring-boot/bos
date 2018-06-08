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

        String.prototype.endWith=function(str){
            var reg=new RegExp(str+"$");
            return reg.test(this);
        };
        var images = ['.png', '.jpg', '.jpeg'];
        var previews = ['.doc', '.xls', '.docx', '.xlsx', '.pdf'];
        var pdf = ['.pdf'];

        var hasChanged = false;

        function recordChange() {
            hasChanged = true;
        }

        function checkChanged(callback) {
//            if(hasChanged){
//                $(this)._alert("有未保存的修改");
//                return hasChanged;
//            }
            callback();
            return hasChanged;
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

        function isPdf(name) {
            if(name == null || name == undefined){
                return false;
            }
            var result = false;
            $.each(pdf, function (index, item) {

                if(name.toLowerCase().endWith(item)){
                    result = true;
                }
            });

            return result;
        }

        function _download(id, name) {
            var url = '${path}/submitContent/downloadAttachment?id=' + id;
            if(name == null || name == undefined){
                location.href = url;
                return;
            }

            if(isImage(name)){
                //$("#imagePreview").find("img").attr("src", url);
                //$("#imagePreview").window('open');
                window.open('${path}/page.do?module=submit&resource=image&url='+ url, "image");
                return;
            }
            if(isPreview(name)){
                var previewUrl = '${applicationScope.office_preview_url}/?i=12491&ssl=1&furl=${applicationScope.current_url}' + url;
                $(window)._openTab("tabs", previewUrl, "预览", window.top);
                return;
            }
            location.href = url;
        }

        function _delRow(row) {
            var grid = $("#attachmentGrid");
            var rowIndex = grid.datagrid('getRowIndex', row);
            grid.datagrid('deleteRow', rowIndex);
            recordChange();
        }



        function _doUpload() {
            if(!$("#contentGrid").datagrid('getSelected')){
                $(this)._alert("请先选择一行考核项目");
                return false;
            }
            $('#uploadWindow').window('open');
            $("#uploadProgress").progressbar('setValue', 0);
            $("#uploadProgress").show();
            $("#uploadSuccess").hide();
            $("#fileId").val('');
            $("#file").textbox('setText', '');
            $("input[name='file']").val('');
            $("input[name='file']").AjaxFileUpload({
                action: "${path}/file/upload",
                progressBar: $("#uploadProgress"),
                onComplete: function (filename, response) {

                    //$(this)._alert("上传完成，请点击确定完成导入");
                    $("#fileId").val(response.id);
                    $("#uploadProgress").progressbar('setValue', 100);

                    $("#uploadProgress").hide();

                    if(!response || JSON.stringify(response) == '{}'){
                        $(this)._alert("上传附件失败");
                        return;
                    }else{
                        $("#uploadSuccess").show();
                    }

                    $("input[name='file']").bind('change', function () {

                    });

                    $("#attachmentGrid").datagrid('insertRow', {
                        row:response
                    });
                    recordChange();
                }
            });
        }

        function _doSave() {
            var contentRow = $("#contentGrid").datagrid('getSelected');
            if(contentRow == null){
                $(this)._alert("请先选择一项考核项目");
                return false;
            }
            var projectId = contentRow.project.id;
            if(!projectId){
                $(this)._alert("考核项目不能为空");
                return;
            }

            var rows = $("#attachmentGrid").datagrid('getRows');
            if(!rows || rows.length == 0){
                $(this)._alert("您没有上传任何附件");
                return;
            }

//            if(!checkAlreadySubmit()){
//                hideMask();
//                return false;
//            }
            var changes = $("#attachmentGrid").datagrid('getChanges', 'inserted');
            var ids = [];
            for(var i = 0; i< changes.length; i++){
                var record = changes[i];
                ids.push(record.id);
            }

            $(this)._confirm("确定要上报?", function () {
                $.ajax("${path}/submitContent/addSubmitContent",{
                    data: {
                        content: 'default',
                        needInsert: ids.join(","),
                        "project.id" : projectId
                    },
                    success: function () {
                        $.messager.progress('close');
                        $(this)._alert("上报成功");
                        $("#contentGrid").datagrid('reload');
                    },
                    error: function () {
                        alert("上报失败");
                        $.messager.progress('close');
                    }
                });
                hasChanged = false;
            });

        }

        function _doEdit() {

            var contentRow = $("#contentGrid").datagrid('getSelected');
            if(contentRow == null){
                $(this)._alert("请先选择一项考核项目");
                return false;
            }


//            var rows = $("#attachmentGrid").datagrid('getRows');
//            if(!rows || rows.length == 0){
//                $(this)._alert("您没有上传任何附件");
//                return;
//            }

            var grid = $("#attachmentGrid");
            var needDeletes = grid.datagrid('getChanges', 'deleted');
            var needDeleteIds = [];
            for(var j = 0; j< needDeletes.length; j++){
                var deleteRecord = needDeletes[j];
                needDeleteIds.push(deleteRecord.id);
            }

            var changes = grid.datagrid('getChanges', 'inserted');
            var ids = [];
            for(var i = 0; i< changes.length; i++){
                var record = changes[i];
                ids.push(record.id);
            }

            $(this)._confirm("确定要上报?", function () {
                $.messager.progress({
                    title: "提示",
                    msg: "正在保存"
                });
                $.ajax('${path}/submitContent/updateSubmitContent', {
                    data: {
                        id: contentRow.id,
                        content: 'default',
                        needInsert: ids.join(","),
                        "project.id" : contentRow.project.id,
                        needDelete: needDeleteIds.join(",")
                    },
                    success: function () {
                        $.messager.progress('close');
                        $(this)._alert("上报成功");
                        $("#contentGrid").datagrid('reload');
                    },
                    error: function (e) {
                        $.messager.progress('close');
                        alert("上报失败" + JSON.stringify(e));
                    }
                });

                hasChanged = false;
            });

        }

        var attachmentGridColumns = [[{
            field : 'id',
            checkbox : true,
            rowspan : 1
        }, {
            field : 'name',
            title : '名称',
            width : '50%',
            rowspan : 1,
            sortable : false,
            formatter: function (value, row, index) {
                var imgStr = "";
                if(value && isImage(value)){
                    imgStr = "<img src='${path}/css/img/imgIcon.jpg' style='width:15px;height:15px' />";
                }

                if(value && isPdf(value)){
                    imgStr = "<img src='${path}/css/img/pdfIcon.png' style='width:15px;height:15px' />";
                }else if(value && isPreview(value)){
                    imgStr = "<img src='${path}/css/img/wordIcon.png' style='width:15px;height:15px' />";
                }

                return imgStr + "<a href='#' onclick='_download(\""+row.id+"\", \""+value+"\")'>"+value+"</a>"
            }
        },
            {
                field : 'uploadTime',
                title : '上传时间',
                width : '20%',
                rowspan : 1,
                sortable : false
            },
            {
            field : 'download',
            title : "下载",
            width: '10%',
            formatter: function (value, row, index) {
                return "<a href='#' onclick='_download(\""+row.id+"\", \""+value+"\")'>下载</a>"
            }
        },{
            field : 'proview',
            title : "预览",
            width: '10%',
            formatter: function (value, row, index) {
                return "<a href='#' onclick='_download(\""+row.id+"\", \""+row.name+"\")'>预览</a>"
            }
        },{
            field : 'del',
            title : "删除",
            width: '10%',
            formatter: function (value, row, index) {
                return "<a href='#' onclick='_delRow(\""+row.id+"\", \""+value+"\")'>删除</a>"
            }
        }

        ]];

        var attachmentOptions =  {
            //iconCls : 'icon-forward',
            title: '附件列表',
            fit : true,
            fitColumns: false,
            border : false,
            singleSelect:true,
            striped : true,
            //toolbar : '#attachmentToolBar',
            height:'auto',
            nowrap:false,
            url : "${path}/submitContent/listAttachment",
            idField : 'id',
            columns : attachmentGridColumns
        };


        var assessmentType = $.loadEnum('assessmentType');
        var contentOptions = {
            pagination: true,
            idField: 'projectId',
            title: '考核项目',
            pageSize: 20,
            striped: true,
            toolbar: '#contentToolBar',
            fit: true,
            singleSelect:true,
            fitColumns: true,
            nowrap: true,
            rowStyler: function (index, row) {

                if(row.status == '已上报'){
                    return 'color:#118814;';
                }
                if(row.status == '已评分'){
                    return 'color:#309fc6;';
                }
                if(row.status == '未上报'){
                    return 'color:#BB0000;';
                }
            },
            url: '${path}/submitContent/listSubmitContentWithProject',
            queryParams: {
                projectType : '1111111'
            },
            onBeforeSelect: function(i,row){

                return !checkChanged(function () {

                    var saveBtn = $("#saveBtn");
                    var editBtn = $("#editBtn");
                    var uploadBtn = $("#uploadBtn");
                    if(row.status == '已评分'){
                        saveBtn.hide();
                        editBtn.hide();
                        uploadBtn.hide();
                    }else if(row.status == '已上报'){
                        saveBtn.hide();
                        editBtn.show();
                        uploadBtn.show();
                    }else{
                        saveBtn.show();
                        editBtn.hide();
                        uploadBtn.show();
                    }

                    $("#contentDetails").datagrid('reload', {
                        "contentId" : row.project.id
                    });

                    $("#attachmentGrid").datagrid('reload', {
                        "foreignKey" : row.id
                    });
                });

            },
            columns: [[
                {
                    field: 'project.projectName',
                    title: '考核项目',
                    width: 470,
                    formatter: function (value, row, index) {
                        return row.project.projectName;
                    }
                },
                {
                    field: 'project.type',
                    title: '考核类型',
                    width: 160,
                    formatter: function (value, row, index) {
                        return assessmentType[row.project.type];
                    }
                },
                {
                    field: 'project.totalScore',
                    title: '考核总分',
                    align: 'right',
                    width: 100,
                    formatter: function (value, row, index) {
                        return row.project.totalScore;
                    }
                },
                {
                    field: 'score',
                    title: '考核得分',
                    align: 'right',
                    width: 100
                },
                {
                    field: 'status',
                    title: '考核状态',
                    width: 100,
                    formatter: function (value, row, index) {
                        return value;
                    }
                },
                {
                    field: 'amCnt',
                    title: '附件数量',
                    width: 100,
                    formatter: function (value, row, index) {
                        if(value == 0){
                            return "未上传附件";
                        }else {
                            return value;
                        }
                    }
                }
            ]]
        };


        var contextTypeListOptions = {
            url: '${path}/submitContent/listAssessmentType',
            title: '考核类型',
            lines: false,
            valueField: 'enumCode',
            textField: 'enumText',
            onBeforeSelect: function (i, row) {
                $("#contentGrid").datagrid('clearSelections');
                $("#saveBtn").hide();
                $("#editBtn").hide();
                $("#uploadBtn").hide();
                return !checkChanged(function () {
                    $("#contentGrid").datagrid('reload', {
                        projectType: row.enumCode,
                        status: $("#status").combobox('getValue')
                    });
                });
            }
        };

        function reload(_projectType) {
            var projectType = '1';
            var row = $("#contentTypeList").datalist('getSelected');
            if(_projectType){
                projectType = _projectType;
            }else if(row){
                projectType = row.enumCode;
            }
            $('#contentGrid').datagrid('reload', {
                status: $("#status").combobox('getValue'),
                projectType: projectType
            })
        }

        $(function () {
            $('#attachmentGrid').datagrid(attachmentOptions);
            $("#contentGrid").datagrid(contentOptions);
            $("#contentTypeList").datalist(contextTypeListOptions);
        });




    </script>
</head>
<body class="easyui-layout" style="height: 100%">
    <div  region="north" border="false"  style="height: 58%; padding: 2px">
        <div class="easyui-layout" style="height: 100%;padding: 2px" border="false" >
            <div region="west" style="width: 20%" border="false">
                <div class="easyui-datalist" border="false"  id="contentTypeList">
                </div>
            </div>
            <div region="center" style="width: 80%;padding: 2px" border="false">
                <div id="contentToolBar">
                    <table>
                        <tr>
                            <td>
                                <a id="uploadBtn" style="display: none" icon="icon-edit" href="#" onclick="_doUpload()" class="easyui-linkbutton" plain="true" >上传附件</a>
                                <a id="editBtn" style="display: none" icon="icon-save" href="#" onclick="_doEdit()" class="easyui-linkbutton" plain="true" >修改上报</a>
                                <a id="saveBtn" style="display: none" icon="icon-save" href="#" onclick="_doSave()" class="easyui-linkbutton" plain="true" >上报</a>
                            </td>
                            <td align="right">
                                <b>考核状态</b><span class="operator"><a name="birthday-opt" opt="date"></a></span>
                                <select id="status" class="easyui-combobox" name="status" style="width:200px;">
                                    <option value="">请选择</option>
                                    <option value="未上报">未上报</option>
                                    <option value="已上报">已上报</option>
                                    <option value="已评分">已评分</option>
                                </select>
                                <a id="queryBtn" style="" icon="icon-search" href="#" onclick="reload()" class="easyui-linkbutton" plain="true" >查询</a>
                            </td>
                        </tr>
                    </table>

                </div>
                <table id="contentGrid"></table>
            </div>
        </div>

    </div>
    <div region="center" border="false" style="height: 15%">
        <table class="easyui-datagrid" id="contentDetails" style="height:100px"
               data-options="url:'${path}/assessmentContent/listContentStd',
               fit:true,
               title: '考核项目明细',
               fitColumns:true,
               singleSelect:true,
               striped: true,
               nowrap:false">
            <thead>
            <tr>
                <th data-options="field:'item',width:70">考核评分项</th>
                <th data-options="field:'remark',width:100">报送说明</th>
                <th data-options="field:'score',width:30">总分</th>
            </tr>
            </thead>
        </table>
    </div>
    <div region="south" border="false" style="height: 25%;padding: 3px">

        <table id="attachmentGrid" style="width: 100%" ></table>
    </div>


    <div id="uploadWindow" class="easyui-window" title="上传文件" collapsible="false" minimizable="false" modal="true"
         closed="true" resizable="false"
         maximizable="false" icon="icon-save" style="width: 340px; height:220px; padding: 5px;
        background: #fafafa">
        <input type="hidden" id="fileId" name="fileId">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table width="90%" height="90%">
                    <tr>
                        <td>提示： 上传的文件将会显示在附件列表中</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td><input id="file" class="easyui-filebox" name="file" data-options="prompt:'请选择一个文件'"
                                   style="width:100%"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <div id="uploadProgress" class="easyui-progressbar" style="width:100%; padding: 0px"></div>
                            <div id="uploadSuccess" style="display: none">上传成功</div>
                        </td>
                    </tr>


                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <%--<a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="doImport()">确定</a>--%>
                <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                   onclick="$('#uploadWindow').window('close')">关闭</a>
            </div>
        </div>
    </div>



</body>
</html>