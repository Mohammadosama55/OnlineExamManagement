package com.exam.model;

import java.sql.Timestamp;

public class Result {
    private int resultId;
    private int studentId;
    private int examId;
    private int score;
    private Timestamp submissionDate;
    private String studentName;
    private String examTitle;
    private int totalMarks;

    public Result() {}

    public Result(int resultId, int studentId, int examId, int score, Timestamp submissionDate) {
        this.resultId = resultId;
        this.studentId = studentId;
        this.examId = examId;
        this.score = score;
        this.submissionDate = submissionDate;
    }

    // Getters and Setters
    public int getResultId() {
        return resultId;
    }

    public void setResultId(int resultId) {
        this.resultId = resultId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getExamId() {
        return examId;
    }

    public void setExamId(int examId) {
        this.examId = examId;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Timestamp getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(Timestamp submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getExamTitle() {
        return examTitle;
    }

    public void setExamTitle(String examTitle) {
        this.examTitle = examTitle;
    }

    public int getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(int totalMarks) {
        this.totalMarks = totalMarks;
    }

    public double getPercentage() {
        return totalMarks > 0 ? ((double) score / totalMarks) * 100 : 0;
    }
}
