<%@page import="myCart.learn.helper.FactoryProviderHelper"%>
<%@page import="myCart.user.Entity.User"%>
<%@ page import="myCart.learn.dao.CategoryDao"%>
<%@page import="myCart.user.Entity.Category"%>
<%@ page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="myCart.learn.helper.Helper"%>

<%
User user = (User) session.getAttribute("current_user");
if (user == null) {
	System.out.println("User is null and doesn't exists....");
	session.setAttribute("message", "You are not logged in!! Please login");
	response.sendRedirect("login.jsp");
	return;
} else {
	System.out.println("User is not null and exists....");
	System.out.println("User Type : " + user.getUserType());
	if (user.getUserType().equals("normal_User")) {
		session.setAttribute("message", "You are not the admin!!");
		response.sendRedirect("login.jsp");
		return;
	}
}
%>

<%
CategoryDao cDao = new CategoryDao(FactoryProviderHelper.getSessionFactory());
List<Category> list = cDao.getCategories();

//getting count for user & products
Map<String,Long> map=Helper.getCounts(FactoryProviderHelper.getSessionFactory());
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Panel</title>
<%@include file="component/common_css_js.jsp"%>
</head>
<body>
	<%@include file="component/navbar.jsp"%>

	<div class="container admin">

		<div class="container-fluid">
			<%@include file="component/message.jsp"%>
		</div>

		<div class="row mt-3">
			<div class="col-md-4">

				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" alt="user_img"
								src="image/users.png" style="max-width: 100px;">
						</div>
					<h1><%=map.get("userCount") %></h1>
						<h1 class="text-uppercase text-muted">Users</h1>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" alt="user_img"
								src="image/list.png" style="max-width: 100px;">
						</div>
						<h1><%=list.size() %></h1>
						<h1 class="text-uppercase text-muted">Categories</h1>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" alt="user_img"
								src="image/package.png" style="max-width: 100px;">
						</div>
						<h1><%=map.get("productCount") %></h1>
						<h1 class="text-uppercase text-muted">Products</h1>
					</div>
				</div>
			</div>

		</div>

		<div class="row mt-3">
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-category-modal">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" alt="user_img"
								src="image/keys.png" style="max-width: 100px;">
						</div>
						<p class="mt-2">Click here to add new Category</p>
						<h1 class="text-uppercase text-muted">Add Category</h1>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-product-modal">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" alt="user_img"
								src="image/plus.png" style="max-width: 100px;">
						</div>
						<p class="mt-2">Click here to add new Products</p>
						<h1 class="text-uppercase text-muted">Add Products</h1>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill Category
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="ProductionOperationServlet" method="post">
						<input type="hidden" name="operation" value="addCategory">
						<div class="form-group">
							<input type="text" class="form-control" name="catTitle"
								placeholder="Enter category title" required />
						</div>
						<div>
							<div class="form-group">
								<textarea style="height: 350px" class="form-control"
									name="catDescription" placeholder="Enter category description"
									required></textarea>
							</div>
							<div class="container text-center">
								<button class="btn btn-outline-success">Add Category</button>
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill Product
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="ProductionOperationServlet" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="operation" value="addproduct">
						<div class="form-group">
							<label for="productName">Product Name:</label> <input type="text"
								class="form-control" id="productName" name="productName"
								placeholder="Enter product name" required />
						</div>
						<div class="form-group">
							<label for="productDescription">Product Description:</label>
							<textarea style="height: 150px" class="form-control"
								id="productDescription" name="productDescription"
								placeholder="Enter product description" required></textarea>
						</div>
						<div class="form-group">
							<label for="productPhoto">Product Photo:</label> <input
								type="file" class="form-control-file" id="productPhoto"
								name="productPhoto" accept="image/*" required />
						</div>
						<div class="form-group">
							<label for="productPrice">Product Price:</label> <input
								type="number" class="form-control" id="productPrice"
								name="productPrice" placeholder="Enter product price" required />
						</div>
						<div class="form-group">
							<label for="productDiscount">Product Discount (%):</label> <input
								type="number" class="form-control" id="productDiscount"
								name="productDiscount" placeholder="Enter product discount"
								required />
						</div>
						<div class="form-group">
							<label for="productQuantity">Product Quantity:</label> <input
								type="number" class="form-control" id="productQuantity"
								name="productQuantity" placeholder="Enter product quantity"
								required />
						</div>



						<div class="form-group">
							<select name="catId" class="form-control" id="catId">
								<%
								for (Category c : list) {
								%>
								<option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Product</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<%@include file="component/common_modals.jsp"%>

</body>
</html>