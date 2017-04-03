<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<!-- 先引入jquery js -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.js" ></script>
<!-- 引入jquery easyui -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/js/easyui/themes/icon.css"/>
<script type="text/javascript">
	// 全局变量
	var editrowindex ;

	$(function(){
		$("#grid").datagrid({
			columns : [[
			    {
			    	field : 'id',
			    	title : '编号',
			    	width : 200,
			    	align:'center'
			    },{
			    	field : 'product',
			    	title : '商品名称',
			    	width : 200,
			    	align:'center',
			    	editor : {
			    		type : 'validatebox',
			    		options: {
			    			required: true
			    		}
			    	}
			    },{
			    	field : 'price',
			    	title : '价格',
			    	width : 200,
			    	align:'center'
			    }
			]], //列信息
			url : '${pageContext.request.contextPath }/json/data.json',
			method : 'get',
			pagination : true,
			rownumbers : true,
			singleSelect: true,
			toolbar : [
				{
					id : 'add',
					text: '添加',
					iconCls : 'icon-add',
					handler : function(){
						alert("被点了！");
					}
				},
				{
					id : 'edit',
					text: '编辑',
					iconCls : 'icon-edit',
					handler : function(){
						var row = $('#grid').datagrid('getSelected'); // 编辑行
						var index = $('#grid').datagrid('getRowIndex',row); // 行号
						$('#grid').datagrid('beginEdit',index);// 开启编辑状态
						editrowindex = index;
					}
				},
				{
					id : 'save',
					text: '保存',
					iconCls : 'icon-save',
					handler : function(){
						$('#grid').datagrid('endEdit',editrowindex);
					}
				},
				{
					id : 'cancel',
					text: '取消',
					iconCls : 'icon-cancel',
					handler : function(){
						$('#grid').datagrid('cancelEdit',editrowindex);
						editrowindex = undefined;
					}
				}
			],
			onAfterEdit : function(rowIndex, rowData, changes){
				editrowindex = undefined; // 重置undefined
			}
		});
	});
</script>
</head>
<body>
	<h1>datagrid 行编辑效果</h1>
	<table id="grid"></table>
</body>
</html>