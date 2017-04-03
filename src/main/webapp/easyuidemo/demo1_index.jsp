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
<body class="easyui-layout">
	<div data-options="region:'north',title:'标题'" style="height: 100px;">北部</div>
	<div data-options="region:'west',title:'菜单面板'" style="width: 200px;">
		<!-- 折叠面板  fit:true 使组件适应父容器大小-->
		<div class="easyui-accordion" data-options="fit:true">
			<div data-options="title:'基本功能'">基本功能</div>
			<div data-options="title:'系统管理'">系统管理</div>
		</div>
	</div>
	<div data-options="region:'center'">
		<!-- 选项卡面板  -->
		<div class="easyui-tabs" data-options="fit:true">
			<div data-options="title:'面板一'">面板一</div>
			<div data-options="title:'面板二',closable:true">面板二</div>
			<div data-options="title:'面板三'">面板三</div>
		</div>
	</div>
	<div data-options="region:'south'" style="height: 100px;">南部</div>
</body>
</html>