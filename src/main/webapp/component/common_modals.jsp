<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page Title</title>
    <!-- Include your script file here -->
    <!-- Additional meta tags, CSS files, or other includes -->
   <%--   <%@include file="common_css_js.jsp"%>  --%> 
</head>
<body>
<script type="text/javascript">
function goToCheckout(){
	window.location="checkout.jsp";
}
</script>

   <%-- <%@include file="navbar.jsp"%>   --%> 
    <h1>This is an eCommerce application...</h1>
    
    <!-- Your modal content and other HTML structure -->
    <!-- Modal -->
    <div class="modal fade" id="cart" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Your cart</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="cart-body">
                        <!-- Cart content goes here -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <!-- Call goToCheckout function on button click -->
                    <button type="button" class="btn btn-primary checkout-btn" id="checkout-btn" onclick="goToCheckout()">Checkout</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast div for showing messages -->
    <div id="toast">This is our custom toast text</div>

    <!-- Additional content and script calls -->
    <!-- This is where you can call update_cart function or other content -->

    <!-- Ensure script.js is loaded and executed -->
    <script>
        $(document).ready(function() {
            // You can also call functions after document is fully loaded
            update_cart();
        });
    </script>
</body>
</html>
