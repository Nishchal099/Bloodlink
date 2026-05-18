package com.bloodlinkk.config; 

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {
    private static final String URL = "jdbc:mysql://localhost:3306/bloodlink_db";  // ✅ Correct URL
    private static final String USERNAME = "root";  // ✅ Valid username
    private static final String PASSWORD = "";  // ✅ Empty password (change if needed)
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // ✅ Correct driver class
            System.out.println("MySQL JDBC Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        try {
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Database connection established successfully!");
            return connection;
        } catch (SQLException e) {
            System.err.println("Failed to connect to database!");
            System.err.println("Error: " + e.getMessage());
            throw e;
        }
    }
    
    public static boolean testConnection() {  
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Connection test failed: " + e.getMessage());
            return false;
        }
    }
    
    public static void closeConnection(Connection connection) {  
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}