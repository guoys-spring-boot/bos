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
<jsp:include page="${pageContext.request.contextPath}/common/reference.jsp" />
<script type="text/javascript">

    var dialogOptions = {
        onDestroy: function () {
            reloadGrid();
            $("#addUserWindow").window('destroy');

        }
    };

    function openLookupPage(id) {

        var url = '${pageContext.request.contextPath}/business/toLookupUnit?unitId=' + id;
        $(window).openWindow('addUserWindow', url, 750, 570, '用户管理', dialogOptions);
    }

    function openEditPage(id) {
        var url = '${pageContext.request.contextPath}/business/toUpdateUnit?unitId=' + id;
        $(window).openWindow('addUserWindow', url, 750, 570, '用户管理', dialogOptions);

    }

    function pass(id) {
        $(this)._confirm("确定要通过这条记录?", function () {
            updateAuditingStatus(id, '1');
        });
    }

    function refuse(id) {
        $(this)._confirm("确定要拒绝这条记录?", function () {
            updateAuditingStatus(id, '3');
        });
    }
    
    function doResetPsd() {
        var url = "${path}/business/resetPwd";

        var selected = $('#grid').datagrid('getSelected');
        if(selected == null){
            $(this)._alert("请选中一行");
            return;
        }

        $(this)._confirm("确定重置密码?", function () {
            $.ajax(url, {
                data : {
                    id : selected.id
                },
                success: function(){
                    $(this)._alert("密码已经重置为123456", "提示");
                },
                async: false
            })
        });
    }

    function updateAuditingStatus(id, status) {
        var url = "${path}/business/updateUnit";
        $.ajax(url, {
            data : {
                id : id,
                auditingStatus : status
            },
            success: function(){
                window.parent.reloadGrid();
            },
            async: false
        })
    }

	// 工具栏
	var toolbar = '#toolbar';

	var unitTypes = $.loadEnum('unitType');
	var unitProperty = $.loadEnum('unitProperty');
	var unitLevel = $.loadEnum('unitLevel');
	var isAdmin = $.loadEnum('yesOrNo');
	var auditingStatus = $.loadEnum('auditingStatus');

	var ascriptionArea = $.loadEnum('ascriptionArea');

	//定义冻结列
	var frozenColumns = [[{
		field : 'id',
		checkbox : true,
		rowspan : 1
	}, {
		field : 'organizationCode',
		title : '单位代码',
		width : 200,
		rowspan : 1,
        sortable : false
	},
        {
            field : 'unitFullName',
            title : '单位名称',
            width : 200,
            rowspan : 1,
            sortable : false,
            formatter: function (value, row, index) {
                if(row.id){
                    return "<a href='#' onclick=\"openLookupPage('"+row.id+"')\">" + value + "</a>";
                }else {
                    return value;
                }
            }
        }]];


	// 定义标题栏
	var columns = [[ {
		field : 'ascriptionArea',
		title : '归属区域',
        width : 200,
		rowspan : 1,
        formatter : function(value, row, index){
            return ascriptionArea[value];
        }
	}, {
		field : 'unitType',
		title : '单位类型',
        width : 200,
		rowspan : 1,
        formatter : function(value, row, index){
		    return unitTypes[value];
        }
	}, {
		field : 'unitProperty',
		title : '单位性质',
        width : 200,
		rowspan : 1,
        formatter : function(value, row, index){
            return unitProperty[value];
        }
	} , {
		field : 'unitLevel',
		title : '文明单位等级',
        width : 200,
        formatter : function(value, row, index){
            return unitLevel[value];
        }
	}, {
		field : 'isAdmin',
		title : '是否为管理员',
        width : 200,
        formatter : function(value, row, index){
            return isAdmin[value];
        }
	} , {
        field : 'auditingStatus',
        title : '审核状态',
        width : 200,
        formatter : function(value, row, index){
            return auditingStatus[value];
        }
    }, {
        field : 'op',
        title : '审核状态',
        width : 200,
        formatter : function(value, row, index){
            if(row.auditingStatus != '1' && row.auditingStatus != '3'){
                return "<a href='#' onclick=\"pass('"+row.id+"')\">通过</a>&nbsp;<a href='#' onclick=\"refuse('"+row.id+"')\" >拒绝</a>"
            }
        }
    }
    ]];

	// 双击
	function doDblClickRow(rowIndex, rowData) {
        openLookupPage(rowData.id);
	}
	// 单击
	function onClickRow(rowIndex){
		$("#grid").datagrid('beginEdit', rowIndex);
	}

	function doEdit() {
        var item = $('#grid').datagrid('getSelected');
        openEditPage(item.id);
    }


	function doAdd() {
        $(window).openWindow('addUserWindow', '${pageContext.request.contextPath}/business/toAddUnit', 750, 570, '用户管理', dialogOptions);
		//$(window)._openTab("tabs", '${pageContext.request.contextPath}/business/toAddUnit', '用户管理', window.top);
	}

	function doDelete() {

		var ids = [];
		var items = $('#grid').datagrid('getSelections');
		for(var i=0; i<items.length; i++){
		    ids.push(items[i].id);	    
		}

		if(ids.length <=0){
		    $(this)._alert("没有选中的行");
		    return;
        }

        $(this)._confirm("确定要删除?", function () {
            $.ajax("${path}/business/deleteUnit", {
                data: {
                    ids:ids.join(",")
                },
                success: function (data) {
                    //$('#grid').datagrid('reload');
                    //$('#grid').datagrid('uncheckAll');
                    window.parent.reloadGrid();
                }
            });
        });
	}

	function reloadGrid() {
        $("#grid").datagrid('reload', {
            unitLevel: $("input[name='unitLevel']").val(),
            auditingStatus: $("input[name='auditingStatus']").val(),
            parentUnitCode : $("input[name='parentUnitCode']").val(),
            unitFullName : $("#unitFullName").val()
        });
    }
    $(function(){
        // 初始化 datagrid
        // 创建grid
        $('#grid').datagrid( {
            iconCls : 'icon-forward',
            pagination: true,
            fit : true,
            fitColumns: true,
            border : false,
            pageSize: 20,
            singleSelect:true,
            rownumbers : true,
            striped : true,
            toolbar : toolbar,
            url : "/business/listUnit",
            queryParams : {
                parentUnitCode : "${sessionScope.user.id}"
            },
            idField : 'id',
            frozenColumns : frozenColumns,
            columns : columns,
            onClickRow : onClickRow,
            onDblClickRow : doDblClickRow
        });

        window.parent.reloadGrid();

        var pager = $("#grid").datagrid("getPager");
        if(pager){
            pager.pagination({
                onBeforeRefresh:function(){

                }
            })
        }


        $("body").css({visibility:"visible"});

        $("#addUserWindow").window('close');

        $.enumCombobox('unitLevel', 'unitLevel');
        $.enumCombobox('auditingStatus', 'auditingStatus');
        $.enumComboboxFromUrl('parentUnitCode', '${path}/business/listAllParentUnit');

        $("#queryBtn").click(reloadGrid)

    });
