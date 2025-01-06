package com.exam.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Statement;
import java.util.stream.Collectors;

public class DatabaseInitializer {
    
    public static void initializeDatabase() {
        try {
            // Read SQL file from resources
            InputStream inputStream = DatabaseInitializer.class.getResourceAsStream("/database/schema.sql");
            String sql = new BufferedReader(new InputStreamReader(inputStream))
                            .lines().collect(Collectors.joining("\n"));

            // Split SQL statements
            String[] statements = sql.split(";");

            // Execute each statement
            try (Connection conn = DatabaseConnection.getConnection();
                 Statement stmt = conn.createStatement()) {
                
                for (String statement : statements) {
                    if (!statement.trim().isEmpty()) {
                        stmt.execute(statement);
                    }
                }
                System.out.println("Database initialized successfully");
            }
        } catch (Exception e) {
            System.err.println("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
