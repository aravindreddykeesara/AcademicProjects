package mobileshoppe.data;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import mobileshoppe.business.User;

public class UserDB {
	
	/**
	 *  Aravind Reddy Keesara uncc id# 800976233
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */

    public static int insert(User user) throws ClassNotFoundException, SQLException {
    	Connection connection=null;
        PreparedStatement ps = null;
      
        String query
                = "INSERT INTO User (Email, FirstName, LastName, password, salt) "
                + "VALUES (?,?,?,?,?)";
        try {
        	connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getSalt());
            
            return ps.executeUpdate();
            
            
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            connection.close();
           
        }
    }

    public static int update(User user) throws ClassNotFoundException, SQLException {
    	Connection connection=null;
         PreparedStatement ps = null;

        String query = "UPDATE User SET "
                + "FirstName = ?, "
                + "LastName = ? "
                + "WHERE Email = ?";
        try {
        	connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
           
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            connection.close();
            
            
        }
    }

    public static int delete(User user) throws ClassNotFoundException, SQLException {
    	Connection connection=null;
         PreparedStatement ps = null;

        String query = "DELETE FROM User "
                + "WHERE Email = ?";
        try {
        	connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, user.getEmail());
          
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            connection.close();
            
           
        }
    }

    public static boolean emailExists(String email) throws ClassNotFoundException, SQLException {
    	Connection connection=null;
        PreparedStatement ps = null;
        ResultSet rs = null;
       System.out.println("enetrd email check db " );
        String query = "SELECT Email FROM User "
                + "WHERE Email = ?";
        try {
        	connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            System.out.println("enetrd email check db "  + rs.next());
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            connection.close();
          
        }
    }
    
    public static String checkpassword(String email) throws SQLException, ClassNotFoundException {
    	Connection connection=null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String passvalue = null;

        String query = "SELECT password FROM User "
                + "WHERE Email = ?";
        try {
        	connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
           while(rs.next()){
            	passvalue =   rs.getString("password");
           }
           
           System.out.println("pass value db " + passvalue);
           
          
            return passvalue;
            
        } catch (SQLException e) {
            System.out.println(e);
           
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            connection.close();
            
        }
		return null;
		
    }
    
    public static String getsaltvalue(String email) throws SQLException, ClassNotFoundException {
    	Connection connection=null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String saltvalue = null;

        String query = "SELECT salt FROM User "
                + "WHERE Email = ?";
        try {
        	connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
           while(rs.next()){
        	   saltvalue =   rs.getString("salt");
           }
           
          System.out.println("salt value db " + saltvalue);
            
          
            return saltvalue;
            
        } catch (SQLException e) {
            System.out.println(e);
           
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            connection.close();
            
        }
		return null;
		
    }

    public static User selectUser(String email) throws ClassNotFoundException, SQLException {
    	Connection connection=null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String query = "SELECT * FROM User "
                + "WHERE Email = ?";
        try {
        	connection = getConnection();
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            User user = null;
            if (rs.next()) {
                user = new User();
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("password"));
            }
           
            return user;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
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
		 
		 System.out.println(" jdbc url value " + jdbcUrl );
				  return DriverManager.getConnection(jdbcUrl);
			 
	}
  
    
    
    
    
    
}