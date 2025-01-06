package com.exam.dao;

import com.exam.model.Result;
import com.exam.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResultDAO {
    public boolean addResult(Result result) {
        String sql = "INSERT INTO results (student_id, exam_id, score, submission_date) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, result.getStudentId());
            stmt.setInt(2, result.getExamId());
            stmt.setInt(3, result.getScore());
            stmt.setTimestamp(4, result.getSubmissionDate());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    result.setResultId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteResult(int resultId) {
        String sql = "DELETE FROM results WHERE result_id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, resultId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Result getResult(int resultId) {
        String sql = "SELECT r.*, s.name as student_name, e.title as exam_title, e.total_marks " +
                    "FROM results r " +
                    "JOIN students s ON r.student_id = s.student_id " +
                    "JOIN exams e ON r.exam_id = e.exam_id " +
                    "WHERE r.result_id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, resultId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractResultFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Result> getAllResults() {
        List<Result> results = new ArrayList<>();
        String sql = "SELECT r.*, s.name as student_name, e.title as exam_title, e.total_marks " +
                    "FROM results r " +
                    "JOIN students s ON r.student_id = s.student_id " +
                    "JOIN exams e ON r.exam_id = e.exam_id " +
                    "ORDER BY r.submission_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                results.add(extractResultFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }

    public List<Result> getStudentResults(int studentId) {
        List<Result> results = new ArrayList<>();
        String sql = "SELECT r.*, s.name as student_name, e.title as exam_title, e.total_marks " +
                    "FROM results r " +
                    "JOIN students s ON r.student_id = s.student_id " +
                    "JOIN exams e ON r.exam_id = e.exam_id " +
                    "WHERE r.student_id=? " +
                    "ORDER BY r.submission_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                results.add(extractResultFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }

    private Result extractResultFromResultSet(ResultSet rs) throws SQLException {
        Result result = new Result();
        result.setResultId(rs.getInt("result_id"));
        result.setStudentId(rs.getInt("student_id"));
        result.setExamId(rs.getInt("exam_id"));
        result.setScore(rs.getInt("score"));
        result.setSubmissionDate(rs.getTimestamp("submission_date"));
        result.setStudentName(rs.getString("student_name"));
        result.setExamTitle(rs.getString("exam_title"));
        result.setTotalMarks(rs.getInt("total_marks"));
        return result;
    }

    public int getTotalStudents() {
        String sql = "SELECT COUNT(DISTINCT student_id) as total FROM results";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getAverageScore() {
        String sql = "SELECT AVG((r.score * 100.0) / e.total_marks) as avg_score " +
                    "FROM results r " +
                    "JOIN exams e ON r.exam_id = e.exam_id";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getDouble("avg_score");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public double getPassRate() {
        String sql = "SELECT (COUNT(CASE WHEN (r.score * 100.0) / e.total_marks >= 60 THEN 1 END) * 100.0 / COUNT(*)) as pass_rate " +
                    "FROM results r " +
                    "JOIN exams e ON r.exam_id = e.exam_id";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getDouble("pass_rate");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }
}
