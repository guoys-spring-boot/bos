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
<!-- 引入ztree -->
<script type="text/javascript" src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"/>

<script type="text/javascript">
	$(function(){
		// 页面加载后执行	
		// ztree设置
		var setting = {};
		
		// ztree数据（标准json）
		var zNodes = [
			{name:'菜单1'},
			{name:'菜单2',children:[ // children 子菜单
				{name:'菜单21'},
				{name:'菜单22'}
			]},
			{name:'菜单3'}
		];
		
		// 初始化 ztree
		$.fn.zTree.init($("#basicTree"), setting, zNodes);
		
		// ==================================================================
		// ztree 设置	
		var setting = {
				data: {
					simpleData: {
						enable: true // 可以使用简单数据
					}
				},
				callback :{ // 点击每个节点触发事件
					onClick : function(event, treeId, treeNode, clickFlag){
						if(treeNode.page != undefined){
							// 存在page属性 
							// 判断对应选项卡是否存在
							if($('#mytabs').tabs('exists',treeNode.name)){
								// 存在，切换到目标选项卡
								$('#mytabs').tabs('select',treeNode.name)
							}else{
								// 不存在
								// 在tabs 选项卡布局，添加新的选项卡
								$('#mytabs').tabs('add',{
									title: treeNode.name,
									content : '<div style="width:100%;height:100%;overflow:hidden;">'
										+ '<iframe src="'
										+ treeNode.page
										+ '" scrolling="auto" style="width:100%;height:100%;border:0;" ></iframe></div>', // 显示page网页内容
									closable:true // 可以关闭
								});
							}
						}
					}
				}
		};	
		
		// ztree数据 （简单json）
		var zNodes = [
			{name:'菜单1',id: 1, pId:0}, // id代表本节点编号，pId代表父节点编号
			{name:'菜单2',id: 2, pId:0, icon:'${pageContext.request.contextPath}/js/ztree/img/diy/7.png'},
			{name:'传智播客',id: 3, pId:2, page:"http://www.itcast.cn"},
			{name:'百度',id: 4, pId:2, page:"http://www.baidu.com"},
		]
		
		// 初始化ztree
		$.fn.zTree.init($("#adminTree"), setting, zNodes);
	});
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',title:'标题'" style="height: 100px;">北部</div>
	<div data-options="region:'west',title:'菜单面板'" style="width: 200px;">
		<!-- 折叠面板  fit:true 使组件适应父容器大小-->
		<div class="easyui-accordion" data-options="fit:true">
			<div data-options="title:'基本功能'">
				<!-- 显示ztree 标准json-->
				<ul class="ztree" id="basicTree"></ul>
			</div>
			<div data-options="title:'系统管理'">
				<!-- 简单json ztree -->
				<ul class="ztree" id="adminTree"></ul>
			</div>
		</div>
	</div>
	<div data-options="region:'center'">
		<!-- 选项卡面板  -->
		<div id="mytabs" class="easyui-tabs" data-options="fit:true">
			<div data-options="title:'面板一'">面板一</div>
			<div data-options="title:'面板二',closable:true">面板二</div>
			<div data-options="title:'面板三'">面板三</div>
		</div>
	</div>
	<div data-options="region:'south'" style="height: 100px;">南部</div>
</body>
</html>