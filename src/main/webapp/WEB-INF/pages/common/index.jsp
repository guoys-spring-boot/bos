<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>恩施市文明单位创建动态管理系统</title>
    <!-- 导入jquery核心类库 -->
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
    <!-- 导入easyui类库 -->
    <link id="easyuiTheme" rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/js/easyui/themes/bootstrap/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/css/default.css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
    <!-- 导入ztree类库 -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"
          type="text/css"/>
    <script
            src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"
            type="text/javascript"></script>
    <script
            src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"
            type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/platform/common.js"></script>

    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath }/fontAwessome/css/fontawesome-all.min.css">

    <style type="text/css">
        @font-face {
            src: url("font/title.TTF");
            font-family: "NPIMandana"
        }
    </style>

    <script type="text/javascript">
        if (window.top != window) {
            top.location.href = window.location.href;
        }

        function buildZtree(row, rows) {
            var result = [];
            var condition = [];
            condition.push(row.id);
            for(var i = 0; i<rows.length; i++){
                if(condition.indexOf(rows[i]._parentId) != -1){

                    if(rows[i].iconSkin){
                        rows[i].innerName = rows[i].name
                        rows[i].name = "<i class='"+rows[i].iconSkin+"'></i> " + rows[i].name
                    }

                    result.push(rows[i]);
                    condition.push(rows[i].id);
                }
            }
            return result;
        }

        // 初始化ztree菜单
        $(function () {

            function addPanel(row, rows){
                $('#leftMenu').accordion('add',{
                    title : row.name,
                    content:'<ul id="treeMenu-'+row.id+'" class="ztree"></ul>',
                    iconCls: row.iconSkin
                    //selected: false
                });

                $.fn.zTree.init($("#treeMenu-"+row.id), setting, buildZtree(row, rows));
            }

            var setting = {
                data: {
                    simpleData: { // 简单数据
                        enable: true,
                        pIdKey: "_parentId"
                    }
                },
                callback: {
                    onClick: onClick
                },
                view: {
                    showTitle: false,
                    showIcon: false,
                    nameIsHTML:true
                }
            };

            // 基本功能菜单加载
            $.ajax({
                url: '${pageContext.request.contextPath}/function_menu.do',
                type: 'GET',
                dataType: 'text',
                success: function (data) {
                    var zNodes = eval("(" + data + ")");
                    if (zNodes && zNodes.rows) {
                        for(var i = 0; i<zNodes.rows.length; i++){
                            var singleRow = zNodes.rows[i];
                            if(!singleRow._parentId){
                                addPanel(singleRow, zNodes.rows);
                            }
                        }
                        //$.fn.zTree.init($("#treeMenu"), setting, zNodes.rows);
                    }

                },
                error: function (msg) {
                    alert('菜单加载异常!');
                }
            });


            // 页面加载后 右下角 弹出窗口
            /**************/

            $.post('${path}/notice/findAll').done(function (data) {
                var div = $("<div style='line-height: 30px'/>");
                var max = data.length < 3 ? data.length : 3;
                for(var i=0; i<max; i++){
                    var row = data[i];
                    div.append("<a href='#' onclick='_download(\""+row.attachment.id+"\")'>"+row.name+"</a>").append('<br/>');
                }
                var str = div.html();
                $.messager.show({
                    title: "欢迎登录，${user.unitShortName}",
                    msg: str,
                    timeout: 0
                });
            });




            /*************/

            $("#btnCancel").click(function () {
                $('#editPwdWindow').window('close');
            });

            // 点击修改密码窗口 确定按钮，执行点击事件按钮
            $("#btnEp").click(function () {
                var txtNewPass = $('#txtNewPass').val().trim();
                var txtRePass = $('#txtRePass').val().trim();

                if (txtNewPass == "") {
                    $.messager.alert('警告', '密码不能为空！', 'warning');
                    return;
                }

                if (txtNewPass != txtRePass) {
                    $.messager.alert('警告', '两次密码输入不一致！', 'warning');
                    return;
                }

                // 使用 ajax发起请求，将新密码提交到服务器 完成修改
                $.post("${pageContext.request.contextPath}/business/updatePassword", {password: txtNewPass}, function (data) {
                    if (data.success) {
                        // 成功
                        $.messager.alert('信息', data.msg, 'info');
                    } else {
                        // 失败
                        $.messager.alert('错误', data.msg, 'error');
                    }
                    $('#editPwdWindow').window('close');
                });
            });
            var homePage = '${(empty sessionScope.user.role) ? '' :  sessionScope.user.role.homePage}';
            if (homePage != '') {
                var content = '<div style="width:100%;height:100%;overflow:hidden;">'
                    + '<iframe src="'
                    + homePage
                    + '" scrolling="auto" style="width:100%;height:100%;border:0;" ></iframe></div>';

                $('#tabs').tabs('add', {
                    title: "${sessionScope.user.role.homePageTitle}",
                    content: content,
                    closable: true
                });
            }
        });

        function onClick(event, treeId, treeNode, clickFlag) {
            // 判断树菜单节点是否含有 page属性
            //alert(treeNode.name)
            if (treeNode.page != undefined && treeNode.page != "") {
                if ($("#tabs").tabs('exists', treeNode.name)) {// 判断tab是否存在
                    $('#tabs').tabs('select', treeNode.name); // 切换tab
                } else {

                    $(window)._openTab('tabs', treeNode.page, treeNode.innerName || treeNode.name, '', {
                        iconCls: treeNode.iconSkin
                    });

                }
            }
        }


        /*******顶部特效 *******/
        /**
         * 更换EasyUI主题的方法
         * @param themeName
         * 主题名称
         */
        changeTheme = function (themeName) {
            var $easyuiTheme = $('#easyuiTheme');
            var url = $easyuiTheme.attr('href');
            var href = url.substring(0, url.indexOf('themes')) + 'themes/'
                + themeName + '/easyui.css';
            $easyuiTheme.attr('href', href);
            var $iframe = $('iframe');
            if ($iframe.length > 0) {
                for (var i = 0; i < $iframe.length; i++) {
                    var ifr = $iframe[i];
                    innerChangeTheme(themeName, $(ifr));
                }
            }
        };

        function innerChangeTheme(themeName, $iframe) {
            var $easyuiTheme = $iframe.contents().find('#easyuiTheme');
            var url = $easyuiTheme.attr('href');

            if (url) {
                var href = url.substring(0, url.indexOf('themes')) + 'themes/'
                    + themeName + '/easyui.css';
                $easyuiTheme.attr('href', href);
            }

            var $iframes = $iframe.contents().find('iframe');

            if ($iframes.length > 0) {
                for (var i = 0; i < $iframes.length; i++) {
                    innerChangeTheme(themeName, $($iframes[i]));
                }
            }

        }
        // 退出登录
        function logoutFun() {
            $.messager
                .confirm('系统提示', '您确定要退出本次登录吗?', function (isConfirm) {
                    if (isConfirm) {
                        location.href = '${pageContext.request.contextPath }/logout.do';
                    }
                });
        }
        // 修改密码
        function editPassword() {
            $('#editPwdWindow').window('open');
        }
        // 版权信息
        function showAbout() {
            $.messager.alert("恩施文明办 v1.0", "设计: xxx<br/> 管理员邮箱: gys@xxx.cn <br/> QQ: xxxxxx");
        }

        function _download(id) {
            var url = '${path}/submitContent/downloadAttachment?id=' + id;
            location.href = url;
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'north',border:false"
     style="height:60px;padding:10px;width:100%;background:url('${pageContext.request.contextPath }/images/topbg.jpg') no-repeat right ;background-size: cover">
    <div data-option="region: 'north', border: false" style="width: 100%">
        <div style="height: 100%">

            <p style="font-size: 35px;height: 100%; font-family: NPIMandana; vertical-align: middle;color: white">
                </p>
        </div>

        <div style="position: absolute; right: 5px; top: 10px; ">
            <a href="javascript:void(0);" class="easyui-menubutton"
               data-options="menu:'#layout_north_pfMenu',iconCls:'icon-ok'">更换皮肤</a>
            <a href="javascript:void(0);" class="easyui-menubutton"
               data-options="menu:'#layout_north_kzmbMenu',iconCls:'icon-help'">控制面板</a>
        </div>

        <div id="layout_north_pfMenu" style="width: 120px; display: none;">
            <div onclick="changeTheme('default');">default</div>
            <div onclick="changeTheme('gray');">gray</div>
            <div onclick="changeTheme('black');">black</div>
            <div onclick="changeTheme('bootstrap');">bootstrap</div>
            <div onclick="changeTheme('metro');">metro</div>
        </div>
        <div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
            <div onclick="editPassword();">修改密码</div>
            <div onclick="showAbout();">联系管理员</div>
            <div class="menu-sep"></div>
            <div onclick="logoutFun();">退出系统</div>
        </div>
    </div>

</div>

<div data-options="region:'west',split:true,title:'菜单导航',iconCls:'fas fa-bars'"
     style="width:20%">
    <div id="leftMenu" class="easyui-accordion" fit="true" border="false">


    </div>
</div>
<div data-options="region:'center'">
    <div id="tabs" fit="true" class="easyui-tabs" border="false">
        <div title="个人信息" id="subWarp"
             style="width:100%;height:100%;overflow:hidden" data-options="iconCls:'fas fa-user'">

            <iframe src="${path}/business/toUpdateUnit?unitId=${sessionScope.user.id}&from=index"
                    style="width: 95%; height: 95%" frameborder="0"></iframe>
        </div>
    </div>
</div>
<div data-options="region:'south',border:false"
     style="height:30px;padding:10px;background:url('${pageContext.request.contextPath }/images/bg12.jpg') no-repeat right;text-align: right">
    <p style="color: black">你好: ${sessionScope.user.unitShortName}, 当前年度： ${sessionScope.year}</p>
</div>

<!--修改密码窗口-->
<div id="editPwdWindow" class="easyui-window" title="修改密码" collapsible="false" minimizable="false" modal="true"
     closed="true" resizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 160px; padding: 5px;
        background: #fafafa">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <table cellpadding=3>
                <tr>
                    <td>新密码：</td>
                    <td><input id="txtNewPass" type="Password" class="txt01"/></td>
                </tr>
                <tr>
                    <td>确认密码：</td>
                    <td><input id="txtRePass" type="Password" class="txt01"/></td>
                </tr>
            </table>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)">确定</a>
            <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
        </div>
    </div>
</div>
</body>
</html>