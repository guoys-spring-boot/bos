<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理定区/调度排班</title>
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
	function doAdd(){
		$('#addDecidedzoneWindow').window("open");
	}
	
	function doEdit(){
		alert("修改...");
	}
	
	function doDelete(){
		alert("删除...");
	}
	
	function doSearch(){
		$('#searchWindow').window("open");
	}
	
	function doAssociations(){
		// 获得选中数据行 
		var row = $('#grid').datagrid('getSelected');
		if(row == null){
			// 没有选中
			$.messager.alert('警告','关联客户前，必须选中一条定区数据 ','warning');
			return
		}
		
		$('#noassociationSelect').html('');
		$('#associationSelect').html('');
		
		// 加载 窗口中两个select 列表数据
		// 查询未关联
		$.post("${pageContext.request.contextPath}/decidedzone_findnoassociationCustomers.do" , function(data){
			$(data).each(function(){
				var option = $("<option value='"+this.id+"'>"+this.name+"("+this.address+")</option>");
				$('#noassociationSelect').append(option);
			});
		});
		
		// 查询已经关联
		$.post("${pageContext.request.contextPath}/decidedzone_findhasassociationCustomers.do" , {id: row.id},function(data){
			$(data).each(function(){
				var option = $("<option value='"+this.id+"'>"+this.name+"("+this.address+")</option>");
				$('#associationSelect').append(option);
			});
		});
		
		$('#customerWindow').window('open');
	}
	
	//工具栏
	var toolbar = [ {
		id : 'button-search',	
		text : '查询',
		iconCls : 'icon-search',
		handler : doSearch
	}, {
		id : 'button-add',
		text : '增加',
		iconCls : 'icon-add',
		handler : doAdd
	}, {
		id : 'button-edit',	
		text : '修改',
		iconCls : 'icon-edit',
		handler : doEdit
	},{
		id : 'button-delete',
		text : '删除',
		iconCls : 'icon-cancel',
		handler : doDelete
	},{
		id : 'button-association',
		text : '关联客户',
		iconCls : 'icon-sum',
		handler : doAssociations
	}];
	// 定义列
	var columns = [ [ {
		field : 'id',
		title : '定区编号',
		width : 120,
		align : 'center'
	},{
		field : 'name',
		title : '定区名称',
		width : 120,
		align : 'center'
	}, {
		field : 'staff.name',
		title : '负责人',
		width : 120,
		align : 'center',
		formatter : function(data,row ,index){
			return row.staff.name;
		}
	}, {
		field : 'staff.telephone',
		title : '联系电话',
		width : 120,
		align : 'center',
		formatter : function(data,row ,index){
			return row.staff.telephone;
		}
	}, {
		field : 'staff.station',
		title : '所属公司',
		width : 120,
		align : 'center',
		formatter : function(data,row ,index){
			return row.staff.station;
		}
	} ] ];
	
	$.fn.serializeJson=function(){  
        var serializeObj={};  
        var array=this.serializeArray();  
        var str=this.serialize();  
        $(array).each(function(){  
            if(serializeObj[this.name]){  
                if($.isArray(serializeObj[this.name])){  
                    serializeObj[this.name].push(this.value);  
                }else{  
                    serializeObj[this.name]=[serializeObj[this.name],this.value];  
                }  
            }else{  
                serializeObj[this.name]=this.value;   
            }  
        });  
        return serializeObj;  
    }; 
	
	$(function(){
		// 先将body隐藏，再显示，不会出现页面刷新效果
		$("body").css({visibility:"visible"});
		
		// 收派标准数据表格
		$('#grid').datagrid( {
			iconCls : 'icon-forward',
			fit : true,
			border : true,
			rownumbers : true,
			striped : true,
			pageList: [30,50,100],
			pagination : true,
			toolbar : toolbar,
			url : "${pageContext.request.contextPath}/decidedzone_pageQuery.do",
			idField : 'id',
			columns : columns,
			onDblClickRow : doDblClickRow,
			singleSelect : true
		});
		
		// 添加、修改定区
		$('#addDecidedzoneWindow').window({
	        title: '添加修改定区',
	        width: 600,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		
		// 查询定区
		$('#searchWindow').window({
	        title: '查询定区',
	        width: 400,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 400,
	        resizable:false
	    });
		// 执行查询 
		$("#btn").click(function(){
			// 将form 参数转换为json
			var params = $('#searchForm').serializeJson();
			// 数据表格缓存
			$('#grid').datagrid('load',params);
			
			// 关闭查询窗口 
			$('#searchWindow').window('close');
		});
		
		// 添加save按钮 click 事件
		$('#save').click(function(){
			if($('#decidedZoneForm').form('validate')){
				$('#decidedZoneForm').submit();
			}
		});
		
		// 左右移动
		$('#toRight').click(function(){
			$('#associationSelect').append($('#noassociationSelect option:selected'));
		});
		$('#toLeft').click(function(){
			$('#noassociationSelect').append($('#associationSelect option:selected'));
		});
		
		// 关联客户
		$('#associationBtn').click(function(){
			// 先把右侧select option 都选中，然后提交 
			$('#associationSelect option').attr('selected','selected');
			// 为隐藏 定区id 设值
			$('#customerDecidedZoneId').val($('#grid').datagrid('getSelected').id);
			
			$('#customerForm').submit();
		});
	});

	function doDblClickRow(){
		alert("双击表格数据...");
		$('#association_subarea').datagrid( {
			fit : true,
			border : true,
			rownumbers : true,
			method : 'get',
			striped : true,
			url : "${pageContext.request.contextPath}/json/association_subarea.json",
			columns : [ [{
				field : 'id',
				title : '分拣编号',
				width : 120,
				align : 'center'
			},{
				field : 'province',
				title : '省',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					return row.region.province;
				}
			}, {
				field : 'city',
				title : '市',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					return row.region.city;
				}
			}, {
				field : 'district',
				title : '区',
				width : 120,
				align : 'center',
				formatter : function(data,row ,index){
					return row.region.district;
				}
			}, {
				field : 'addresskey',
				title : '关键字',
				width : 120,
				align : 'center'
			}, {
				field : 'startnum',
				title : '起始号',
				width : 100,
				align : 'center'
			}, {
				field : 'endnum',
				title : '终止号',
				width : 100,
				align : 'center'
			} , {
				field : 'single',
				title : '单双号',
				width : 100,
				align : 'center'
			} , {
				field : 'position',
				title : '位置',
				width : 200,
				align : 'center'
			} ] ]
		});
		$('#association_customer').datagrid( {
			fit : true,
			border : true,
			rownumbers : true,
			method : 'post',
			striped : true,
			queryParams : {
				id : $('#grid').datagrid('getSelected').id
			},
			url : "${pageContext.request.contextPath}/decidedzone_findhasassociationCustomers.do",
			columns : [[{
				field : 'id',
				title : '客户编号',
				width : 120,
				align : 'center'
			},{
				field : 'name',
				title : '客户名称',
				width : 120,
				align : 'center'
			}, {
				field : 'telephone',
				title : '手机号',
				width : 120,
				align : 'center'
			}]]
		});
		
	}
