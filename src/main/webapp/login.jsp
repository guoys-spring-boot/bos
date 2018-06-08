<%--
  Created by IntelliJ IDEA.
  User: gys
  Date: 2018/5/19
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, width=device-width">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <title>login</title>
    <style>
        html, body {
            margin: 0px;
            padding: 0px;
        }

        body {
            background: url(images/login.jpg) no-repeat center center fixed;
            background-size: 100% 100%;
            z-index: -1000;
        }

        tr td {
            width: 300px;
        }

        @font-face {
            src: url("font/title.TTF");
            font-family: "NPIMandana"
        }

        .title {
            font-family: "NPIMandana";
            font-size: 55.32px;
            color: #fff;
            -webkit-text-fill-color: white;
            -webkit-text-stroke: 2px #2c76ad;
            margin: 0 auto;
            text-align: center;
            white-space: nowrap;
            margin-top: 100px;
        }

        .usered {
            border-collapse: collapse;
            margin-left: 720px;
            margin-top: 50px;
        }

        #img {
            position: absolute;
            /*position:relative;*/
            left: 266px;
            top: -30px;
            z-index: -100;
        }

        .user {
            color: #00a608;
            font-size: 22px;
        }

        .userSec {
            color: #898989;
            width: 300px;
            height: 38px;
            margin-top: 15px;
            font-size: 20px
        }

        a {
            position: relative;
            bottom: 33px;
            left: 244px;
            color: #c1cbba;
            font-size: 12px;
            cursor: pointer;
        }

        .meSec {
            color: #496b35;
            font-size: 15.6px
        }

        .loginin {
            background: #ef6c34;
            border: 0px;
            width: 100px;
            height: 40px;
            margin-left: 13px;
            border-radius: 5px;
            color: #fff;
            font-size: 22px
        }
    </style>

    <script type="text/javascript">
        if (window.top != window.self) {
            alert("你还没有登录或者登录已过期");
            window.top.location = window.location;
        }

        if('${msg}'){
            alert('${msg}');
        }

    </script>
</head>
<body>
<div id="ad">
    <h2 class="title">恩施市文明单位创建动态管理系统</h2>
    <div class="content">
        <div style="text-align: center; display: table-cell;vertical-align: middle;z-index:-100; position: absolute; width: 100%;">
            <img style="margin-top: -200px" src="images/lg.png"/></div>


        <div>
            <form id="loginForm" action="${pageContext.request.contextPath}/login.do">
                <div class="container" style="width: 450px; padding-left: 150px; padding-top: 30px">
                    <div class="row">
                        <div class="col">
                            <input id="username" class="userSec form-control" type="text" name="username" placeholder="用户名"
                                   onclick="if(this.value=='用户名'){this.value='';} this.style.color='#141f29'">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <input id="password" class="userSec form-control" type="password" name="password" placeholder="密码"
                                   onclick="if(this.value=='用户名'){this.value='';} this.style.color='#141f29'">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <select name="year" id="year" class="userSec form-control">
                                <option value="2018">2018</option>
                                <option value="2017">2017</option>
                            </select>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col">
                            <input id="checkcode" style="width: 150px" class="userSec form-control" type="text"
                                   name="checkcode" placeholder="验证码">
                        </div>
                        <div class="col">
                            <img id="loginform:vCode"
                                 style="margin-top: 16px"
                                 src="${pageContext.request.contextPath }/validatecode.jsp"
                                 onclick="javascript:document.getElementById('loginform:vCode').src='${pageContext.request.contextPath }/validatecode.jsp?'+Math.random();"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <button class="btn btn-lg btn-primary btn-block" style="margin-top: 15px; width: 300px"
                                    type="button"  onclick="javascript: document.getElementById('loginForm').submit()">登&nbsp;&nbsp;&nbsp;陆
                            </button>
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>
<script>
    function fnLogin() {
        var oUname = document.getElementById("uname");
        var oUpass = document.getElementById("upass");
        var isError = true;
        if (oUname.value == null || oUname.value == "") {
            alert("请输入用户名和密码！");
            return false;
        } else if (oUpass.value == null || oUpass.value == "") {
            alert("密码不能为空");
            return false;
        } else {
            alert("登录成功");

        }
    }
</script>
</body>
</html>
