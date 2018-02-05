package mobileshoppe.data;

import java.sql.*;

public class AdminDB {
	
	
	// check if email already exists in database
	 public static boolean emailExists(String email) throws ClassNotFoundException, SQLException {
		 Connection connection=null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;

	        String query = "SELECT email FROM Admin "
	                + "WHERE email = ?";
	        try {
	        	 connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setString(1, email);
	            rs = ps.executeQuery();
	            
	            return rs.next();
	            
	            
	        } catch (SQLException e) {
	            System.out.println(e);
	            
	        } finally {
	        	connection.close();
	            DBUtil.closeResultSet(rs);
	            DBUtil.closePreparedStatement(ps);
	            
	           
	        }
	        return false;
	    }
	 
	 //check the password value
	 public static String checkpassword(String email) throws SQLException, ClassNotFoundException {
		 Connection connection=null;

	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        String passvalue = null;

	        String query = "SELECT password FROM Admin "
	                + "WHERE email = ?";
	        try {
	        	 connection = getConnection();
	            ps = connection.prepareStatement(query);
	            ps.setString(1, email);
	            rs = ps.executeQuery();
	           while(rs.next()){
	            	passvalue =   rs.getString("password");
	           }
	           
	            return passvalue;
	            
	        } catch (SQLException e) {
	            System.out.println(e);
	           
	        } finally {
	        	connection.close();
	            DBUtil.closeResultSet(rs);
	            DBUtil.closePreparedStatement(ps);
	           
	        }
			return null;
			
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
