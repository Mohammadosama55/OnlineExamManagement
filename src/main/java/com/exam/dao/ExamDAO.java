package com.exam.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.exam.model.Exam;
import com.exam.util.DatabaseConnection;

public class ExamDAO {
    
    public boolean createExam(Exam exam) {
        String sql = "INSERT INTO exams (title, description, duration, total_marks) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, exam.getTitle());
            pstmt.setString(2, exam.getDescription());
            pstmt.setInt(3, exam.getDuration());
            pstmt.setInt(4, exam.getTotalMarks());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    exam.setExamId(generatedKeys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateExam(Exam exam) {
        String sql = "UPDATE exams SET title = ?, description = ?, duration = ?, total_marks = ? WHERE exam_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, exam.getTitle());
            pstmt.setString(2, exam.getDescription());
            pstmt.setInt(3, exam.getDuration());
            pstmt.setInt(4, exam.getTotalMarks());
            pstmt.setInt(5, exam.getExamId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteExam(int examId) {
        String sql = "DELETE FROM exams WHERE exam_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, examId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Exam getExamById(int examId) {
        String sql = "SELECT * FROM exams WHERE exam_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, examId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractExamFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Exam> getAllExams() {
        List<Exam> exams = new ArrayList<>();
        String sql = "SELECT * FROM exams ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                exams.add(extractExamFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exams;
    }
    
    private Exam extractExamFromResultSet(ResultSet rs) throws SQLException {
        Exam exam = new Exam();
        exam.setExamId(rs.getInt("exam_id"));
        exam.setTitle(rs.getString("title"));
        exam.setDescription(rs.getString("description"));
        exam.setDuration(rs.getInt("duration"));
        exam.setTotalMarks(rs.getInt("total_marks"));
        exam.setCreatedAt(rs.getTimestamp("created_at"));
        return exam;
    }
}
