<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script
        src="${pageContext.request.contextPath }/js/platform/common.js"
        type="text/javascript"></script>
<script
        src="${pageContext.request.contextPath }/js/jquery.form.min.js"
        type="text/javascript"></script>
</head>
<body class="easyui-layout"  >
	<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
		<div class="datagrid-toolbar" >
            <c:if test="${action eq 'add'}">
			    <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
            </c:if>
            <c:if test="${action eq 'update'}">
                <a id="update" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
            </c:if>
        </div>
	</div>
    <div region="center" style="height:600px;overflow:auto;padding:5px;" border="false">
       <form:form id="useForm" method="post" commandName="unit" action="/business/addUnit">
           <table class="table-edit"  width="95%" align="center">
           		<tr class="title"><td colspan="4">基本信息</td></tr>
	           	<tr>
                    <td>上级单位:</td><td><form:input path="parentUnitCode" disabled="${disabled}" type="text" class="easyui-validatebox" required="true" /></td>
					<td>归属区域:</td><td><form:input path="ascriptionArea" disabled="${disabled}" type="text" class="easyui-validatebox" required="true" /></td>
                </tr>
               <tr>
                   <td>机构代码:</td><td><form:input path="organizationCode" disabled="${disabled}" type="text" name="organizationCode" id="organizationCode" class="easyui-validatebox" required="true" /></td>
                   <td>单位全称:</td><td><form:input path="unitFullName" disabled="${disabled}" type="text" name="unitFullName" id="unitFullName" class="easyui-validatebox" required="true" /></td>
               </tr>
               <tr>
                   <td>单位简称:</td><td><form:input path="unitShortName" disabled="${disabled}" type="text" name="unitShortName" id="unitShortName" class="easyui-validatebox" required="true" /></td>
                   <td>单位类型:</td>
                   <td>
                       <form:input path="unitType" disabled="${disabled}" type="text" name="unitType" id="unitType" class="easyui-combobox" required="true" style="width: 150px;" />
                   </td>
               </tr>
				<tr class="title"><td colspan="4">其他信息</td></tr>
               <tr>
                   <td>单位性质:</td>
                   <td>
                       <form:input path="unitProperty" disabled="${disabled}" type="text" name="unitProperty" id="unitProperty" class="easyui-combobox" required="true" style="width: 150px;" />
                   </td>
                   <td>单位等级:</td>
                   <td>
                       <form:input path="unitLevel" disabled="${disabled}" type="text" name="unitLevel" id="unitLevel" class="easyui-combobox" required="true" style="width: 150px;" />
                   </td>
               </tr>
               <tr>
                   <td>单位人数:</td><td><form:input disabled="${disabled}" path="unitPersonCount" type="text" name="unitPersonCount" id="unitPersonCount" class="easyui-numberbox" required="true" /></td>
                   <td>单位法人:</td><td><form:input disabled="${disabled}" path="legalEntity" type="text" name="legalEntity" id="legalEntity" class="easyui-validatebox" required="true" /></td>
               </tr>
               <tr>
                   <td>单位法人电话:</td><td><form:input disabled="${disabled}" path="legalEntityTelNum" type="text" name="legalEntityTelNum" id="legalEntityTelNum" class="easyui-numberbox" required="true"  /></td>
                   <td>分管领导:</td><td><form:input disabled="${disabled}" path="legalEntityTelNum" type="text" name="leader" id="leader" class="easyui-validatebox" required="true" /></td>
               </tr>
	           	<tr>
                    <td>分管领导电话:</td><td><form:input disabled="${disabled}" path="leaderTelNum" type="text" name="leaderTelNum" id="leaderTelNum" class="easyui-numberbox" required="true" /></td>
					<td>单位联系人:</td><td><form:input disabled="${disabled}" path="unitContactPerson" type="text" name="unitContactPerson" id="unitContactPerson" class="easyui-validatebox" required="true" /></td>
                </tr>
	           	<tr>
                    <td>单位联系人电话:</td><td>
                        <form:input path="unitContactPersonTelNum" disabled="${disabled}" type="text" name="unitContactPersonTelNum" id="unitContactPersonTelNum" class="easyui-validatebox" required="true" />
	           	    </td>
					<td>单位联系人qq:</td><td>
                    <form:input path="contactQQ" type="text" disabled="${disabled}" name="contactQQ" id="contactQQ" class="easyui-numberbox" required="true" />
				    </td>
                </tr>
				<tr>
					<td>联系人邮箱：</td>
					<td colspan="1">
						<form:input path="contactEmail" disabled="${disabled}" type="text" name="contactEmail" id="contactEmail" class="easyui-validatebox" required="true" />
					</td>
                    <td>登录名：</td>
                    <td colspan="1">
                        <form:input path="username" disabled="${disabled}" type="text" name="username" id="username" class="easyui-validatebox" required="true" />
                    </td>
				</tr>
               <tr>
                   <td>登录密码:</td>
                   <td>
                        <form:input path="password" disabled="${disabled}" type="password" name="password" id="password" class="easyui-validatebox" required="true" />
                    </td>
                   <td>审核状态:</td><td>
                       <form:input path="auditingStatus" disabled="${disabled}" type="text" name="auditingStatus" id="auditingStatus" class="easyui-combobox" required="true" style="width: 150px;" />
                    </td>
               </tr>
               <tr><td>是否为区域管理:</td>
                   <td colspan="3">
                       <form:input path="isAdmin" disabled="${disabled}" type="text" name="isAdmin" id="isAdmin" class="easyui-combobox" required="true" />
                   </td>
               </tr>
	           	<tr><td>单位地址:</td><td colspan="3"><form:textarea path="unitAddress" disabled="${disabled}" id="unitAddress" name="unitAddress" required="true" style="width:80%" /></td></tr>
           </table>
           <form:hidden path="id"/>
       </form:form>
		<script type="text/javascript">

            $(function () {

                $("#save").click(function(){
                    var userForm = $("#useForm");
                    if(userForm.form('validate')){
                        userForm.submit(function () {
                            $(this).ajaxForm(function () {
                                alert(134);
                            });
                            return false;
                        });
                    }
                });

                $("#update").click(function(){
                    var userForm = $("#useForm");
                    if(userForm.form('validate')){
                        userForm.attr("action", "/business/updateUnit");
                        userForm.submit();
                    }
                });

                $.enumCombobox('unitLevel', 'unitLevel');
                $.enumCombobox('auditingStatus', 'auditingStatus');
                $.enumCombobox('unitProperty', 'unitProperty');
                $.enumCombobox('unitType', 'unitType');
                $.enumCombobox('isAdmin', 'yesOrNo');

            });

		</script>
	</div>
</body>
</html>