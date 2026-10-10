package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class to manage database connection using JDBC with MySQL.
 */
public class DBConnection {

    // Database credentials and configuration
    private static final String URL = "jdbc:mysql://localhost:3306/sms?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Farhan@18";

    // Static block to register MySQL JDBC Driver
    static {
        try {
            // Modern MySQL 8+ Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            try {
                // Fallback for older MySQL 5.x Driver
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException ex) {
                System.err.println("MySQL JDBC Driver not found. Please ensure the MySQL Connector JAR is placed in WEB-INF/lib.");
                ex.printStackTrace();
            }
        }
    }

    /**
     * Establishes and returns a Connection object to the MySQL database.
     * 
     * @return Connection instance
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * Helper method to safely close a database connection.
     * 
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
