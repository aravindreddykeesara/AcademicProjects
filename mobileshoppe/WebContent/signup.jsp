<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>signup page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="styles/signup.css" type="text/css"/>
</head>
    
<body>

<!-- Aravind reddy keesara uncc id 800976233 -->

<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="panel panel-primary">
                <div class="panel-heading">Thank you for creating an account in my site !!</div>
                <div class="panel-body">
                    <form role="form" method="post" action="EmailServlet" accept-charset="UTF-8">
                    
                        <p><i>${message}</i></p>
                    
                        <label for="fname">First Name</label>
                        <input type="text" id="fname" class="form-control" name="fname"  required placeholder="Example: qwerty">
                        
                        <label for="lname">Last Name</label>
                        <input type="text" id="lname" class="form-control" name="lname"  required placeholder="Example: uiop">
                         <label for="emailaddr" class="m-t-10">Email Address</label>
                        <input type="text" id="emailaddr" class="form-control" name="email"  required placeholder="Example: qwerty.uiop@example.com">
                        
                        <label for="password" class="m-t-10">Password</label>
                        <input type="password" id="password" class="form-control" name="password"  required placeholder="">
                        
                        <label for="verifypass" class="m-t-10">Verify Password</label>
                        <input type="password" id="confirmpass" class="form-control" name="verifypass" placeholder="">
                        
                        <center><button class="btn btn-info" type="submit" name="action" value="add">signup</button></center>
                        
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>





</body>
</html>