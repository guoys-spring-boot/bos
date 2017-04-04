<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/ext/portal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/default.css">	
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.portal.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/ext/jquery.cookie.js"></script>
<script
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
	type="text/javascript"></script>

<script
        src="${pageContext.request.contextPath }/js/platform/common.js"
        type="text/javascript"></script>
<script type="text/javascript">

    var dialogOptions = {
        onDestroy: function () {
            window.parent.reloadGrid();
            $("#addUserWindow").window('destroy');

        }
    };

    function openLookupPage(id) {
        var userWindow = $("#addUserWindow");
        userWindow.window('refresh', '${pageContext.request.contextPath}/business/toLookupUnit?unitId=' + id);
        userWindow.window('open');
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

	var unitTypes = $.loadEnum('unitType');
	var unitProperty = $.loadEnum('unitProperty');
	var unitLevel = $.loadEnum('unitLevel');
	var isAdmin = $.loadEnum('yesOrNo');
	var auditingStatus = $.loadEnum('auditingStatus');

	//定义冻结列
	var frozenColumns = [[{
		field : 'id',
		checkbox : true,
		rowspan : 1
	}, {
		field : 'organizationCode',
		title : '单位代码',
		width : 80,
		rowspan : 1,
        sortable : false
	},
        {
            field : 'unitFullName',
            title : '单位名称',
            width : 120,
            rowspan : 1,
            sortable : false,
            formatter: function (value, row, index) {
                if(row.id){
                    return "<a href='#' onclick=\"openLookupPage('"+row.id+"')\">" + value + "</a>";
                }else {
                    return value;
                }
            }
        }]];


	// 定义标题栏
	var columns = [[ {
		field : 'ascriptionArea',
		title : '归属区域',
		width : 60,
		rowspan : 1
	}, {
		field : 'unitType',
		title : '单位类型',
		width : 70,
		rowspan : 1,
        formatter : function(value, row, index){
		    return unitTypes[value];
        }
	}, {
		field : 'unitProperty',
		title : '单位性质',
		width : 70,
		rowspan : 1,
        formatter : function(value, row, index){
            return unitProperty[value];
        }
	} , {
		field : 'unitLevel',
		title : '文明单位等级',
		width : 120,
        formatter : function(value, row, index){
            return unitLevel[value];
        }
	}, {
		field : 'isAdmin',
		title : '是否为管理员',
		width : 80,
        formatter : function(value, row, index){
            return isAdmin[value];
        }
	} , {
        field : 'auditingStatus',
        title : '审核状态',
        width : 86,
        formatter : function(value, row, index){
            return auditingStatus[value];
        }
    }]];
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
			url : "/business/listUnit",
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
        $(window).openWindow('addUserWindow', '${pageContext.request.contextPath}/business/toAddUnit', 750, 570, '用户管理');

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

<!--<div class="easyui-window"  title="用户管理" id="addUserWindow" collapsible="false" minimizable="false" maximizable="true" style="top:20px;left:100px;width: 750px; height: 570px; z-index: 1000">
    <iframe src="${pageContext.request.contextPath}/business/toAddUnit" id="editFrame" style="width:100%;height:100%;border:0;" ></iframe>
</div> -->


    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>