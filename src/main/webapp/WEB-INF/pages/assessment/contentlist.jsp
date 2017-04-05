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
            $("#addUserWindow").window('destroy');

        }
    };

    function openLookupPage(id) {

        var url = '${pageContext.request.contextPath}/business/toLookupUnit?unitId=' + id;
        $(window).openWindow('addUserWindow', url, 750, 570, '用户管理', dialogOptions);
    }

    function openEditPage(id) {
        var url = '${pageContext.request.contextPath}/business/toUpdateUnit?unitId=' + id;
        $(window).openWindow('addUserWindow', url, 750, 570, '用户管理', dialogOptions);

    }

	// 工具栏
	var toolbar = [ {
		id : 'button-view',	
		text : '修改',
		iconCls : 'icon-edit',
		handler : doEdit
	}, {
		id : 'button-add',
		text : '新增',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
	}];


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
        sortable : false
	},
        {
            field : 'type',
            title : '考核类型',
            width : 180,
            rowspan : 1,
            sortable : false,
            formatter: function(value, row, index){
                return assessmentType[value];
            }
        }]];


	// 定义标题栏
	var columns = [[ {
		field : 'totalScore',
		title : '考核总分',
		width : 60,
		rowspan : 1
	}, {
		field : 'unitType',
		title : '是否上报',
		width : 70,
		rowspan : 1
	}, {
		field : 'unitProperty',
		title : '上报内容',
		width : 70,
		rowspan : 1
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
            singleSelect:true,
			rownumbers : true,
			striped : true,
			toolbar : toolbar,
            height:'auto',
            nowrap:false,
			url : "/assessmentContent/listContent",
			idField : 'id', 
			frozenColumns : frozenColumns,
			columns : columns,
			onClickRow : onClickRow,
			onDblClickRow : doDblClickRow
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

        $("#addUserWindow").window('close');

		
	});
	// 双击
	function doDblClickRow(rowIndex, rowData) {
        openLookupPage(rowData.id);
	}
	// 单击
	function onClickRow(rowIndex){
		$("#grid").datagrid('beginEdit', rowIndex);
	}

	function doEdit() {
        var item = $('#grid').datagrid('getSelected');
        openEditPage(item.id);
    }


	function doAdd() {
        $(window).openWindow('addUserWindow', '${pageContext.request.contextPath}/business/toAddUnit', 750, 570, '用户管理', dialogOptions);

	}

	function doView() {
		alert("编辑用户");
		var item = $('#grid').datagrid('getSelected');
		console.info(item);
		//window.location.href = "edit.html";
	}

	function doDelete() {

		var ids = [];
		var items = $('#grid').datagrid('getSelections');
		for(var i=0; i<items.length; i++){
		    ids.push(items[i].id);	    
		}

		$.ajax("/deleteUser", {
		    data: {
		        ids:ids.join(",")
            },
            success: function (data) {
                $('#grid').datagrid('reload');
                $('#grid').datagrid('uncheckAll');
            }
        });

		

	}
</script>		
</head>
<body class="easyui-layout" style="visibility:hidden;">

    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>