</script>		
</head>
<body class="easyui-layout" style="visibility:hidden;">

    <div id="toolbar">
        <table class="table-edit" width="100%" >
            <tr>
                <td>
                    <b>上级单位</b><span class="operator"><a name="username-opt" opt="all"></a></span>
                    <c:if test="${sessionScope.user.isAdmin()}">
                        <input type="text" id="parentUnitCode" name="parentUnitCode"/>
                    </c:if>
                    <c:if test="${!sessionScope.user.isAdmin()}">
                        <input readonly="readonly" type="text" id="parentUnitCode" value="${sessionScope.user.id}" name="parentUnitCode"/>
                    </c:if>

                    <b>单位名称</b><span class="operator"><a name="username-opt" opt="all"></a></span>
                    <input type="text" class="easyui-textbox" id="unitFullName" name="unitFullName"/>

                    <b>单位等级</b><span class="operator"><a name="gender-opt" opt="all"></a></span>
                    <input id="unitLevel" name="unitLevel" value="">

                    <b>审核状态</b><span class="operator"><a name="birthday-opt" opt="date"></a></span>
                    <input id="auditingStatus" name="auditingStatus" value="">

                    <a id="queryBtn" href="#" class="easyui-linkbutton" plain="true" icon="icon-search">查询</a>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="#" class="easyui-linkbutton" onclick="doEdit()" data-options="iconCls:'icon-edit',plain:true">修改</a>
                    <a href="#" class="easyui-linkbutton" onclick="doAdd()" data-options="iconCls:'icon-add',plain:true">新增</a>
                    <a href="#" class="easyui-linkbutton" onclick="doDelete()" data-options="iconCls:'icon-cancel',plain:true">删除</a>
                    <a href="#" class="easyui-linkbutton" onclick="doResetPsd()" data-options="iconCls:'icon-edit',plain:true">重置密码</a>
                </td>
            </tr>
        </table>
    </div>

    <div region="center" border="false">
    	<table id="grid"></table>
	</div>
</body>
</html>