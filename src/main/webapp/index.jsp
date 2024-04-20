<%@page import="org.hibernate.SessionFactory"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="myCart.learn.helper.FactoryProviderHelper"%>
<%@page import="myCart.learn.dao.ProductDao"%>
<%@page import="myCart.learn.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="myCart.user.Entity.Product"%>
<%@page import="myCart.user.Entity.Category"%>
<%@page import="myCart.learn.helper.Helper"%>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Our E-Commerce Store</title>

<%@include file="component/common_css_js.jsp"%>

<style>
    /* CSS for the background image */
    body {
        background-image: url('https://source.unsplash.com/1280x720/?ecommerce'); /* Background image from Unsplash */
        background-size: cover; /* Cover the entire background */
        background-repeat: no-repeat; /* Prevent image from repeating */
        background-attachment: fixed; /* Fixed background */
        color: #ffffff; /* Text color */
        font-family: Arial, sans-serif; /* Font family */
        margin: 0; /* Remove default margin */
        padding: 0; /* Remove default padding */
    }

    /* Container for content */
    .container {
        max-width: 1200px; /* Max width of content */
        margin: 0 auto; /* Center content horizontally */
        padding: 20px; /* Add padding */
        text-align: center; /* Center text */
    }

    /* Heading styles */
    h1 {
        font-size: 36px; /* Large font size */
        margin-bottom: 20px; /* Add bottom margin */
    }

    /* Button styles */
    .btn {
        display: inline-block; /* Display as inline-block */
        padding: 10px 20px; /* Add padding */
        background-color: #ff6600; /* Button background color */
        color: #ffffff; /* Button text color */
        text-decoration: none; /* Remove underline */
        border: none; /* Remove border */
        border-radius: 5px; /* Add border radius */
        cursor: pointer; /* Add cursor pointer */
        transition: background-color 0.3s; /* Add transition */
    }

    .btn:hover {
        background-color: #e65c00; /* Darker background color on hover */
    }

    /* Product card styles */
    .product-card {
        background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background */
        padding: 20px; /* Add padding */
        border-radius: 10px; /* Add border radius */
        margin-bottom: 20px; /* Add bottom margin */
    }

    /* Product name styles */
    .card-title {
        font-size: 24px; /* Large font size */
        margin-bottom: 10px; /* Add bottom margin */
    }

    /* Product description styles */
    .card-text {
        font-size: 16px; /* Medium font size */
        margin-bottom: 10px; /* Add bottom margin */
    }
    
    

</style>

</head>
<body>
	<%@include file="component/navbar.jsp"%>
	<%
	try {
		// Attempt to get the SessionFactory
		SessionFactory sessionFactory = FactoryProviderHelper.getSessionFactory();

		// Print SessionFactory reference value
		/*
		out.println("SessionFactory created successfully! Reference 1: " + sessionFactory+"<br>");
		out.println("SessionFactory created successfully! Reference 2: " + sessionFactory+"<br>");
		out.println("SessionFactory created successfully! Reference 3: " + sessionFactory+"<br>");
		*/
	} catch (Exception e) {
		// Handle any exceptions (print stack trace or log)
		out.println("Error creating SessionFactory: " + e.getMessage());

		// Use a PrintWriter to wrap the JspWriter
		PrintWriter writer = new PrintWriter(out);
		e.printStackTrace(writer);
	}
	%>
	<div class="container-fluid">
		<div class="row mt-3 mx-2">
			<!-- SHOW CATEGORIES -->
			<%
		String cat=request.getParameter("category");
		
		ProductDao productDao = new ProductDao(FactoryProviderHelper.getSessionFactory());
		List<Product> list=null;
		if(cat==null ||cat.trim().equals("all")){
		list = productDao.getAllProducts();
	} else {
		int cId=Integer.parseInt(cat.trim());
		list=productDao.getAllProductsById(cId);
	}
		CategoryDao cdao = new CategoryDao(FactoryProviderHelper.getSessionFactory());
		List<Category> cList = cdao.getCategories();
		%>
			<div class="col-md-2">
				<div class="list-group mt-4">
					<a href="index.jsp?category=all"
						class="list-group-item list-group-item-action active"> All
						Products </a>
					<%-- Category Titles --%>
					<%
				for (Category category : cList) {
				%>
					<a href="index.jsp?category=<%=category.getCategoryId() %>"
						class="list-group-item list-group-item-action"> <%=category.getCategoryTitle()%>
					</a>
					<%-- End Category Titles --%>
					<%
				}
				%>
				</div>
			</div>

			<!-- SHOW PRODUCTS -->
			<div class="col-md-10">

				<!-- row -->
				<div class="row mt-4">

					<!-- column -->
					<div class="col-md-12">

						<div class="card-columns">

							<%
						for (Product p : list) {
						%>
							<div class="card product-card">

								<div class="container text-center">
									<!-- <img alt="" src="/img/products/<%=p.getProductPhoto() %>>" class="card-img-top m-2" style="max-height:200px;max-width:100%;width:auto;"> -->

									<img alt=""
										src="/ECommerce/image/products/<%=p.getProductPhoto()%>"
										class="card-img-top m-2"
										style="max-height: 200px; max-width: 100%; width: auto;">

								</div>
								<div class="card-body">
									<h5 class="card-title"><%=p.getProductName()%></h5>

									<p class="card-text">
										<%=Helper.get10Words(p.getProductDesc())%>
									</p>

								</div>

								<div class="card-footer text-center">
									<button class="btn custom-bg text-white"
										onclick="add_to_cart(<%=p.getProductId()%>,'<%=p.getProductName()%>',<%=p.getPriceAfterApplyingDiscount()%>)">Add
										to Cart</button>


									<button class="btn btn-outline-success">
										&#8377;
										<%=p.getPriceAfterApplyingDiscount()%>/-<span
											class="text-secondary discount-label"> &#8377; <%=p.getPriceAfterApplyingDiscount()%>
											% off
										</span>
									</button>

								</div>
							</div>

							<%
							}
							if (list.size() == 0) {
							out.println("<h3>No item in this category</h3>");
							}
							%>

						</div>

					</div>

				</div>

			</div>
		</div>
	</div>
	<%@include file="component/common_modals.jsp"%>

</body>
</html>
