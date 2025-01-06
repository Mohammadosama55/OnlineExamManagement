package com.exam.dao;

import java.sql.*;
import com.exam.model.Admin;
import com.exam.util.DatabaseConnection;

public class AdminDAO {
    
    public Admin validateLogin(String username, String password) {
        String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                return admin;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
