<%
User user = (User) session.getAttribute("current_user");
if (user == null) {
	System.out.println("User is null and doesn't exists....");
	session.setAttribute("message", "You are not logged in!! Please login to access checkout page");
	response.sendRedirect("login.jsp");
	return;
}
%>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout Page</title>
<%@include file="component/common_css_js.jsp"%>
</head>
<body>
<%@include file="component/navbar.jsp"%>
<div class="container">
    <div class="row mt-5">
        <div class="col-md-6">
            <!-- Card -->
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center mb-5">Your selected items</h3>
                    <div class="cart-body">
                        <!-- Cart items content -->
                        <!-- Example content: -->
                        <p>Item 1</p>
                        <p>Item 2</p>
                        <!-- Ensure cart items are populated dynamically -->
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center mb-5">Your order details</h3>
                    <form-action="#!">
                    <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input value="<%=user.getUserEmail() %>" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email address">
  </div>
    <div class="form-group">
    <label for="exampleInputEmail1">Your name</label>
    <input value="<%= user.getUserName() %>" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter name">
</div>
<div class="form-group">
    <label for="exampleInputEmail1">Your name</label>
    <input value="<%= user.getUserPhone() %>" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter phone number">
</div>

    <div class="form-group">
    <label for="exampleFormControlTextarea1">Your shipping address</label>
    <textarea value="<%=user.getUserAddress() %>" class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="Enter your address"></textarea>
  </div>
  <div class="container text-center">
  <button class="btn btn-outline-success">Order Now</button>
   <button class="btn btn-outline-primary">Continue shopping</button>
  </div>
                    </form-action>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="component/common_modals.jsp" %>
</body>
</html>
