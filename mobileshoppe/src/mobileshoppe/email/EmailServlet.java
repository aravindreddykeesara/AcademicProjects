package mobileshoppe.email;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mobileshoppe.business.User;
import mobileshoppe.business.Products;
import mobileshoppe.data.AdminDB;
import mobileshoppe.data.PasswordUtil;
import mobileshoppe.data.UserDB;
import mobileshoppe.data.productsDB;

/**
 *  Aravind Reddy Keesara uncc id# 800976233
 */
@WebServlet("/EmailServlet")
public class EmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  String url = "/index.jsp";
	        
	        System.out.println("entered here-1");
	        
	        // get current action
	        String action = request.getParameter("action");
	        System.out.print("actionvalue "+action);
	        if (action == null) {
	            action = "join";  // default action
	        }

	        // perform action and set URL to appropriate page
	        if (action.equals("join")) {
	            url = "/index.jsp";    // the "join" page
	        } 
	        else if(action.equals("signup")) {
	        	 url = "/signup.jsp"; 
	        }
	        else if(action.equals("add")) {
	        	  System.out.println("entered here-signup");
	        	  // get parameters from the request
	              String firstName = request.getParameter("fname");
	              String lastName = request.getParameter("lname");
	              String email = request.getParameter("email");
	              String password = request.getParameter("password");
	              
	              System.out.println(firstName);
	              
	             
	              // store data in User object
	           

	              // validate the parameters
	              String message = null;
	              try {
					if (UserDB.emailExists(email)) {
					      message = "This email address already exists.<br>" +
					                "Please enter another email address.";
					      url = "/signup.jsp";
					  }
					  else {
					      message = "";
					      PasswordUtil putil=new PasswordUtil();
					      String salt=putil.getSalt();
					     String newPass= putil.hashAndSaltPassword(password, salt);
						System.out.println(newPass);
						User user = new User(email,firstName, lastName,newPass,salt);
					      url = "/index.jsp";
					      UserDB.insert(user);
					      request.setAttribute("user", user);
			              request.setAttribute("message", message);
					  }
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	              catch (NoSuchAlgorithmException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

	              
	        }
	        else if(action.equals("userLogin")) {
	        	  System.out.println("entered here-3");
	        	  String email = request.getParameter("user");
	              String password = request.getParameter("pass");
	              
          
	              String message;
	              try {
	            	  System.out.println("email value enetred " + email);
	            	      boolean value = UserDB.emailExists(email);
	            	   int i =1;   
					if (i==1) {
						 PasswordUtil putil=new PasswordUtil();
						 System.out.println("enetred here util ");
					      String salt=UserDB.getsaltvalue(email);
					     String newPass= putil.hashAndSaltPassword(password, salt);
					     System.out.println("pass value enetrd" + password);
					     System.out.println("salt value fetched" + salt);
					     System.out.println("pass value serv " + newPass);
         
						  try {
							if(newPass.equals(UserDB.checkpassword(email))){
								  
								
								  System.out.println("enetred pass check");
								 
								 // session.setAttribute("userloginStatus","loggedin");
								  
								  ArrayList<Products> productslist = new ArrayList<Products>();
						             productslist = productsDB.getproductsData();
						             
						             System.out.println("productsobject = " + productslist);
						             request.setAttribute("productlist", productslist);
						             request.setAttribute("UserEmail", email);
								  url = "/products.jsp";
								  
							  }
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					  }
					  else {
						  message = " Please check ur credentials ";
						  url = "/index.jsp";
						  request.setAttribute("message", message);
					  }
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (NoSuchAlgorithmException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} 
	              
	         
               // admin login
	        } else if(action.equals("adminlogin")){
	        	 System.out.println("entered here-admin login");
	        	 
	        	// if admin is already logged in, load the products list
	        	 String email = request.getParameter("user");
	              String password = request.getParameter("pass");
	              HttpSession session = request.getSession(); 
	              if(session.getAttribute("adminLoginStatus")!=null){
	            	  
	            	  if(session.getAttribute("adminLoginStatus").equals("loggedin")){
	            		  ArrayList<Products> productslist = new ArrayList<Products>();
	            		  
				             try {
								productslist = productsDB.getproductsData();
							} catch (ClassNotFoundException | SQLException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
				             
				             System.out.println("productsobject = " + productslist);
				             request.setAttribute("productlist", productslist);
						 
						  url = "/admin.jsp";
	            		  
	            		  
	            	  }
	            	  
	              }
	            	  else{
	            		  
	             String message;  
	            	  
	              try {
	            	  // check the credentials of the admin
					if (AdminDB.emailExists(email)) {
					   
						  try {
							if(password.equals(AdminDB.checkpassword(email))){
								  
								  System.out.println("enetred pass check");
								  session.setAttribute("adminLoginStatus","loggedin");
								  ArrayList<Products> productslist = new ArrayList<Products>();
						             productslist = productsDB.getproductsData();
						             
						             System.out.println("productsobject = " + productslist);
						             request.setAttribute("productlist", productslist);
								 
								  url = "/admin.jsp";
								  
							  }
						} catch (SQLException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (ClassNotFoundException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					  }
					  else {
						  System.out.println("enetred pass fail");
						  
						  message = " Please check ur credentials ";
						  url = "/index.jsp";
						  request.setAttribute("message", message);
						  
					  }
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            	  }
	        }else if (action.equals("addproduct")) {
	         // add product into database by admin
	        	 System.out.println("entered here-add product");
	        	 
	        	 String productImage = request.getParameter("productImage");
	             String productname = request.getParameter("productname");
	             int quantity = Integer.parseInt(request.getParameter("quantity"));
	             String productprice = request.getParameter("productprice");
	        	 
	             Products products = new Products();
	             products.setProductImage(productImage);
	             products.setProductname(productname);
	             products.setQuantity(quantity);
	             products.setPrice(productprice);
	             
	             System.out.println( " product image before saving " + request.getParameter("productImage") );
	             
	             try {
					productsDB.insert(products);
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	             ArrayList<Products> productslist = new ArrayList<Products>();
	             try {
					productslist = productsDB.getproductsData();
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	             
	             System.out.println("productsobject = " + productslist);
	             request.setAttribute("productlist", productslist);
	             url = "/admin.jsp";
	             
	             
	        	 
	        }else if (action.equals("deleteProduct")) {
	        	// delete product in database by admin
	        	System.out.println("enetrd delete product");
	        	
	             String deleteidValue = request.getParameter("deleteidValue");
	             
					try {
						productsDB.delete(deleteidValue);
					} catch (ClassNotFoundException | SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			
		        	System.out.println("enetrd delete id value " + deleteidValue);
		        
	        	
	        	url = "/admin.jsp";
	       	
	        }else if (action.equals("editProduct")) {
	        	// edit product in database by admin
	        	System.out.println("enetrd edit product");
	        	
	             int editidValue = Integer.parseInt(request.getParameter("editidValue"));
	             String editproductName = request.getParameter("editproductName");
	             int editproductQuantity = Integer.parseInt(request.getParameter("editproductQuantity"));
	             String editproductPrice = request.getParameter("editproductPrice");
	             
	             Products editproducts = new Products();
	             editproducts.setProductid(editidValue);
	             editproducts.setProductname(editproductName);
	             editproducts.setQuantity(editproductQuantity);
	             editproducts.setPrice(editproductPrice);
	             
	             try {
					productsDB.update(editproducts);
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	        	url = "/admin.jsp";
	       	
	        }else if (action.equals("adminhome")) {
	        	
	        	url = "/index.jsp";
	       	
	        }
	        else if(action.equals("home")) {
	        	// if user press home, redirect him/her to home page with list of products
	        	
	        	String userEmailvalueforProducts = request.getParameter("UserEmailvalue");
	        	
	        	ArrayList<Products> productslist = new ArrayList<Products>();
	             try {
					productslist = productsDB.getproductsData();
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	             
	             HttpSession session = request.getSession(); 
	             session.setAttribute("productlist",productslist);
	             session.setAttribute("UserEmail", userEmailvalueforProducts);
	             
	             System.out.println("productsobject = " + productslist);
	             request.setAttribute("productlist", productslist);
	             request.setAttribute("UserEmail", userEmailvalueforProducts);
			      url = "/products.jsp";
	        }
	        getServletContext()
            .getRequestDispatcher(url)
            .forward(request, response);
		
		
	}


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost( req,  resp);
        
	}
	
	

}
