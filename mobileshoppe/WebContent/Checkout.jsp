<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <title>checkout page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="styles/checkout.css" type="text/css"/>
</head>
<body>

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
 						 <h2> Confirm Order </h2>     
  						<table class="table table-striped">
  						 <thead>
    						  <tr>
       						 <th>Mobile Name</th>
      						  <th>Price</th>
     						
    						  </tr>
  						  </thead>
  	 
   						 <tbody>
  						  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    						  <c:forEach items="${CartProductlistvalue}" var="obj">
     						  	 <tr>
       								<td>
       							
									<h4 class="title"> ${obj.getCartProductName()} </h4>
									<input  id = "ProductMobileName" type = "hidden" value="${obj.getCartProductName()}" >
								
	  							 </td>
	  							 <td>
	  							 ${obj.getCartProductPrice()} 
								<input  id = "ProductPrice" type = "hidden" value="${obj.getCartProductPrice()}" >
	  							 </td>
       </tr>
      </c:forEach>
      
    </tbody>
  </table>
</div>
		<div class="container">
  			<h2> Please enter your details To place the Order</h2>
  			<form class="form-horizontal">
  					  <div class="form-group">
     				 	<label class="col-sm-2 control-label">Address</label>
      					  <div class="col-sm-10">
       						 <input class="form-control" id="AddressInfo" type="text" placeholder= " enter Address" value="">
    		 			 </div>
  			  		 </div>
  			  		 <div class="form-group">
     				    <label class="col-sm-2 control-label">Email</label>
      					<div class="col-sm-10">
      				    <input class="form-control" id="EmailInfo" type="text" placeholder = "Enter Email Id " value="${CartProductlistvalue[0].getUserEmail()}">
    		 		 </div>
    		 		 
    		 		 <br>
    		 		 
    		 		 <div class="wrapper">
   					    <button type="button"  id="PlaceOrderConfirm" class="btn btn-success">Place Order</button>
   					 <br>
   					 
					 </div>
    		 		 <div >
   					    <span id = "successinfo" class="text-success" value =""></span>
   					 </div>
    		 		</div>
             </form>
			</div>
            <input  id = "ProductUserEmail" type = "hidden" value="${CartProductlistvalue[0].getUserEmail()}" >
</body>

<script>

$(document).on('click', '#PlaceOrderConfirm', function(e){ 
	  e.preventDefault();
	 console.log("enetrerede orderconfirm ");
	 var emailInfo = $('#EmailInfo').val();
	 var AddressValue = $('#AddressInfo').val();
	 
	 console.log(" email value " + emailInfo);
	 
	 $.post("CartServlet",{"action":"SendEmail", "emailinfo" : emailInfo ,"Addressinfo" : AddressValue },function(){
		 
		 console.log("enetrd here after email");
		 var span = document.getElementById("successinfo");
		 span.textContent = "confirmation mail sent succesfully";
	 
	 
});
	 
});


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
	   
	  
	   console.log("return add id to cart : " + JSON.stringify(error))
	   
});
	 


});



</script>

</html>