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
	$(function(){
		// 警告窗口 
		// $.messager.alert("窗口标题","窗口内容","warning");
		
		// 确认窗口
		// fn(b): 回调函数,当用户单击Ok按钮,通过true函数,否则通过false来它。 
		//$.messager.confirm("窗口标题","要离开吗？",function(isConfirm){
			//alert(isConfirm);
		//});
		
		// 右下角提示框
		$.messager.show({
			title : '窗口标题',
			msg : '<a href="#">内容</a>',
			timeout : 5000 // 5秒自动消失
		});
	});
</script>

</head>
<body>
</body>
</html>