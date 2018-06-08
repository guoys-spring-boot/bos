<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- 导入jquery核心类库 -->
    <jsp:include page="${pageContext.request.contextPath}/common/reference.jsp"/>
    <script type="text/javascript" src="${path}/js/echars/echarts.js"></script>
    <script type="text/javascript">

        $(function () {
            // 基于准备好的dom，初始化echarts实例
            var unitSubmitBar = echarts.init(document.getElementById('unitSubmitBar'));

            var unitSubmitBarOption = {
                title: {
                    text: '单位上报情况'
                },
                color: ['#3398DB'],
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: [
                    {
                        type: 'category',
                        data: [],
                        axisTick: {
                            alignWithLabel: true,
                            interval: 0
                        },
                        axisLabel: {
                            interval: 0,
                            rotate: 25
                        }
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '直接访问',
                        type: 'bar',
                        barWidth: '60%',
                        data: []
                    }
                ]
            };

            // 使用刚指定的配置项和数据显示图表。
            unitSubmitBar.setOption(unitSubmitBarOption);
            var unitSubmitBarIds = [];
            var unitSubmitBarValues = [];
            var unitSubmitBarLabels = [];
            unitSubmitBar.on('click', function (params) {
                var url = "${path}/page.do?module=report&resource=agency_report_process_list&unitId=" + unitSubmitBarIds[params.dataIndex];
                $(this)._openTab("tabs", url, unitSubmitBarLabels[params.dataIndex], window.top);

            });
            $.get('${path}/admin2/unitSubmitBar.do').done(function (data) {

                for (var i = 0; i < data.length; i++) {
                    unitSubmitBarLabels.push(data[i].label);
                    unitSubmitBarIds.push(data[i].id);
                    unitSubmitBarValues.push(data[i].value);
                }
                unitSubmitBar.setOption({
                    xAxis: {
                        data: unitSubmitBarLabels
                    },
                    series: [{
                        name: '直接访问',
                        data: unitSubmitBarValues
                    }]

                });
            });


            // 饼图
            var pieoption = {
                title: {
                    text: '等级统计'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [
                    {
                        name: '等级',
                        label: {
                            normal: {
                                formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
                                backgroundColor: '#eee',
                                borderColor: '#aaa',
                                borderWidth: 1,
                                borderRadius: 4,
                                // shadowBlur:3,
                                // shadowOffsetX: 2,
                                // shadowOffsetY: 2,
                                // shadowColor: '#999',
                                // padding: [0, 7],
                                rich: {
                                    a: {
                                        color: '#999',
                                        lineHeight: 22,
                                        align: 'center'
                                    },
                                    // abg: {
                                    //     backgroundColor: '#333',
                                    //     width: '100%',
                                    //     align: 'right',
                                    //     height: 22,
                                    //     borderRadius: [4, 4, 0, 0]
                                    // },
                                    hr: {
                                        borderColor: '#aaa',
                                        width: '100%',
                                        borderWidth: 0.5,
                                        height: 0
                                    },
                                    b: {
                                        fontSize: 16,
                                        lineHeight: 33
                                    },
                                    per: {
                                        color: '#eee',
                                        backgroundColor: '#334455',
                                        padding: [2, 4],
                                        borderRadius: 2
                                    }
                                }
                            }
                        },
                        type: 'pie',
                        radius: '55%',
                        //center: ['40%', '50%'],
                        data: [],
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            var unitLevelSubmitBar = echarts.init(document.getElementById('unitLevelSubmitBar'));
            unitLevelSubmitBar.setOption(pieoption);

            var unitLevelIds = [];
            $.get('${path}/admin2/unitLevelSubmitPie.do').done(function (data) {

                var legendData = [];
                var selected = {};
                var seriesData = [];
                var datas = {};
                for (var i = 0; i < data.length; i++) {
                    datas[data[i].label] = data[i].value;
                    seriesData.push({
                        name: data[i].label,
                        value: data[i].value
                    });
                    unitLevelIds.push(data[i].id);
                    selected[name] = true;
                    legendData.push(name);
                }
                unitLevelSubmitBar.setOption({
                    series: [{
                        name: '等级',
                        data: seriesData
                    }]

                });

                var privateUnitCount = 0;
                $.ajax({
                    url : '${pageContext.request.contextPath}/admin2/privateUnitCount.do',
                    type : 'POST',
                    async: false,
                    dataType : 'text',
                    success : function(data) {
                        privateUnitCount = data;

                    },
                    error : function(msg) {
                        alert('获取非公异常!');
                    }
                });

                var privateUnitStr = '<a href="#" onclick="searchPrivate()">'+privateUnitCount+'</a>';

                var remark = '国家级:'+datas['国家级文明单位']+'，省级文明：'+datas['省级文明单位']+'，' +
                    '州级文明：'+datas['州级文明单位']+'，州级最佳：'+datas['州级最佳文明单位']+'，市级文明：'+datas['市级文明单位']+'，非市级：'+datas['非文明单位']+'，非公企业：' + privateUnitStr;

                $("#unitLevelRemark").html(remark);

            });

            unitLevelSubmitBar.on('click', function (params) {
                var url = "${path}/page.do?module=report&resource=agency_report_process_list&unitId=NA&unitLevel=" + unitLevelIds[params.dataIndex];
                $(this)._openTab("tabs", url, '查看', window.top);
            });

        });


        function searchPrivate() {
            var url = "${path}/page.do?module=report&resource=agency_report_process_list&unitId=NA&privateUnit=1";
            $(this)._openTab("tabs", url, '查看', window.top);
        }

        function _doUpload() {
            $('#uploadWindow').window('open');
            $("#uploadProgress").progressbar('setValue', 0);
            $("#uploadProgress").show();
            $("#uploadSuccess").hide();

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

                    if (!response || JSON.stringify(response) == '{}') {
                        $(this)._alert("上传附件失败");
                        return;
                    } else {
                        $("#uploadSuccess").show();
                        $.post('${path}/notice/saveNotice.do', {
                            "attachment.id": response.id,
                            name: response.name
                        }).done(function (res) {
                            if (res.status != 200) {
                                $(this)._alert(res.msg);
                            } else {
                                $(this)._alert("上传成功");
                            }

                            $("#noticeGrid").datagrid('reload');
                        });
                    }

                    $("input[name='file']").bind('change', function () {

                    });

                }
            });
        }

        function _download(id) {
            var url = '${path}/submitContent/downloadAttachment?id=' + id;
            location.href = url;
        }
        function noticeNameFormat(value, row) {
            return "<a href='#' onclick='_download(\"" + row.attachment.id + "\")'>" + value + "</a>"
        }

        function opsFormat(value, row, index) {
            return '<a href="#" onclick="_doDelRow(\'' + row.id + '\')">删除</a>';
        }

        function _doDelRow(id) {
            $(this)._confirm("确定要删除么？", function () {
                $.post('${path}/notice/delete.do', {
                    id: id
                }).done(function () {
                    $("#noticeGrid").datagrid('reload');
                });
            });
        }

    </script>
</head>
<body class="easyui-layout" data-options="fit:true">
<div data-options="region:'north'" class="easyui-layout" style="height: 50%">
    <div data-options="region:'west'" style="width: 45%">
        <table id="noticeGrid" class="easyui-datagrid" title="公告" style="width:700px;height:250px"
               data-options="rownumbers:true,singleSelect:true,url:'${path}/notice/findAll',method:'get',toolbar:'#toolbar', fit:true, fitColumns: true">
            <thead>
            <tr>
                <th data-options="field:'name',width:80, formatter:noticeNameFormat">名称</th>
                <th data-options="field:'date',width:100">上传时间</th>
                <th data-options="field:'listprice',width:80, formatter:opsFormat">操作</th>
            </tr>
            </thead>
        </table>
        <div class="datagrid-toolbar" id="toolbar">
            <a id="upload" icon="icon-add" href="#" onclick="_doUpload()" class="easyui-linkbutton" plain="true">上传</a>
        </div>
    </div>
    <div data-options="region:'east'" style="width: 55%">
        <div id="unitLevelSubmitBar" style="width: 100%;height:95%;"></div>
        <div id="unitLevelRemark">国家级:20，省级文明：22，州级文明：22，市级文明：22，非市级：22，非公企业：22</div>
    </div>

</div>
<div data-options="region:'south'" style="height: 50%">
    <div id="unitSubmitBar" style="width: 100%;height:100%;"></div>
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