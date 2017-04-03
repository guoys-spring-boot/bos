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
	<!-- 菜单按钮 -->
	<!-- icon-add 是按钮样式，在easyui icon.css定义 -->
	<a href="javascript:void(0)" class="easyui-menubutton" 
		data-options="iconCls:'icon-help',menu:'#mm'">控制面板</a>
	<!-- 按钮下拉菜单 -->
	<div id="mm">
		<div>菜单一</div>
		<div>菜单二</div>
		<div class="menu-sep"></div> 
		<div>菜单三</div>
	</div>
</body>
</html>