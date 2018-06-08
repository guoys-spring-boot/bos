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


        var dialogOptions = {
            onDestroy: function () {
                reload();
                $("#doExam").window('destroy');

            }
        };
        function doLookup(id, title) {
            var url = "${path}/submitContent/toLookupSubmitContent?id=" + id;
            $(window)._openTab("tabs", url, title, window.top);
        }


        String.prototype.endWith = function (str) {
            var reg = new RegExp(str + "$");
            return reg.test(this);
        };
        var images = ['.png', '.jpg', '.jpeg'];
        var previews = ['.doc', '.xls', '.docx', '.xlsx', '.pdf'];
        var pdf = ['.pdf'];

        function checkChanged(callback) {
            callback();
            return false;
        }

        function isPreview(name) {
            if (name == null || name == undefined) {
                return false;
            }
            var result = false;
            $.each(previews, function (index, item) {

                if (name.toLowerCase().endWith(item)) {
                    result = true;
                }
            });

            return result;
        }

        function isImage(name) {
            if (name == null || name == undefined) {
                return false;
            }
            var result = false;
            $.each(images, function (index, item) {

                if (name.toLowerCase().endWith(item)) {
                    result = true;
                }
            });

            return result;
        }

        function isPdf(name) {
            if (name == null || name == undefined) {
                return false;
            }
            var result = false;
            $.each(pdf, function (index, item) {

                if (name.toLowerCase().endWith(item)) {
                    result = true;
                }
            });

            return result;
        }

        function _download(id, name) {
            var url = '${path}/submitContent/downloadAttachment?id=' + id;
            if (name == null || name == undefined) {
                location.href = url;
                return;
            }

            if (isImage(name)) {
                //$("#imagePreview").find("img").attr("src", url);
                //$("#imagePreview").window('open');
                window.open('${path}/page.do?module=submit&resource=image&url=' + url, "image");
                return;
            }
            if (isPreview(name)) {
                var previewUrl = '${applicationScope.context.office_preview_url}/?i=12491&ssl=1&furl=${applicationScope.context.current_url}' + url;
                $(window)._openTab("tabs", previewUrl, "预览", window.top);
                return;
            }
            location.href = url;
        }

        function doExam(id, projectId) {
            var url = "${path}/business/toExamPage?contentId=" + id + "&projectId=" + projectId;
            $(window).openWindow('doExam', url, 750, 570, '审核', dialogOptions);
        }


        var attachmentGridColumns = [[{
            field: 'id',
            checkbox: true,
            rowspan: 1
        }, {
            field: 'name',
            title: '名称',
            width: '50%',
            rowspan: 1,
            sortable: false,
            formatter: function (value, row, index) {
                var imgStr = "";
                if (value && isImage(value)) {
                    imgStr = "<img src='${path}/css/img/imgIcon.jpg' style='width:15px;height:15px' />";
                }

                if (value && isPdf(value)) {
                    imgStr = "<img src='${path}/css/img/pdfIcon.png' style='width:15px;height:15px' />";
                } else if (value && isPreview(value)) {
                    imgStr = "<img src='${path}/css/img/wordIcon.png' style='width:15px;height:15px' />";
                }

                return imgStr + "<a href='#' onclick='_download(\"" + row.id + "\", \"" + value + "\")'>" + value + "</a>"
            }
        },
            {
                field: 'uploadTime',
                title: '上传时间',
                width: '20%',
                rowspan: 1,
                sortable: false
            },
            {
                field: 'download',
                title: "下载",
                width: '10%',
                formatter: function (value, row, index) {
                    return "<a href='#' onclick='_download(\"" + row.id + "\", \"" + value + "\")'>下载</a>"
                }
            }, {
                field: 'proview',
                title: "预览",
                width: '10%',
                formatter: function (value, row, index) {
                    return "<a href='#' onclick='_download(\"" + row.id + "\", \"" + row.name + "\")'>预览</a>"
                }
            }

        ]];

        var attachmentOptions = {
            //iconCls : 'icon-forward',
            title: '附件列表',
            fit: true,
            fitColumns: false,
            border: false,
            singleSelect: true,
            striped: true,
            //toolbar : '#attachmentToolBar',
            height: 'auto',
            nowrap: false,
            url: "${path}/submitContent/listAttachment",
            idField: 'id',
            columns: attachmentGridColumns
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
            singleSelect: true,
            fitColumns: true,
            nowrap: true,
            url: '${path}/submitContent/listSubmitContentWithProject?unitId=${preParam.unitId}',
            queryParams: {
                projectType: '100000'
            },
            onBeforeSelect: function (i, row) {

                return !checkChanged(function () {

                    $("#contentDetails").datagrid('reload', {
                        "contentId": row.project.id
                    });

                    $("#attachmentGrid").datagrid('reload', {
                        "foreignKey": row.id
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
                    width: 100
                },
                {
                    field: 'amCnt',
                    title: '附件数量',
                    width: 100,
                    formatter: function (value, row, index) {
                        if (value == 0) {
                            return "未上传附件";
                        } else {
                            return value;
                        }
                    }
                },
                {
                    field: 'op',
                    title: '操作',
                    width: 100,
                    formatter: function (value, row) {
                        if (row.status == '已上报') {
                            return "<a href='#' onclick='doExam(\"" + row.id + "\", \"" + row.projectId + "\")'>审核</a>"
                        }
                    }
                },{
                    field: 'lookup',
                    title: '查看',
                    width: 100,
                    hidden: '${sessionScope.year}' != '2017',
                    formatter: function (value, row) {
                        if (row.status != '未上报' && '${sessionScope.year}' == '2017') {
                            return "<a href='#' onclick='doLookup(\"" + row.id + "\", \"查看\")'>查看内容</a>"
                        }

                    }
                }
            ]]
        };




        var contextTypeListOptions = {
            url: '${path}/submitContent/listAssessmentType?unitId=${preParam.unitId}',
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
                    reload(row.enumCode);
                });
            }
        };

        $(function () {
            $('#attachmentGrid').datagrid(attachmentOptions);
            $("#contentGrid").datagrid(contentOptions);
            $("#contentTypeList").datalist(contextTypeListOptions);
        });

        function reload(_projectType) {
            var projectType = '1';
            var row = $("#contentTypeList").datalist('getSelected');
            if (_projectType) {
                projectType = _projectType;
            } else if (row) {
                projectType = row.enumCode;
            }
            $('#contentGrid').datagrid('reload', {
                status: $("#status").combobox('getValue'),
                projectType: projectType
            })
        }


    </script>
</head>
<body class="easyui-layout" style="height: 100%">
<div region="north" border="false" style="height: 58%; padding: 2px">
    <div class="easyui-layout" style="height: 100%;padding: 2px" border="false">
        <div region="west" style="width: 20%" border="false">
            <div class="easyui-datalist" border="false" id="contentTypeList">
            </div>
        </div>
        <div region="center" style="width: 80%;padding: 2px" border="false">
            <div id="contentToolBar">
                <b>考核状态</b><span class="operator"><a name="birthday-opt" opt="date"></a></span>
                <select id="status" class="easyui-combobox" name="status" style="width:200px;">
                    <option value="">请选择</option>
                    <option value="未上报">未上报</option>
                    <option value="已上报">已上报</option>
                    <option value="已评分">已评分</option>
                </select>
                <a id="queryBtn" style="" icon="icon-search" href="#" onclick="reload()" class="easyui-linkbutton"
                   plain="true">查询</a>
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

    <table id="attachmentGrid" style="width: 100%"></table>
</div>

</body>
</html>