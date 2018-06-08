<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 导入jquery核心类库 -->
<jsp:include page="${pageContext.request.contextPath}/common/reference.jsp" />
<script type="text/javascript">

    var dialogOptions = {
        onDestroy: function () {
            reload();
            $("#doExam").window('destroy');

        }
    };

    function doExam(id, projectId){
        var url = "${path}/business/toExamPage?contentId=" + id + "&projectId=" + projectId;
        $(window).openWindow('doExam', url, 750, 570, '审核', dialogOptions);
	}

    function doLookup(id, title) {
        var url = "${path}/submitContent/toLookupSubmitContent?id=" + id;
        $(window)._openTab("tabs", url, title, window.top);
    }


	//定义冻结列
	var columns = [[{
		field : 'id',
		checkbox : true,
		rowspan : 1
	},
	{
        field : 'unitShortName',
        title : '单位名称',
        width : 130,
        rowspan : 1,
        sortable : false
    },
    {
        field : 'levelmc',
        title : '单位类型',
        width : 100,
        rowspan : 1,
        sortable : false
    },
	{
		field : 'khxm',
		title : '考核项目',
		width : 330,
		rowspan : 1,
        sortable : false,
        formatter: function(value, row, index){
        	if(row.id){
                return "<a href='#' title='"+value+"' onclick=\"doLookup('"+row.id+"', '上报内容')\" >" + value + "</a>";
            }else {
                return value;
            }
        }
	},
    {
            field : 'xmlxmc',
            title : '考核类型',
            width : 180,
            rowspan : 1,
            sortable : false
        },
	 {
         field : 'totalscore',
         title : '考核总分',
         width : 50,
         rowspan : 1,
         sortable : false
     },{
            field : 'op',
            title : '操作',
            width : 50,
            rowspan : 1,
            sortable : false,
			formatter: function (value, row, index) {
				if(row.unitLevel == '1' || row.unitLevel == '2'){
				    if(row.score != null){
				        return "已审核";
                    }
				    return "<a href='#' onclick='doExam(\"" + row.id + "\", \"" + row.khxmid + "\")'>审核</a>"
				}
            }
        }
	]];

    function reload() {
        $("#grid").datagrid('reload', {
            xmlx: $("input[name='assessmentType']").val(),
            unitLevel : $("input[name='unitLevel']").val(),
            unitShortName : $("#unitShortName").val()
        });
    }

	// 定义标题栏
	var frozenColumns = [[]];

    var assessmentType = $.loadEnum('assessmentType');
	$(function(){
		// 初始化 datagrid
		// 创建grid
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
            pagination: true,
			pageSize: 20,
			fit : true,
            fitColumns: true,
			border : false,
            singleSelect:true,
			rownumbers : true,
			striped : true,
			toolbar : '#toolbar',
            height:'auto',
            nowrap:true,
			url : "/business/listReport",
			idField : 'id', 
			frozenColumns : frozenColumns,
			columns : columns
		});

		var pager = $("#grid").datagrid("getPager");
		if(pager){
		    pager.pagination({
                onBeforeRefresh:function(){
                    alert('before refresh');
                }
            })
        }

		
		$("body").css({visibility:"visible"});

        $("#doExam").window('close');

        $.enumCombobox('assessmentType', 'assessmentType', '', '请选择');
        $.enumCombobox('unitLevel', 'unitLevel', '', '请选择');

        $("#queryBtn").click(reload);


	});

</script>		
</head>
<body class="easyui-layout" style="visibility:hidden;">


	<div id="toolbar">
		<table class="table-edit" width="100%" >
			<tr>
				<td>
					<b>考核类型</b><span class="operator"><a name="birthday-opt" opt="date"></a></span>
					<input id="assessmentType" name="assessmentType" value="">

					<b>单位等级</b><span class="operator"><a name="gender-opt" opt="all"></a></span>
					<input id="unitLevel" name="unitLevel" value="">

					<b>单位名称</b><span class="operator"><a name="gender-opt" opt="all"></a></span>
					<input id="unitShortName" class="easyui-textbox" name="unitShortName" value="">

					<a id="queryBtn" href="#" class="easyui-linkbutton" plain="true" icon="icon-search">查询</a>
				</td>
			</tr>
		</table>
	</div>
    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>