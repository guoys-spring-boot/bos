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
<script type="text/javascript">
	// 工具栏
	var toolbar = [ {
		id : 'button-view',	
		text : '查看',
		iconCls : 'icon-search',
		handler : doView
	}, {
		id : 'button-add',
		text : '新增',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
	}];
	//定义冻结列
	var frozenColumns = [ [ {
		field : 'id',
		checkbox : true,
		rowspan : 2
	}, {
		field : 'username',
		title : '名称',
		width : 80,
		rowspan : 2
	} ] ];


	// 定义标题栏
	var columns = [ [ {
		field : 'gender',
		title : '性别',
		width : 60,
		rowspan : 2,
		align : 'center'
	}, {
		field : 'birthday',
		title : '生日',
		width : 120,
		rowspan : 2,
		align : 'center'
	}, {
		title : '其他信息',
		colspan : 2
	}, {
		field : 'telephone',
		title : '电话',
		width : 800,
		rowspan : 2
	} ], [ {
		field : 'station',
		title : '单位',
		width : 80,
		align : 'center'
	}, {
		field : 'salary',
		title : '工资',
		width : 80,
		align : 'right'
	} ] ];
	$(function(){
		// 初始化 datagrid
		// 创建grid
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
            total: 11,
            pagination: true,
			fit : true,
			border : false,
            singleSelect:true,
			rownumbers : true,
			striped : true,
			toolbar : toolbar,
			url : "/listUser",
			idField : 'id', 
			frozenColumns : frozenColumns,
			columns : columns,
			onClickRow : onClickRow,
			onDblClickRow : doDblClickRow
		});

		var pager = $("#grid").datagrid("getPager");
		if(pager){
		    pager.pagination({
                onBeforeRefresh:function(){
                    alert('before refresh');
                }
            })
        }

		$("#save").click(function(){
		    var userForm = $("#useForm");
            if(userForm.form('validate')){
                userForm.submit();
            }
        });
		
		$("body").css({visibility:"visible"});

        $("#addUserWindow").window('close');
		
	});
	// 双击
	function doDblClickRow(rowIndex, rowData) {
		var items = $('#grid').datagrid('selectRow',rowIndex);
		doView();
	}
	// 单击
	function onClickRow(rowIndex){

	}


	function doAdd() {
	    var userWindow = $("#addUserWindow");
        userWindow.window({
            width:700,
            height:400,
            modal:true
        });
        userWindow.window('open');
	}

	function doView() {
		alert("编辑用户");
		var item = $('#grid').datagrid('getSelected');
		console.info(item);
		//window.location.href = "edit.html";
	}

	function doDelete() {

		var ids = [];
		var items = $('#grid').datagrid('getSelections');
		for(var i=0; i<items.length; i++){
		    ids.push(items[i].id);	    
		}

		$.ajax("/deleteUser", {
		    data: {
		        ids:ids.join(",")
            },
            success: function (data) {
                $('#grid').datagrid('reload');
                $('#grid').datagrid('uncheckAll');
            }
        });

		

	}
</script>		
</head>
<body class="easyui-layout" style="visibility:hidden;">

<div class="easyui-window"  title="用户管理" id="addUserWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:100px;width: 800px; height: 500px; z-index: 1000">
    <div region="north" style="height:31px;overflow:hidden;" split="false" border="false" >
        <div class="datagrid-toolbar">
            <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
        </div>
    </div>
    <div region="center" style="overflow:auto;padding:5px;" border="false">
        <form id="useForm" method="post" action="/saveUser">
            <table class="table-edit"  width="95%" align="center">
                <tr class="title"><td colspan="4">基本信息</td></tr>
                <tr><td>用户名:</td><td><input type="text" name="username" id="username" class="easyui-validatebox" required="true" /></td>
                    <td>口令:</td><td><input type="password" name="password" id="password" class="easyui-validatebox" required="true" validType="minLength[5]" /></td></tr>
                <tr class="title"><td colspan="4">其他信息</td></tr>
                <tr><td>工资:</td><td><input type="text" name="salary" id="salary" class="easyui-numberbox" /></td>
                    <td>生日:</td><td><input type="text" name="birthday" id="birthday" class="easyui-datebox" /></td></tr>
                <tr><td>性别:</td><td>
                    <select name="gender" id="gender" class="easyui-combobox" style="width: 150px;">
                        <option value="">请选择</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </td>
                    <td>单位:</td><td>
                        <select name="station" id="station" class="easyui-combobox" style="width: 150px;">
                            <option value="">请选择</option>
                            <option value="总公司">总公司</option>
                            <option value="分公司">分公司</option>
                            <option value="厅点">厅点</option>
                            <option value="基地运转中心">基地运转中心</option>
                            <option value="营业所">营业所</option>
                        </select>
                    </td></tr>
                <tr>
                    <td>联系电话</td>
                    <td colspan="3">
                        <input type="text" name="telephone" id="telephone" class="easyui-validatebox" required="true" />
                    </td>
                </tr>
                <tr><td>备注:</td><td colspan="3"><textarea style="width:80%"></textarea></td></tr>
            </table>
        </form>
    </div>
</div>


    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>