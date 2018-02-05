package mobileshoppe.email;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mobileshoppe.business.Cartitems;
import mobileshoppe.business.Products;
import mobileshoppe.data.CartDB;
import mobileshoppe.data.EmailUtil;


@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 String url = "/index.jsp";
		
	        System.out.println("entered cart servlet -1");
	        
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
	        else if(action.equals("cartAddProduct")) {
	        	
	        	int cartAddIdValue = Integer.parseInt(request.getParameter("cartAddIdValue"));
	        	String UserEmailValue = request.getParameter("UserEmailvalue");
	        	
	        	try {
	        		Products productForId = new Products();		
			        productForId = CartDB.getproductCartData(cartAddIdValue);
			        
			        if(productForId!=null){
			        	
			        	 Cartitems cartitems = new Cartitems();
					        cartitems.setCartProductName(productForId.getProductname());
					        cartitems.setCartProductImageurl(productForId.getProductImage());
					        cartitems.setCartProductPrice(productForId.getPrice());
					        cartitems.setUserEmail(UserEmailValue);
					        CartDB.insertcartItems(cartitems);
			        }
			        
			        
			        
			       
			      
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	             
	        	 
	        }else if(action.equals("goToCartPage")){
	        	
	        	String UserEmailValue = request.getParameter("UserEmailvalue");
	        	
	        	ArrayList<Cartitems> CartProductlist = new ArrayList<Cartitems>();
	        	HttpSession session = request.getSession();
           	 		if(session.getAttribute("CartProductlist")!=null){
           	 				session.removeAttribute("CartProductlist");
           	 			}

	        	
	        	try {
	        		
	        		System.out.println("enetrws go to cart page if");
					CartProductlist = CartDB.getCartItemsData(UserEmailValue);
					
					System.out.println("cart items list : "  +  CartProductlist.size());
				
					 session.setAttribute("CartProductlist",CartProductlist);
					
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	        	
	        	
	        	url = "/cart.jsp"; 
	        }
	        else if(action.equals("DeleteCartId")){
	        	
	        	System.out.println("enetrs deletd cart id " );
	        	
	        	
	        	
	        	try {
					CartDB.deleteCartId(request.getParameter("deletecartIdValue"));
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	url = "/cart.jsp"; 
	        }else if(action.equals("goToCheckoutPage")){
	        	
	        	System.out.println("eneterd goto checkout");
	        	String CheckoutEmailValue = request.getParameter("checkoutUserEmail");
	        	
	            System.out.println(" checkout email value " + CheckoutEmailValue);
	        	ArrayList<Cartitems> CartProductlistvalue = new ArrayList<Cartitems>();
	        	HttpSession session = request.getSession();
           	 		if(session.getAttribute("CartProductlistvalue")!=null){
           	 				session.removeAttribute("CartProductlistvalue");
           	 			}

	        	
	        	try {
	        		
	        		System.out.println("enetrws go to cart page if" + CartDB.getCartItemsData(CheckoutEmailValue).toString() );
	        		
	        		CartProductlistvalue = CartDB.getCartItemsData(CheckoutEmailValue);
					
					System.out.println("cart items list checkout : "  +  CartProductlistvalue.size());
				
					 session.setAttribute("CartProductlistvalue",CartProductlistvalue);
					
				} catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	        	
	        	
	        	url = "/Checkout.jsp"; 
	        }
	        else if (action.equals("SendEmail")){
	        	
	        	String emailid = request.getParameter("emailinfo");
	        	String addressinfo = request.getParameter("Addressinfo");
	        	EmailUtil.sendEmail(emailid,addressinfo);
	        	
	        }
	        
	        
	       getServletContext()
            .getRequestDispatcher(url)
            .forward(request, response);
	       
		
		
		
		
	}
	
	
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}


}
