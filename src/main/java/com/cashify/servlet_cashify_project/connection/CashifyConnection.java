package com.cashify.servlet_cashify_project.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import com.mysql.cj.jdbc.Driver;  

public class CashifyConnection {
    public static Connection getCashifyConnection() {
        Connection connection = null;
        try {
            Driver driver = new Driver();  
            DriverManager.registerDriver(driver);
            
            String url = "jdbc:mysql://localhost:3306/cashify";
            String username = "root";
            String password = "Samaira@2003";
            
            connection = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return connection;
    }
}
