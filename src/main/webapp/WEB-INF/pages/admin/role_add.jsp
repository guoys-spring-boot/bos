<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!-- 导入ztree类库 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"
	type="text/css" />
<script
	src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"
	type="text/javascript"></script>	

</head>
<body class="easyui-layout">
		<div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		<div region="center" style="overflow:auto;padding:5px;" border="false">
			<form id="roleForm" action="${pageContext.request.contextPath }/role_save.do" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">角色信息</td>
					</tr>
					<tr>
						<td>名称</td>
						<td><input type="text" name="name" class="easyui-validatebox" data-options="required:true" /></td>
					</tr>
					<tr>
						<td>描述</td>
						<td>
							<textarea name="description" rows="4" cols="60"></textarea>
						</td>
					</tr>
					<tr>
						<td>授权</td>
						<td>
							<input type="hidden" id="functionIds" name="functionIds" />
							<ul id="functionTree" class="ztree"></ul>
						</td>
					</tr>
					</table>
			</form>
			<script type="text/javascript">
                $(function(){
                    // 授权树初始化
                    var setting = {
                        data : {
                            key : {
                                title : "t"
                            },
                            simpleData : {
                                enable : true,
                                pIdKey : "_parentId"
                            }
                        },
                        check : {
                            enable : true
                        }
                    };

                    $.ajax({
                        url : '${pageContext.request.contextPath}/function_menu.do',
                        type : 'POST',
                        dataType : 'text',
                        success : function(data) {
                            var zNodes = eval("(" + data + ")");
                            if(zNodes && zNodes.rows){
                                $.fn.zTree.init($("#functionTree"), setting, zNodes.rows);
                            }

                        },
                        error : function(msg) {
                            alert('树加载异常!');
                        }
                    });



                    // 点击保存
                    $('#save').click(function(){
                        if($('#roleForm').form('validate')){
                            // 获取ztree 勾选内容，赋值 页面隐藏域中
                            var treeObj = $.fn.zTree.getZTreeObj("functionTree");
                            var nodes = treeObj.getCheckedNodes(true);

                            var ids = [];
                            for(var i=0; i<nodes.length ; i++){
                                ids.push(nodes[i].id); // 加入数组
                            }
                            $('#functionIds').val(ids.join(","));

                            // 提交表单
                            $('#roleForm').submit();
                        }
                    });
                });
			</script>
		</div>
</body>
</html>