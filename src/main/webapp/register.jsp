 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>New User</title>
    <%@include file="component/common_css_js.jsp" %>

    <style>
        .card-body {
            background-color: #f5f5f5;
            border-radius: 10px;
            padding: 20px;
            margin-top: 50px;
        }

        .form-group label {
            color: #000000;
        }

        .form-group input,
        .form-group textarea {
            background-color: #ffffff;
            border: 1px solid #cccccc;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .container.text-center {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<%@include file="component/navbar.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body px-5">
                    <%@include file="component/message.jsp"%>
                    
                    <h3 class="text-center my-3">Sign up here</h3>
                    <form action="RegisterServlet" method="post">
                        <div class="form-group">
                            <label for="name">User Name</label>
                            <input name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter here">
                        </div>

                        <div class="form-group">
                            <label for="email">User Email</label>
                            <input name="user_email" type="text" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email">
                        </div>

                        <div class="form-group">
                            <label for="password">User Password</label>
                            <input name="user_password"  type="password" class="form-control" id="password" aria-describedby="emailHelp" placeholder="Enter password">
                        </div>

                        <div class="form-group">
                            <label for="phone">User Phone</label>
                            <input name="user_phone"  type="number" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter Phone Number">
                        </div>

                        <div class="form-group">
                            <label for="phone">User Address</label>
                            <textarea name="user_address"  style="height:200px" class="form-control" placeholder="Enter your Address"></textarea>
                        </div>
                        
                        <div class="container text-center">
                            <button class="btn btn-outline-success">Register</button>
                            <button class="btn btn-outline-warning">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>