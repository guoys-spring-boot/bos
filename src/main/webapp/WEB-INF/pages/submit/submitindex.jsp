<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!-- 导入jquery核心类库 -->
    <jsp:include page="${pageContext.request.contextPath}/common/reference.jsp"/>
    <script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${path}/js/ueditor/ueditor.all.min.js"></script>

    <script type="text/javascript" src="${path}/js/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript">
        $(function () {
            $("body").css({visibility: "visible"});
        });
        var assessmentType = $.loadEnum('assessmentType');
        var options = {
            panelWidth: 670,
            idField: 'id',
            striped: true,
            value:'${submitContent.project.id}',
            nowrap: false,
            textField: 'projectName',
            url: '${path}/assessmentContent/listContent',
            columns: [[
                {field: 'projectName', title: '考核项目', width: 500},
                {
                    field: 'type',
                    title: '考核类型',
                    width: 150,
                    formatter: function (value, row, index) {
                        return assessmentType[value];
                    }
                }
            ]]
        };

        $(function () {
            $("#assessmentProject").combogrid(options);
            $("#save").click(function () {
                $("#submitContentForm").submit();
            });
        })
    </script>
</head>
<body class="easyui-layout" style="visibility:hidden;">
<div region="east" title="附件列表" icon="icon-forward" style="width:180px;overflow:auto;" split="false" border="true">


</div>
<div region="center" style="overflow:hidden;" border="false">
    <form id="submitContentForm" action="${path}/submitContent/addSubmitContent" method="post">
        <div region="north" style="height:41px;overflow:hidden;" split="false" border="false">
            <div class="datagrid-toolbar">
                <a id="save" icon="icon-save" href="#" class="easyui-linkbutton" plain="true" >保存</a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <label for="assessmentProject">考核项目：</label>
                <select disabled="disabled" id="assessmentProject" required="true" class="easyui-combogrid" name="project.id" style="width:400px;"></select>
            </div>
        </div>
        <div region="center" split="false" border="false">
            <textarea id="content" name="content"  disabled="${disabled}"></textarea>
            <script type="text/javascript">
                var width = $(window).width() * 0.80;
                var height = $(window).height() * 0.71;
                $("#content").val('${submitContent.content}');
                //$("#assessmentProject").val('${project.id}');
                try {
                    var ue = UE.getEditor('content', {
                        initialFrameWidth: width,
                        initialFrameHeight: height,
                        readonly:${disabled}
                    });
                } catch (error) {
                    alert(error);
                }

            </script>
        </div>
    </form>
</div>
</body>
</html>