</script>	
</head>
<body class="easyui-layout" style="visibility:hidden;">
	<div region="center" border="false">
    	<table id="grid"></table>
	</div>
	<div region="south" border="false" style="height:150px">
		<div id="tabs" fit="true" class="easyui-tabs">
			<div title="关联分区" id="subArea"
				style="width:100%;height:100%;overflow:hidden">
				<table id="association_subarea"></table>
			</div>	
			<div title="关联客户" id="customers"
				style="width:100%;height:100%;overflow:hidden">
				<table id="association_customer"></table>
			</div>	
		</div>
	</div>
	
	<!-- 添加 修改分区 -->
	<div class="easyui-window" title="定区添加修改" id="addDecidedzoneWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div style="height:31px;overflow:hidden;" split="false" border="false" >
			<div class="datagrid-toolbar">
				<a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
			</div>
		</div>
		
		<div style="overflow:auto;padding:5px;" border="false">
			<form id="decidedZoneForm" action="${pageContext.request.contextPath }/decidedzone_save.do" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">定区信息</td>
					</tr>
					<tr>
						<td>定区编码</td>
						<td><input type="text" name="id" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>定区名称</td>
						<td><input type="text" name="name" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>选择负责人</td>
						<td>
							<input class="easyui-combobox" name="staff.id"  
    							data-options="valueField:'id',textField:'name',
    							url:'${pageContext.request.contextPath }/staff_ajaxlist.do'" />  
						</td>
					</tr>
					<tr height="300"> 
						<td valign="top">关联分区</td>
						<td>
							<table id="subareaGrid"  class="easyui-datagrid" border="false" 
								style="width:300px;height:300px" 
								data-options="url:'${pageContext.request.contextPath }/subarea_findNoAssociations.do',
								fitColumns:true,singleSelect:false">
								<thead>  
							        <tr>  
							            <th data-options="field:'subareaId',width:30,checkbox:true">编号</th>  
							            <th data-options="field:'addresskey',width:150">关键字</th>  
							            <th data-options="field:'position',width:200,align:'right'">位置</th>  
							        </tr>  
							    </thead> 
							</table>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 查询定区 -->
	<div class="easyui-window" title="查询定区窗口" id="searchWindow" collapsible="false" minimizable="false" maximizable="false" style="top:20px;left:200px">
		<div style="overflow:auto;padding:5px;" border="false">
			<form id="searchForm">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="2">查询条件</td>
					</tr>
					<tr>
						<td>定区编码</td>
						<td><input type="text" name="id" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>所属单位</td>
						<td><input type="text" name="station" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td>是否关联分区</td>
						<td><input type="text" name="subareaId" class="easyui-validatebox" required="true"/></td>
					</tr>
					<tr>
						<td colspan="2"><a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a> </td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<!-- 关联客户窗口 -->
	<div class="easyui-window" title="关联客户窗口" id="customerWindow" collapsible="false" closed="true" minimizable="false" maximizable="false" style="top:20px;left:200px;width: 400px;height: 300px;">
		<div style="overflow:auto;padding:5px;" border="false">
			<form id="customerForm" action="${pageContext.request.contextPath }/decidedzone_assigncustomerstodecidedzone.do" method="post">
				<table class="table-edit" width="80%" align="center">
					<tr class="title">
						<td colspan="3">关联客户</td>
					</tr>
					<tr>
						<td>
							<!-- 定区编号 -->
							<input type="hidden" name="id" id="customerDecidedZoneId" />
							<select id="noassociationSelect" multiple="multiple" size="10"></select>
						</td>
						<td>
							<input type="button" value="》》" id="toRight"><br/>
							<input type="button" value="《《" id="toLeft">
						</td>
						<td>
							<!-- 选中客户 -->
							<select id="associationSelect" name="customerIds" multiple="multiple" size="10"></select>
						</td>
					</tr>
					<tr>
						<td colspan="3"><a id="associationBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">关联客户</a> </td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>