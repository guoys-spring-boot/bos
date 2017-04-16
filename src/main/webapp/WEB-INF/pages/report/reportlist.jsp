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
            window.parent.reloadGrid();
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
				if(row.unitLevel == '5' || row.unitLevel == '6'){
				    if(row.score > 0){
				        return "已审核";
                    }
				    return "<a href='#' onclick='doExam(\"" + row.id + "\", \"" + row.khxmid + "\")'>审核</a>"
				}
            }
        }
	]];


	// 定义标题栏
	var frozenColumns = [[]];

    var assessmentType = $.loadEnum('assessmentType');
	$(function(){
		// 初始化 datagrid
		// 创建grid
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
            pagination: true,
			fit : true,
			border : false,
            singleSelect:true,
			rownumbers : true,
			striped : true,
			toolbar : toolbar,
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

		
	});

</script>		
</head>
<body class="easyui-layout" style="visibility:hidden;">

    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>