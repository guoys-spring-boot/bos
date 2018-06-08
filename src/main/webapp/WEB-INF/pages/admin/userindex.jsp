<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 导入jquery核心类库 -->
	<jsp:include page="${pageContext.request.contextPath}/common/reference.jsp" />
    <script type="text/javascript">
	function reloadGrid() {
        var elWin = $("#list").get(0).contentWindow;
        elWin.$("#grid").datagrid('reload', {
            unitLevel: $("input[name='unitLevel']").val(),
            auditingStatus: $("input[name='auditingStatus']").val(),
            parentUnitCode : $("input[name='parentUnitCode']").val(),
            unitFullName : $("#unitFullName").val()
        });
    }
	$(function(){
		$("body").css({visibility:"visible"});
		// 注册按钮事件
		$('#reset').click(function() {
			$('#form').form("clear");
		});
		// 注册所有下拉控件
		$("select").combobox( {
			width : 155,
			listWidth : 180,
			editable : true
		});
		// 注册ajax查询
		$('#ajax').click(function() {
			reloadGrid();
		});
		//reloadGrid();
        $.enumCombobox('unitLevel', 'unitLevel');
        $.enumCombobox('auditingStatus', 'auditingStatus');
        $.enumComboboxFromUrl('parentUnitCode', '${path}/business/listAllParentUnit');

	});
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
    <div region="center" style="overflow:hidden;" border="false">
		<iframe id="list" src="${pageContext.request.contextPath }/page.do?module=admin&resource=userlist" scrolling="no" style="width:100%;height:100%;border:0;"></iframe>
    </div>
</body>
</html>