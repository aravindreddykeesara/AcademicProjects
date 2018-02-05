<!DOCTYPE html>
<html>
<head>
  <title>Admin Page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
  <link rel="stylesheet" href="styles/admin.css" type="text/css"/>
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
        <li ><button class="btn btn-danger navbar-btn"" type="submit" name = "action" value = "adminhome">Logout</button></li>
        </ul>
    </form>
  </div>
</nav>

<div class="panel panel-primary align">

      <div class="panel-heading ">Hi Admin !!</div>
      
      <div class="panel-body ">Are u ready to add products for customers?</div>
      
      <form action = "EmailServlet" method = "post" class="well form-inline ">
  <input type="text" class="input-small" name = "productImage" placeholder="product image">
  <input type="text" class="input-small" name = "productname" placeholder="mobile-name">
  <input type="number" class="input-small" placeholder="quantity" name="quantity" min="1" max="10">
  <input type="text" class="input-small" name = "productprice" placeholder="product price">
  
  <button type="submit" name="action" value="addproduct" class="btn btn-primary">Add product</button>
</form>   
    </div>
    
    <div class="container">
  <h2>products available in inventory</h2>     
  <table class="table table-striped">
    <thead>
      <tr>
        <th>product Image</th>
        <th>product-Name</th>
        <th>Quantity</th>
        <th> Price </th>
      </tr>
    </thead>
    <tbody>
    <!-- loop to populate the products fetched from database through servlet -->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <c:forEach items="${productlist}" var="obj">
        <tr>
       <td>
			<div class="item">
				<a href="#" class="pull-left item">
				<img src="${obj.getProductImage()}" alt = "product image " class="media-photo">
				<input  id = "imageurl" type = "hidden" value="${obj.getProductImage()}" >
				<input  id = "ProductId" type = "hidden" value="${obj.getProductid()}" >
				</a>
			</div>
		</td>
         
      
       <td>${obj.getProductname()}
       <input  id = "ProductName" type = "hidden" value="${obj.getProductname()}" >
       </td>
       <td>${obj.getQuantity()}
         <input  id = "ProductQuantity" type = "hidden" value="${obj.getQuantity()}" >
       </td>
       <td>${obj.getPrice()}
         <input  id = "ProductPrice" type = "hidden" value="${obj.getPrice()}" >
       </td>
       <td><a href="#" id = "edit-button" class="btn btn-lg btn-success padding" data-toggle="modal" data-target="#editModal">edit</a></td>
	  <td><a href="#" id = "delete-button" class="btn btn-lg btn-danger padding" data-toggle="modal" data-target="#deletemodal">Delete</a></td>
       </tr>
     </c:forEach>
      
    </tbody>
  </table>
</div>
	<!--  modal for edit  button popup -->
  	
  		<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModal" aria-hidden="true">
          <div class="modal-dialog">
          <div class="modal-content">
          <div class="modal-header">
       		     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
       			 <h4 class="modal-title align" id="myModalLabel">Edit product details</h4>
    	 </div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
                 <div class="form-group">
                   <img src="" id="editimageurlPopup" class="img-responsive center-block"  alt="product image">
                 </div>
                 <div class="form-group">
                    <label>Product Name</label>
                    <input type="text" name="EditProductNamePopup" id="EditProductNamePopup" tabindex="1" class="form-control" placeholder= "" value="">
                    <input  id = "editProductId" type = "hidden" value="" >
               
                </div>
                <div class="form-group">
                    <label>Product Quantity </label>
                    <input type="number" id = "editProductQuantity" class="input-small" placeholder="quantity" name="quantity" min="1" max="10" value = "">
              
                </div>
                <div class="form-group">
                    <label>Product price</label>
                    <input type="text" name="EditProductPricePopup" id="EditProductPricePopup" tabindex="1" class="form-control" placeholder= "" value="">
               
                </div>
                </div>
        <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "changeProduct" class="btn btn-primary">Update Product</button>
        </div>
    </form>
    </div>
    </div>
	</div>
