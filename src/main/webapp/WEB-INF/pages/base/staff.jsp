<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>    
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
<script type="text/javascript">
	function doAdd(){
		// 清空表单
		//$('#staffForm').form('clear');
		$('#staffForm').get(0).reset();
		$('#addStaffWindow').window("open");
	}
	
	function doView(){
		alert("查看...");
	}
	
	function doDelete(){
		// 如果用户未选中取派员，无法提交表单
		var rows = $('#grid').datagrid('getSelections');
		if(rows.length == 0){
			$.messager.alert('警告','执行作废功能，至少选中一条取派员信息','warning');
			return ; 
		}
		
		/*
		// js对象
		var obj = {
			a : function(){
				
			}
		};
		obj.a();
		
		var obj2 = {
			datagrid : function(methd){
				var add = function(){
					
				};
				// 执行method
			}
		};
		obj2.datagrid("add");
		*/
		
		// 提交 id 的 checkbox 所在form
		$('#delBatchForm').submit();
	}
	
	function doRestore(){
		// 修改提交 action属性，提交还原方法
		$('#delBatchForm').attr('action','${pageContext.request.contextPath}/staff_restore.do');
		// 提交表单
		$('#delBatchForm').submit();
	}
	//工具栏
	var toolbar = [ {
		id : 'button-view',	
		text : '查询',
		iconCls : 'icon-search',
		handler : doView
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, 
	<shiro:hasPermission name="作废取派员">
	{
		id : 'button-delete',
		text : '作废',
		iconCls : 'icon-cancel',
		handler : doDelete
	},
	</shiro:hasPermission>
	{
		id : 'button-save',
		text : '还原',
		iconCls : 'icon-save',
		handler : doRestore
	},{
		id : 'button_edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : function(){
			// 只允许 用户选择一条记录修改 
			var rows = $('#grid').datagrid('getSelections');
			if(rows.length != 1){
				// 选择行数不是1 
				$.messager.alert('警告','执行修改功能，必须（只能）选中一条取派员信息','warning');
				return ;
			}
			// 将选中行数据显示到 form表单中
			var row = rows[0];
			$('#staffForm').form('load',row);
			
			// 弹出窗口 
			$('#addStaffWindow').window('open');
		}
	}
	];
	// 定义列
	var columns = [ [ {
		field : 'id',
		checkbox : true,
	},{
		field : 'name',
		title : '姓名',
		width : 120,
		align : 'center'
	}, {
		field : 'telephone',
		title : '手机号',
		width : 120,
		align : 'center'
	}, {
		field : 'haspda',
		title : '是否有PDA',
		width : 120,
		align : 'center',
		formatter : function(data,row, index){
			if(data=="1"){
				return "有";
			}else{
				return "无";
			}
		}
	}, {
		field : 'deltag',
		title : '是否作废',
		width : 120,
		align : 'center',
		formatter: function(value,row,index){
			// 当数据列显示，formatter函数执行
			// value : deltag 属性匹配值
			// row : 整行JS数据对象
			// index : 数据记录索引，第一行数据 是 0
			// 该方法返回值 显示在datagrid 
			if(value=="1"){
				return "已作废";
			}else if(value=="0"){
				return "正常使用";
			}
		}
	}, {
		field : 'standard',
		title : '取派标准',
		width : 120,
		align : 'center'
	}, {
		field : 'station',
		title : '所谓单位',
		width : 200,
		align : 'center'
	} ] ];
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 取派员信息表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true, // 占满父容器空间
			border : false, // 边框
			rownumbers : true, // 行号
			striped : true, // 条纹背景 
			pageList: [10,20,30], // 每页显示条数 
			pageSize: 20 ,
			pagination : true, // 显示分页工具条
			toolbar : toolbar, // 工具栏
			url : "${pageContext.request.contextPath}/staff_pageQuery.do", // 加载数据 
			method : 'get',
			idField : 'id', // 哪个列 是唯一标识
			columns : columns, // 定义列信息 
			onDblClickRow : doDblClickRow // 表格数据行 双击事件
		});
		
		// 添加取派员窗口
		$('#addStaffWindow').window({
	        title: '添加取派员',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		
		// 在页面加载后 对保存按钮 添加click 事件
		$('#save').click(function(){
			// 对form进行校验
			/*
			var id = $('#id').val().trim();
			if(id == ""){
				$.messager.alert('警告','取派员编号不能为空','warning');
				return ;
			}
			*/
			
			// 使用easyui校验
			if($('#staffForm').form('validate')){
				// 通过校验 
				$('#staffForm').submit();
			}
		});
	});
	

	function doDblClickRow(){
		alert("双击表格数据...");
	}
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<form id="delBatchForm" action="${pageContext.request.contextPath }/staff_delBatch.do" method="post">
		<div region="center" border="false">
	    	<table id="grid"></table>
		</div>
    </form>
	<div class="easyui-window" title="对收派员进行添加或者修改" id="addStaffWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="staffForm" action="${pageContext.request.contextPath }/staff_save.do" method="post"> 
				<table class="table-edit" width="80%" align="center"> 
					<tr class="title">
						<td colspan="2">收派员信息</td>
					</tr>
					<!-- TODO 这里完善收派员添加 table -->
					<tr>
						<td>取派员编号</td>
						<td><input type="text" name="id" id="id" 
							class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
						<td>姓名</td>
						<td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>手机</td>
						<td><input type="text" name="telephone" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>单位</td>
						<td><input type="text" name="station" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td colspan="2">
						<input type="checkbox" name="haspda" value="1" />
						是否有PDA</td>
					</tr>
					<tr>
						<td>取派标准</td>
						<td>
							<input type="text" name="standard" class="easyui-validatebox" required="true"/>  
						</td>
					</tr>
					</table>
			</form>
		</div>
	</div>
</body>
</html>	