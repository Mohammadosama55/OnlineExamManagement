package com.exam.dao;

import com.exam.model.Question;
import com.exam.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {
    public boolean addQuestion(Question question) {
        String sql = "INSERT INTO questions (exam_id, question_text, option1, option2, option3, option4, correct_answer, marks) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, question.getExamId());
            stmt.setString(2, question.getQuestionText());
            stmt.setString(3, question.getOption1());
            stmt.setString(4, question.getOption2());
            stmt.setString(5, question.getOption3());
            stmt.setString(6, question.getOption4());
            stmt.setString(7, question.getCorrectAnswer());
            stmt.setInt(8, question.getMarks());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    question.setQuestionId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateQuestion(Question question) {
        String sql = "UPDATE questions SET question_text=?, option1=?, option2=?, option3=?, option4=?, correct_answer=?, marks=? WHERE question_id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, question.getQuestionText());
            stmt.setString(2, question.getOption1());
            stmt.setString(3, question.getOption2());
            stmt.setString(4, question.getOption3());
            stmt.setString(5, question.getOption4());
            stmt.setString(6, question.getCorrectAnswer());
            stmt.setInt(7, question.getMarks());
            stmt.setInt(8, question.getQuestionId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteQuestion(int questionId) {
        String sql = "DELETE FROM questions WHERE question_id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, questionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Question getQuestion(int questionId) {
        String sql = "SELECT * FROM questions WHERE question_id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, questionId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractQuestionFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Question> getQuestionsByExam(int examId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions WHERE exam_id=?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, examId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                questions.add(extractQuestionFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }

    private Question extractQuestionFromResultSet(ResultSet rs) throws SQLException {
        Question question = new Question();
        question.setQuestionId(rs.getInt("question_id"));
        question.setExamId(rs.getInt("exam_id"));
        question.setQuestionText(rs.getString("question_text"));
        question.setOption1(rs.getString("option1"));
        question.setOption2(rs.getString("option2"));
        question.setOption3(rs.getString("option3"));
        question.setOption4(rs.getString("option4"));
        question.setCorrectAnswer(rs.getString("correct_answer"));
        question.setMarks(rs.getInt("marks"));
        return question;
    }
}