<!--  modal for delete button popup -->
	
	<div class="modal fade" id="deletemodal" tabindex="-1" role="dialog" aria-labelledby="deletemodal" aria-hidden="true">
          <div class="modal-dialog">
          <div class="modal-content">
          <div class="modal-header">
       		     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
       			 <h4 class="modal-title align" id="mydeleteModalLabel">Delete selected Product</h4>
    	</div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
                 <div class="form-group">
                    <img src="" id="deleteImageurlPopup" class="img-responsive center-block"  alt="Cinque Terre">
                </div>
                <div class="form-group">
                    <label>Product Name</label>
                    <div class="well well-sm"><span id="DeleteProductPopup"  class="form-control"></span ></div>
                    <input  id = "deleteProductId" type = "hidden" value="" >
                </div>
                
          <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "deleteProduct" class="btn btn-primary">delete Discount</button>
        </div>
        </div>
    </form>			
	</div>
	</div>
	</div>
</body>

<script type="text/javascript">


$(document).on('click', '#edit-button', function(){ 
	
	 var currentRow=$(this).closest("tr");
	 var coleditimageurl =currentRow.find("#imageurl").val();
	 var coleditProductName = currentRow.find("#ProductName").val();
	 var coleditProductId = currentRow.find("#ProductId").val();
	 var coleditProductQuantity = currentRow.find("#ProductQuantity").val();
	 var coleditProductPrice = currentRow.find("#ProductPrice").val();
	 
	 
   
    document.getElementById("EditProductNamePopup").value = coleditProductName;
    document.getElementById("editProductQuantity").value = coleditProductQuantity;
    document.getElementById("editProductId").value = coleditProductId;
    document.getElementById("editimageurlPopup").src = coleditimageurl;
    document.getElementById("EditProductPricePopup").value = coleditProductPrice;
  
    console.log("id value to be edited = " + coleditProductId );
 
	 }); 


//update selected product in products list	
$('#changeProduct').click(function(e){
	
	e.preventDefault();
	 
	 console.log("entered here product delete");
		
		var editidValue = $('#editProductId').val();
		var EditProductNamePopup = $('#EditProductNamePopup').val();
		var editProductQuantity = $('#editProductQuantity').val();
		var EditProductPricePopup = $('#EditProductPricePopup').val();
		$.ajax({
		   url:"${pageContext.request.contextPath}/EmailServlet",
		   data:{ action : "editProduct",
			      editidValue : editidValue,
			      editproductName : EditProductNamePopup,
			      editproductQuantity : editProductQuantity,
			      editproductPrice :EditProductPricePopup
			
		   },
		   
		   type: 'post'
  }).done(function (data) {
	  console.log("enetered delete sucees");
  }).fail(function (error) {
	   console.log("return error : " + JSON.stringify(error))
	   
  });

});





$(document).on('click', '#delete-button', function(){ 
	
	 var currentRow=$(this).closest("tr");
	 var colimageurl =currentRow.find("#imageurl").val();
	 var colIdValue = currentRow.find("#ProductId").val();
	 var colProductName = currentRow.find("#ProductName").val();
	 
	 
  
  
   $("#DeleteProductPopup").text(colProductName);
   document.getElementById("deleteImageurlPopup").src = colimageurl; 
   document.getElementById("deleteProductId").value = colIdValue;
  
	 }); 
	 
	
//deleted selected product from products list	 


$('#deleteProduct').click(function(e){
	
	e.preventDefault();
	 
	 console.log("entered here product delete");
		
		var idValue = $('#deleteProductId').val();
		$.ajax({
		   url:"${pageContext.request.contextPath}/EmailServlet",
		   data:{ action : "deleteProduct", deleteidValue : idValue },
		   type: 'post'
  }).done(function (data) {
	  console.log("entered delete success");
	 
  }).fail(function (error) {
	 console.log("return error : " + JSON.stringify(error))
	   
  });

});






</script>
</html>