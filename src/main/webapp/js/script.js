alert("java script has been loaded.")

function add_to_cart(pid,pname,price){
	let cart=localStorage.getItem("cart");
		if(cart==null){
			let products=[];
			let product={productId:pid,productName:pname,productQuantity:1,productPrice:price};
		products.push(product);	
		localStorage.setItem("cart",JSON.stringify(products));	
		console.log("Product has been added for the first time.")
		showToast("Item is added to cart.")
		}else{
			//check if cart is already filled
			let pCart=JSON.parse(cart);
			let oldProduct=pCart.find((item)=>item.productId==pid)
			if(oldProduct){
				//increase quantity
				oldProduct.productQuantity=oldProduct.productQuantity+1;
				pCart.map((item)=>{
					if(item.productId=oldProduct.productId){
						item.productQuantity=oldProduct.productQuantity;
					}
				})
				localStorage.setItem("cart",JSON.stringify(pCart));
				console.log("Product quantity has been increased.")
				showToast(oldProduct.productName+" quantity is increased. Quantity = "+oldProduct.productQuantity);
			}else{
				//add the product
				let product={productId:pid,productName:pname,productQuantity:1,productPrice:price};
				pCart.push(product);
				localStorage.setItem("cart",JSON.stringify(pCart));
				console.log("Product is added.")
				showToast("Product is added to cart.")
			}
		}
		update_cart();
}	

function delete_item_from_cart(pid){
	let cart=JSON.parse(localStorage.getItem('cart'));
	
	let newCart=cart.filter((item)=>item.productId!=pid);
	
	localStorage.setItem('cart',JSON.stringify(newCart));
	
	update_cart();
	showToast("Item is added to cart.")
}
	
	
function update_cart() {
    console.log("Updating cart...");
    let cartString = localStorage.getItem("cart");
    console.log("Cart String:", cartString);

    // Parse cart data
    let cart = JSON.parse(cartString);
    console.log("Parsed Cart:", cart);

    // Check cart content
    if (cart == null || cart.length === 0) {
        console.log("Cart is empty.");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart doesn't have any items.</h3>");
        $(".checkout-btn").attr('disabled', true); // Disable checkout button
    } else {
        console.log("Cart has items:", cart);
        $(".cart-items").html(`${cart.length}`);
        // Generate and display cart table
        displayCart(cart);
        $(".checkout-btn").attr('disabled', false); // Enable checkout button
    }
}

function displayCart(cart) {
    // Generate HTML for cart table
    let table = `
        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th>Item Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
    `;
    let totalPrice = 0;

    cart.forEach((item) => {
        table += `
            <tr>
                <td>${item.productName}</td>
                <td>${item.productPrice}</td>
                <td>${item.productQuantity}</td>
                <td>${item.productQuantity * item.productPrice}</td>
                <td><button onclick="delete_item_from_cart(${item.productId})" class="btn btn-danger btn-sm">Remove</button></td>
            </tr>
        `;
        totalPrice += item.productPrice * item.productQuantity;
    });

    table += `
        </tbody>
        <tfoot>
            <tr>
                <td colspan="5" class="text-right font-weight-bold m-5">Total Price: ${totalPrice}</td>
            </tr>
        </tfoot>
        </table>
    `;

    $(".cart-body").html(table);
}



$(document).ready(function(){
	update_cart();
})

function showToast(content) {
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() => {
        $("#toast").removeClass("display");
    }, 2000);
}

/*
function goToCheckout(){
	window.location="checkout.jsp";
}
*/