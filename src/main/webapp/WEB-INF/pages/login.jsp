<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登陆页面</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/css/styleForLogin.css"/>

    <script type="text/javascript">
        function correctPNG()
        {
            for(var i=0; i<document.images.length; i++)
            {
                var img = document.images[i]
                var imgName = img.src.toUpperCase()
                if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
                {
                    var imgID = (img.id) ? "id='" + img.id + "' " : ""
                    var imgClass = (img.className) ? "class='" + img.className + "' " : ""
                    var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "
                    var imgStyle = "display:inline-block;" + img.style.cssText
                    if (img.align == "left") imgStyle = "float:left;" + imgStyle
                    if (img.align == "right") imgStyle = "float:right;" + imgStyle
                    if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle
                    var strNewHTML = "<span " + imgID + imgClass + imgTitle
                        + " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
                        + "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
                        + "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>"
                    img.outerHTML = strNewHTML
                    i = i-1
                }
            }
        }
        window.attachEvent("onload", correctPNG);

    </script>

    <script type="text/javascript">
        if (window.top != window.self) {
            alert("你还没有登录或者登录已过期");
            window.top.location = window.location;
        }


    </script>
</head>
<body>
<form id="loginform" name="loginform" method="post" class="niceform"
      action="${pageContext.request.contextPath}/login.do">
<div id="box">
    <div id="logo"><img src="${pageContext.request.contextPath}/images/logo.png" width="1000" height="100" /></div>
    <div id="block">
        <div id="userLogin"><img src="${pageContext.request.contextPath}/images/user-login.png" width="194" height="36" /></div>
        <div id="login">
            <div id="left"><img src="${pageContext.request.contextPath}/images/yaoshi.png" width="115" height="128"/></div>
            <div id="right">
                <div><p style="color:#ff1d5d">${msg}</p></div>
                <div class="field ph-hide">
                    <label for="TPL_username_1">用户名：</label>
                    <input type="text" name="username" id="TPL_username_1" class="login-text J_UserName" value="" maxlength="32" tabindex="1"/>
                </div>
                <div class="field">
                    <label id="password-label">密　码：</label>
                    <input type="password" name="password" id="TPL_username_2" class="login-text J_UserName" value="" maxlength="32" tabindex="1"/>
                </div>
            </div>
        </div>
        <div id="bottom"> <button type="submit" class="J_Submit" tabindex="5">登&nbsp;录</button></div>
    </div>
    <div id="floor">恩施市文明办&nbsp;&nbsp;&nbsp;&nbsp;宣<br/>
        建设用谷歌浏览器&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
</form>
</body>
</html>