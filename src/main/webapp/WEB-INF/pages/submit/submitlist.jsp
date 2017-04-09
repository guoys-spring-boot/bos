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

    var grid = $("#grid");
    function doLookup(id, title) {
        var url = "${path}/submitContent/toLookupSubmitContent?id=" + id;
        $(window)._openTab("tabs", url, title, window.top);
    }


	// 工具栏
	var toolbar = '#toolbar';


	//定义冻结列
	var frozenColumns = [[{
		field : 'id',
		checkbox : true,
		rowspan : 1
	}, {
		field : 'projectName',
		title : '考核项目',
		width : 400,
		rowspan : 1,
        sortable : false,
        formatter: function (value, row) {
            return row.project.projectName;
        }
	},
        {
            field : 'type',
            title : '考核类型',
            width : 180,
            rowspan : 1,
            sortable : false,
            formatter: function(value, row, index){
                return assessmentType[row.project.type];
            }
        }]];


	// 定义标题栏
	var columns = [[ {
		field : 'project.totalScore',
		title : '考核总分',
		width : 60,
		rowspan : 1
	}, {
		field : 'op',
		title : '上报内容',
		width : 100,
        formatter: function (value, row, index) {
            return "<a href='#' onclick='doLookup(\""+row.id+"\", \""+row.project.projectName+"\")'>查看上报内容</a>";
        }
	}]];

    var assessmentType = $.loadEnum('assessmentType');
	$(function(){
		// 初始化 datagrid
		// 创建grid
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
            pagination: true,
			fit : true,
			border : false,
            singleSelect:false,
			rownumbers : true,
			striped : true,
			toolbar : toolbar,
            height:'auto',
            nowrap:false,
			url : "${path}/submitContent/listSubmitContent",
			idField : 'id', 
			frozenColumns : frozenColumns,
			columns : columns
		});


		$("body").css({visibility:"visible"});

	});


</script>		
</head>
<body class="easyui-layout" style="visibility:hidden;">

    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>