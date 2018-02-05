package mobileshoppe.data;

import java.sql.*;
import javax.sql.DataSource;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class ConnectionPool {

    private static ConnectionPool pool = null;
    private static DataSource dataSource = null;

    private ConnectionPool() {
        try {
            InitialContext ic = new InitialContext();
            dataSource = (DataSource) ic.lookup("java:/comp/env/jdbc/database");
        } catch (NamingException e) {
            System.out.println(e);
        }
    }

    public static synchronized ConnectionPool getInstance() {
        if (pool == null) {
            pool = new ConnectionPool();
        }
        return pool;
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

    public static void freeConnection(Connection c) {
        try {
            c.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}