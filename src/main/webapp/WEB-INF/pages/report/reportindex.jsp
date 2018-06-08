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
	$(function(){
		$("body").css({visibility:"visible"});
		// 注册按钮事件
	});
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
    <div region="center" style="overflow:hidden;" border="false">
		<iframe id="list" src="${pageContext.request.contextPath }/page.do?module=report&resource=reportlist" scrolling="no" style="width:100%;height:100%;border:0;"></iframe>
    </div>
</body>
</html>