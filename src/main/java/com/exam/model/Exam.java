package com.exam.model;

import java.sql.Timestamp;

public class Exam {
    private int examId;
    private String title;
    private String description;
    private int duration; // in minutes
    private int totalMarks;
    private Timestamp createdAt;

    public Exam() {}

    public Exam(String title, String description, int duration, int totalMarks) {
        this.title = title;
        this.description = description;
        this.duration = duration;
        this.totalMarks = totalMarks;
    }

    // Getters and Setters
    public int getExamId() {
        return examId;
    }

    public void setExamId(int examId) {
        this.examId = examId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public int getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(int totalMarks) {
        this.totalMarks = totalMarks;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
