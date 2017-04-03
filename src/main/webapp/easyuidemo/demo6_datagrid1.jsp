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

</head>
<body>
	<h1>案例一： datagrid 对本地HTML数据使用</h1>
	<!-- 
		对table 添加 class="easyui-datagrid"
		必须添加 <thead> <tbody> 标记
		为表格每一列，指定 field属性
	 -->
	<table  class="easyui-datagrid" >
		<thead>
			<tr>
				<th data-options="field:'id'">编号</th>
				<th data-options="field:'product'">商品名称</th>
				<th data-options="field:'price'">商品价格</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>1</td>
				<td>数码相机</td>
				<td>1999</td>
			</tr>
			<tr>
				<td>2</td>
				<td>笔记本</td>
				<td>4999</td>
			</tr>
		</tbody>
	</table>
	<h1>案例二： datagrid 对远程json数据使用</h1>
	<table  class="easyui-datagrid" 
		data-options="url:'${pageContext.request.contextPath }/json/data.json',method:'get',
			rownumbers:true, pagination:true,toolbar:'#tb'">
		<thead>
			<tr>
				<th data-options="field:'id'">编号</th>
				<th data-options="field:'product'">商品名称</th>
				<th data-options="field:'price'">商品价格</th>
			</tr>
		</thead>
	</table>
	
	<!-- 工具栏 -->
	<div id="tb">
		<!-- 每个按钮定义 a 标签 -->
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="#" class="easyui-linkbutton">修改</a>
	</div>
</body>
</html>