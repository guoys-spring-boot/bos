<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<!-- 导入jquery核心类库 -->
<script type="text/javascript"
        src="${path}/js/jquery-1.8.3.js"></script>
<!-- 导入easyui类库 -->
<link rel="stylesheet" type="text/css" id="easyuiTheme"
      href="${path}/js/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css"
      href="${path}/js/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
      href="${path}/js/easyui/ext/portal.css">
<link rel="stylesheet" type="text/css"
      href="${path}/css/default.css">

<link rel="stylesheet" type="text/css" href="${path}/css/attachmentIcon.css" >
<script type="text/javascript"
        src="${path}/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
        src="${path}/js/easyui/ext/jquery.portal.js"></script>
<script type="text/javascript"
        src="${path}/js/easyui/ext/jquery.cookie.js"></script>
<script
        src="${path}/js/easyui/locale/easyui-lang-zh_CN.js"
        type="text/javascript"></script>
<script
        src="${path}/js/platform/common.js"
        type="text/javascript"></script>
<script
        src="${path}/js/jquery.form.min.js"
        type="text/javascript"></script>
<script
        src="${pageContext.request.contextPath }/js/easyui/outOfBounds.js"
        type="text/javascript"></script>

<script src="${path}/common/checkLogin.js"></script>

<script src="${path}/js/easyui/ext/datagrid-detailview.js" type="text/javascript"></script>
<script src="${path}/js/easyui/jquery.ajaxfileupload.js" type="text/javascript"></script>
<script src="${path}/js/ocupload/jquery.ocupload-1.1.2.js" type="text/javascript"></script>

<style src="${path}/fontAwesome/css/fontawesome-all.min.css" ></style>

<script type="text/javascript">
    var $easyuiTheme = window.top.$("#easyuiTheme");
    var href = $easyuiTheme.attr('href');
    if (href) {
        $("#easyuiTheme").attr('href', href);
    }
</script>