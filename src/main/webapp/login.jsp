<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Login - MyCart</title>
<%@include file="component/common_css_js.jsp"%>
</head>
<body style="background-color: #f5f5f5;">
	<%@include file="component/navbar.jsp"%>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card mt-3 custom-bg">
					<h3 class="card-header text-white">Login here</h3>

					<div class="card-body text-white">
					<%@include file="component/message.jsp" %>
						<form action="LoginServlet" method="post">
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> 
								<input
									type="email" name="email" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									placeholder="Enter email"> <small id="emailHelp"
									class="form-text text-muted"></small>
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> 
								<input
									type="password" name="password" class="form-control"
									id="exampleInputPassword1" placeholder="Password">
							</div>
							<div class="container text-center mb-3">
								<a href="register.jsp" class="text-white">If not registered.
									Click here!!!</a>
							</div>
							<div class="container text-center">
								<button type="submit" class="btn btn-primary">Submit</button>
								<button type="reset" class="btn btn-primary">Reset</button>
							</div>
						</form>
					</div>

					<div class="card-footer"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
