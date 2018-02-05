<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <title>cart page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="styles/cart.css" type="text/css"/>
</head>
<body>

<!-- Aravind reddy keesara uncc id 800976233 -->

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">MobileShoppe</a>
    </div>
     <form action = "EmailServlet" method = "post">
    <ul class="nav navbar-nav">
        <li ><a  type="button" id="goToHomepage">Home</a></li>
       <li><a type ="button" id="goToCartPage">Cart</a></li>
      <li><a type = "button" id="goToCheckoutPage">Checkout</a></li>
      
    </ul>
    </form>
   <li><a class = "pull-right" type = "button" id="goToCheckoutPage">About Us</a></li>
  </div>
</nav>
   
 
 <div class="container">
 						 <h2> Mobiles Added to Cart </h2>     
  						<table class="table table-striped">
  	 
   						 <tbody>
  						  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    						  <c:forEach items="${CartProductlist}" var="obj">
     						  	 <tr>
       								<td>
       
      									 <div class="media">
										<a href="#" class="pull-left item">
											<img src="${obj.getCartProductImageurl()}" alt = "product image " class="media-photo">
											<input  id = "Productsimageurl" type = "hidden" value="${obj.getCartProductImageurl()}" >
											<input  id = "productCartId" type = "hidden" value="${obj.getCartId()}" >
											<input  id = "ProductUserEmail" type = "hidden" value="${obj.getUserEmail()}" >
											
											
								    	</a>
											<div class="media-body">
											<h4 class="title">Mobile Name : ${obj.getCartProductName()} </h4>
											<input  id = "ProductMobileName" type = "hidden" value="${obj.getCartProductName()}" >
											
											<br>
											
											<p  class="summary"> Price : ${obj.getCartProductPrice()} </p>
											<input  id = "ProductPrice" type = "hidden" value="${obj.getCartProductPrice()}" >
											
									</div>
									</div>
	  							 </td>
	  <td><a href="#" id = "DeleteProductCart" class="btn btn-lg btn-danger padding">Delete</a></td>
       </tr>
      </c:forEach>
      
    </tbody>
  </table>
  <input  id = "ProductUserEmail" type = "hidden" value="${CartProductlist[0].getUserEmail()}" >
</div>


</body>


<script type="text/javascript">

// to direct to home page
$(document).on('click', '#goToHomepage', function(e){ 
	  e.preventDefault();
	 
 var EmailUserValue = $('#ProductUserEmail').val();
	
	$.ajax({
		   url:"${pageContext.request.contextPath}/EmailServlet",
		   data:{ action : "home",
			      UserEmailvalue : EmailUserValue
		   },
		   
		   type: 'post'
}).done(function (data) {
	   
	   window.location.href='products.jsp';
	 
}).fail(function (error) {
	   
	  
	   console.log("return add id to cart : " + JSON.stringify(error))
	   
});
	 


});

//to direct to cart page
 
$(document).on('click', '#goToCartPage', function(e){ 
	  e.preventDefault();
	  var EmailUserValue = $('#ProductUserEmail').val();
	
	$.ajax({
		   url:"${pageContext.request.contextPath}/CartServlet",
		   data:{ action : "goToCartPage",
			      UserEmailvalue : EmailUserValue
		   },
		   
		   type: 'post'
	}).done(function (data) {
	   
	   window.location.href='cart.jsp';
	   console.log("enetered add id to cart sucees");

	}).fail(function (error) {
		   
	  
	   console.log("return add id to cart : " + JSON.stringify(error))
	   
	 });
});

// to direct to checkout page

$(document).on('click', '#goToCheckoutPage', function(e){ 
	  e.preventDefault();
	 var checkoutUserEmailvalue = $('#ProductUserEmail').val();
	
	$.ajax({
		   url:"${pageContext.request.contextPath}/CartServlet",
		   data:{ action : "goToCheckoutPage",
			      checkoutUserEmail : checkoutUserEmailvalue
		   },
		   
		   type: 'post'
 }).done(function (data) {
	   
	   window.location.href='Checkout.jsp';
	 
 }).fail(function (error) {
	   
	 window.location.href='Checkout.jsp';
	   console.log("return add id to cart : " + JSON.stringify(error))
	   
 });
	 


});

$(document).on('click', '#DeleteProductCart', function(e){ 
	 e.preventDefault();
	 
	 var currentRow=$(this).closest("tr");
	 var ProductCartId =currentRow.find("#productCartId").val();
	 
	 $.post("CartServlet",{"action":"DeleteCartId", "deletecartIdValue" : ProductCartId },function(){
			window.location.reload();
		});

});

</script>


</html>