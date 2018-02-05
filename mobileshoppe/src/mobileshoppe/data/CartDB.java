package mobileshoppe.data;

import java.sql.*;
import java.util.ArrayList;

import mobileshoppe.business.Cartitems;
import mobileshoppe.business.Products;

public class CartDB {
	
	// get product data for the user id value
	 public static Products getproductCartData(int idvalue) throws ClassNotFoundException, SQLException {
		   Connection connection=null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
           
	        String query = "SELECT * FROM products Where productid = ? ";
	        try {
	        	connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setInt(1,idvalue);
	            rs = ps.executeQuery();
	            Products products =null;
	            while(rs.next()) {
	            	
	            	
	            	
	            	products = new Products(rs.getString("productImage"),rs.getInt("productid"), rs.getString("productname"),rs.getInt("productquantity"),rs.getString("productPrice"));
	
	                //productslist.add(products);
	            	
	            }
	           
	            return products;
	        } catch (SQLException e) {
	            System.out.println(e);
	            return null;
	        } finally {
	        	connection.close();
	            DBUtil.closeResultSet(rs);
	            DBUtil.closePreparedStatement(ps);
	            
	        }
	    }
	 
	 // insert cart items for the specific user
	 public static int insertcartItems(Cartitems cartitems) throws ClassNotFoundException, SQLException {
		    Connection connection=null;
	        PreparedStatement ps = null;
	      
	        String query
	                = "INSERT INTO cart(ProductName, ProductImageurl, ProductPrice , UserEmail ) "
	                + "VALUES (?, ?, ? ,?)";
	        try {
	        	connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setString(1, cartitems.getCartProductName());
	            ps.setString(2, cartitems.getCartProductImageurl());
	            ps.setString(3, cartitems.getCartProductPrice());
	            ps.setString(4, cartitems.getUserEmail());
	        
	            return ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println(e);
	            return 0;
	        } finally {
	        	connection.close();
	            DBUtil.closePreparedStatement(ps);
	           
	        }
	    }
	 
	 // get cart items list for the specific user
	 public static ArrayList<Cartitems> getCartItemsData(String UserEmailValue) throws ClassNotFoundException, SQLException {
		 Connection connection=null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
            ArrayList<Cartitems> cartitemslist =new ArrayList<Cartitems>();
	        String query = "SELECT * FROM cart where UserEmail = ? ";
	        try {
	        	connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setString(1,UserEmailValue );
	            rs = ps.executeQuery();
	            Cartitems cartiitems =null;
	            while(rs.next()) {
	            	
	        	cartiitems = new Cartitems(rs.getString("ProductName"), rs.getString("ProductImageurl"),rs.getString("ProductPrice"),rs.getInt("cartId"),rs.getString("UserEmail"));
	
	            	cartitemslist.add(cartiitems);
	            	
	            }
	           
	            return cartitemslist;
	        } catch (SQLException e) {
	            System.out.println(e);
	            return null;
	        } finally {
	        	connection.close();
	            DBUtil.closeResultSet(rs);
	            DBUtil.closePreparedStatement(ps);
	            
	        }
	    }
	 
	 // delete the items in the cart
	 public static int deleteCartId(String CartIdvalue) throws ClassNotFoundException, SQLException {
		 Connection connection=null;
	        PreparedStatement ps = null;
	      
	        String query
	                = "delete from cart where cartId = ? ";
	        try {
	        	connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setString(1, CartIdvalue);
	           
	            return ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println(e);
	            return 0;
	        } finally {
	            DBUtil.closePreparedStatement(ps);
	            connection.close();
	        }
	    }
	 
	 public static Connection getConnection() throws ClassNotFoundException,SQLException 
		{
			 Class.forName("com.mysql.jdbc.Driver");
			 String dbName = "mobileshoppe";
			 String userName = "root";
			 String password = "qwertyuiop";
			 String hostname = "mobileshoppe.cu0gluvdtelj.us-east-2.rds.amazonaws.com";
			 String port = "3306";
			 String jdbcUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName +
					 "?user=" + userName + "&password=" + password;
			 
			 
					  return DriverManager.getConnection(jdbcUrl);
				 
		}

	 
	
	 
	 
	 
	 
	
	

}
