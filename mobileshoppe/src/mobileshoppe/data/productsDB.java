package mobileshoppe.data;

import java.sql.*;
import java.util.ArrayList;

import mobileshoppe.business.Products;

public class productsDB {
	
	/**
	 *  Aravind Reddy Keesara uncc id# 800976233
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	
	
	 public static int insert(Products products) throws ClassNotFoundException, SQLException {
		 Connection connection=null;
	        PreparedStatement ps = null;
	      
	        String query
	                = "INSERT INTO products (productImage, productname, productquantity , productPrice) "
	                + "VALUES (?, ?, ?, ?)";
	        try {
	        	connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setString(1, products.getProductImage());
	            ps.setString(2, products.getProductname());
	            ps.setInt(3, products.getQuantity());
	            ps.setString(4, products.getPrice());
	           
	            return ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println(e);
	            return 0;
	        } finally {
	            DBUtil.closePreparedStatement(ps);
	            connection.close();
	           
	        }
	    }
	 
	 // get all products present in the database
	 public static ArrayList<Products> getproductsData() throws ClassNotFoundException, SQLException {
		 Connection connection=null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
            ArrayList<Products> productslist =new ArrayList<Products>();
	        String query = "SELECT * FROM products";
	        try {
	        	connection = getConnection();
	            ps = connection.prepareStatement(query);
	            rs = ps.executeQuery();
	            Products products =null;
	            while(rs.next()) {
	            	
	            	
	            	
	            	products = new Products(rs.getString("productImage"),rs.getInt("productid"), rs.getString("productname"),rs.getInt("productquantity"),rs.getString("productPrice"));
	
	                productslist.add(products);
	            	
	            }
	           
	            return productslist;
	        } catch (SQLException e) {
	            System.out.println(e);
	            return null;
	        } finally {
	            DBUtil.closeResultSet(rs);
	            DBUtil.closePreparedStatement(ps);
	            connection.close();
	            
	        }
	    }
	 
	 public static int delete(String productid) throws ClassNotFoundException, SQLException {
		 Connection connection=null;
	        PreparedStatement ps = null;
	      
	        String query
	                = "delete from products where productid = ? ";
	        try {
	        	connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setString(1, productid);
	           
	            return ps.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println(e);
	            return 0;
	        } finally {
	            DBUtil.closePreparedStatement(ps);
	            connection.close();
	        }
	    }
	 
	
	 
	 public static int update(Products products) throws ClassNotFoundException, SQLException {
		 Connection connection=null;
	        PreparedStatement ps = null;
	      
	        String query
	                = " UPDATE products SET productname = ?, productquantity = ? ,ProductPrice = ?  WHERE productid = ? ;";
	        try {
	        	connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setString(1, products.getProductname());
	            ps.setInt(2, products.getQuantity());
	            ps.setString(3, products.getPrice());
	            ps.setInt(4, products.getProductid());
	           
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
