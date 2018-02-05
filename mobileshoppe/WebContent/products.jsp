<!DOCTYPE html>
<html lang="en">
<head>
  <title>home page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="styles/products.css" type="text/css"/>
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
      <li><a type="button" id="goToCartPage">Cart</a></li>
      <li><a type="button" id="goToCheckoutPage">Checkout</a></li>
     
     
    </ul>
     </form>
    <li><a class = "pull-right" type = "button" id="goToCheckoutPage">About Us</a></li>
  </div>
</nav>


    		   <div class="container">
 						 <h2>products </h2>     
  						<table class="table table-striped">
  	      <!-- loop to populate the products fetched from database through servlet -->
   						 <tbody>
  						  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    						  <c:forEach items="${productlist}" var="obj">
     						  	 <tr>
       								<td>
       
      									 <div class="media ">
										<a href="#" class="pull-left item">
											<img src="${obj.getProductImage()}" alt = "product image " class="media-photo">
											<input  id = "Productsimageurl" type = "hidden" value="${obj.getProductImage()}" >
											<input  id = "ProductsIdValue" type = "hidden" value="${obj.getProductid()}" >
								    	</a>
											<div class="media-body">
											<h4 class="title">Mobile Name : ${obj.getProductname()} </h4>
											<input  id = "ProductMobileName" type = "hidden" value="${obj.getProductname()}" >
											
											<br>
											
											<p  class="summary">Offer Price : ${obj.getPrice()} </p>
											<input  id = "ProductPrice" type = "hidden" value="${obj.getPrice()}" >
											<p  class="summary">Quantity Available : ${obj.getQuantity()} </p>
											<input  id = "ProductPrice" type = "hidden" value="${obj.getQuantity()}" >
									</div>
									</div>
		
           			 	<div class="media-footer">
             		   <span class="pull-right buttons">
                		    <button id="ProductsBuyButton" class="btn btn-sm btn-primary"> Buy</button>
              		  </span>
        		    </div>
     	
	   </td>
       </tr>
      </c:forEach>
      
    </tbody>
  </table>
</div>

</body>

<script>



// add selected product to cart database
$(document).on('click', '#ProductsBuyButton', function(e){ 
	
	 var currentRow=$(this).closest("tr");
	 var addIdTocart =currentRow.find("#ProductsIdValue").val();
	 var EmailUserValue = "${UserEmail}";
	 
    e.preventDefault();
	 
	 console.log("entered here buy");
		
		
		$.ajax({
		   url:"${pageContext.request.contextPath}/CartServlet",
		   data:{ action : "cartAddProduct",
			      cartAddIdValue : addIdTocart ,
			      UserEmailvalue : EmailUserValue
		   },
		   
		   type: 'post'
  }).done(function (data) {
	   
	   console.log("enetered add id to cart sucees");
	 
  }).fail(function (error) {
	   
	  
	   console.log("return add id to cart : " + JSON.stringify(error))
	   
  });

});

// code to go to cart page

$(document).on('click', '#goToCartPage', function(e){ 
	  e.preventDefault();
	  var EmailUserValue = "${UserEmail}";
	
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

$(document).on('click', '#goToHomepage', function(e){ 
	  e.preventDefault();
	
  gotoHoomepage();

});


function gotoHoomepage(){
	
	  var EmailUserValue = "${UserEmail}";
		
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
		 

}


//code to go to checkout page
$(document).on('click', '#goToCheckoutPage', function(e){ 
	  e.preventDefault();
	  var EmailUserValue = "${UserEmail}";
	
	$.ajax({
		   url:"${pageContext.request.contextPath}/CartServlet",
		   data:{ action : "goToCheckoutPage",
			      checkoutUserEmail : EmailUserValue
		   },
		   
		   type: 'post'
  }).done(function (data) {
	   
	   window.location.href='Checkout.jsp';
	 
  }).fail(function (error) {
	   
	  
	   console.log("return add id to cart : " + JSON.stringify(error))
	   
  });
	 


});


</script>


</html>