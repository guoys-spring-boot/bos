<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工作单快速录入</title>
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
<script type="text/javascript">
	var editIndex ;
	
	function doAdd(){
		if(editIndex != undefined){ // 存在正在编辑行
			$("#grid").datagrid('endEdit',editIndex); // 结束编辑
		}
		if(editIndex==undefined){ // 不存在编辑行
			$("#grid").datagrid('insertRow',{
				index : 0,
				row : {}// 空行
			});
			$("#grid").datagrid('beginEdit',0);
			editIndex = 0;
		}
	}
	
	function doSave(){
		$("#grid").datagrid('endEdit',editIndex );
	}
	
	function doCancel(){
		if(editIndex!=undefined){
			$("#grid").datagrid('cancelEdit',editIndex);
			if($('#grid').datagrid('getRows')[editIndex].id == undefined){
				$("#grid").datagrid('deleteRow',editIndex);
			}
			editIndex = undefined;
		}
	}
	
	//工具栏
	var toolbar = [ {
		id : 'button-add',	
		text : '新增一行',
		iconCls : 'icon-edit',
		handler : doAdd
	}, {
		id : 'button-cancel',
		text : '取消编辑',
		iconCls : 'icon-cancel',
		handler : doCancel
	}, {
		id : 'button-save',
		text : '保存',
		iconCls : 'icon-save',
		handler : doSave
	}];
	// 定义列
	var columns = [ [ {
		field : 'id',
		title : '工作单号',
		width : 120,
		align : 'center',
		editor :{
			type : 'validatebox',
			options : {
				required: true
			}
		}
	}, {
		field : 'arrivecity',
		title : '到达地',
		width : 120,
		align : 'center',
		editor :{
			type : 'validatebox',
			options : {
				required: true
			}
		}
	},{
		field : 'product',
		title : '产品',
		width : 120,
		align : 'center',
		editor :{
			type : 'validatebox',
			options : {
				required: true
			}
		}
	}, {
		field : 'num',
		title : '件数',
		width : 120,
		align : 'center',
		editor :{
			type : 'numberbox',
			options : {
				required: true
			}
		}
	}, {
		field : 'weight',
		title : '重量',
		width : 120,
		align : 'center',
		editor :{
			type : 'validatebox',
			options : {
				required: true
			}
		}
	}, {
		field : 'floadreqr',
		title : '配载要求',
		width : 220,
		align : 'center',
		editor :{
			type : 'validatebox',
			options : {
				required: true
			}
		}
	}] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 收派标准数据表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [10,20,30],
			pagination : true,
			toolbar : toolbar,
			url :  "${pageContext.request.contextPath}/workordermanage_pageQuery.do",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow,
			onAfterEdit : function(rowIndex, rowData, changes){
				//将编辑行数据 打印 控制台
				console.info(rowData);

				// 通过ajax 将当前编辑行数据 发送到服务器，执行insert 操作
				$.post("${pageContext.request.contextPath}/workordermanage_save.do", rowData, function(data){
					if(data.success){
						// 成功
						$.messager.alert('信息',data.msg, 'info');
					}else{
						// 失败
						$.messager.alert('错误',data.msg, 'error');
					}
				});
				
				// 将当前正在编辑行 重置
				editIndex = undefined;
				
			}
		});
	});

	function doDblClickRow(rowIndex, rowData){
		alert("双击表格数据...");
		console.info(rowIndex);
		$('#grid').datagrid('beginEdit',rowIndex);
		editIndex = rowIndex;
	}
	
	// 执行搜索
	function doSearch(value,name){
		// value 输入查询内容
		// name 下拉选项name属性
		// alert("搜索项:"+ name+",搜索条件："+value);

		// 将搜索条件 缓存 到数据表格
		$('#grid').datagrid('load',{
			conditionName: name,
			conditionValue : value
		});
	}
</script>
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div data-options="region:'north'">
		<!-- 使用 searchbox -->
		<!-- 
			menu 下拉搜索条件项
			prompt 提示信息，默认显示为灰色
			searcher 指定执行js函数，点击搜索时，执行 doSearch函数
		 -->
		<input class="easyui-searchbox" data-options="menu:'#mm',prompt:'请输入您的搜索内容',searcher:doSearch"/>
		
		<div id="mm">
			<div data-options="name:'arrivecity'">按照到达地搜索</div>
			<div data-options="name:'product'">按照货物名称搜索</div>
		</div>
	</div>
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>