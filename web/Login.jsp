<%-- 
    Document   : index
    Created on : Sep 29, 2024, 4:03:12 PM
    Author     : longnguyen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@page import="controllers/usercontroller.java">--%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DropzoneAZ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .box-login {
            padding: 15px;
            margin: 10% auto;
        }
        .float-right {
            float: right;
        }
        .float-left {
            float: left;
        }
        .error {
            color: red;
        }
    </style>
  </head>
  <body>
    <div class="col-md-3 border-default box-login">
        <h1 class="text-center">ログイン</h1>
        <form action="LoginController" method="POST" id="login-form">
            <input type="email" name="email" placeholder="ユーザ名" class="form-control">
            <br/>
            <input type="password" name="password" placeholder="パスワード" class="form-control">
            <br/>
            <a href="register.jsp" class="float-left">登録する</a>
            <input type="submit" value="ログイン" class="btn btn-primary float-right">
            <br/>
            <br/>
        </form>
    </div>  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.21.0/jquery.validate.min.js" integrity="sha512-KFHXdr2oObHKI9w4Hv1XPKc898mE4kgYx58oqsc/JqqdLMDI4YjOLzom+EMlW8HFUd0QfjfAvxSL6sEq/a42fQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
        $(document).ready(function () {
            /*
             * Validate form register here
             */
            $("#login-form").validate({
                onfocusout: false,
		onkeyup: false,
		onclick: false,
                rules: {
                    // handle input
                    "email": {
                        required: true,
                        maxlength: 255
                    },
                    "password": {
                        required: true,
                        maxlength: 255
                    }
                },
                messages: {
                    "email": {
                        required: "ユーザ名を入力してください。",
                        maxlength: "最大255文字"
                    },
                    "password": {
                        required: "パスワードを入力してください。",
                        maxlength: "最大255文字"
                    }
                }
            });
        });
    </script>
  </body>
</html>
