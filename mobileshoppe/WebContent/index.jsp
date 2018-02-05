<!DOCTYPE html>
<html lang="en">
<head>
  <title>Login Page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="styles/login.css" type="text/css"/>
</head>
    
<body >
  
 

<div class="modal-dialog">
   <div class="loginmodal-container">
   
   <!-- Aravind reddy keesara uncc id 800976233 -->

	<h1>Welcome !!</h1>
	<h1>Login to Mobile-shoppe</h1><br>
	<p class="bg-danger"> ${message } </p>

  <form action ="EmailServlet" method = "post">
			
		    <input type="text" name="user"  placeholder=" email-id@example.com">
			<input type="password" name="pass" placeholder="Password">
			
		    <div class="btn-group btn-group-justified">
  			<div class="btn-group">
   				 <button type="submit" name="action" value="adminlogin" class="btn btn-primary">Admin Login</button>
  			</div>
  			<div class="btn-group">
   				 <button type="submit" name="action" value="userLogin" class="btn btn-primary">User Login</button>
  			</div>
 			 <div class="btn-group">
   				 <button type="submit" name="action" value="signup" class="btn btn-primary">User Signup</button>
  			</div>
			</div>
  </form>
			
    </div>
	</div>
	
</body>
</html>