package com.exam.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

import com.exam.dao.ExamDAO;
import com.exam.model.Exam;

@WebServlet("/admin/exam/*")
public class ExamServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ExamDAO examDAO;
    
    public void init() {
        examDAO = new ExamDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all exams
            List<Exam> exams = examDAO.getAllExams();
            request.setAttribute("exams", exams);
            request.getRequestDispatcher("/admin/exams.jsp").forward(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Get exam for editing
            int examId = Integer.parseInt(request.getParameter("id"));
            Exam exam = examDAO.getExamById(examId);
            request.setAttribute("exam", exam);
            request.getRequestDispatcher("/admin/edit-exam.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            // Create new exam
            Exam exam = new Exam(
                request.getParameter("title"),
                request.getParameter("description"),
                Integer.parseInt(request.getParameter("duration")),
                Integer.parseInt(request.getParameter("totalMarks"))
            );
            
            if (examDAO.createExam(exam)) {
                response.sendRedirect(request.getContextPath() + "/admin/exam/");
            } else {
                request.setAttribute("error", "Failed to create exam");
                request.getRequestDispatcher("/admin/exams.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            // Update existing exam
            Exam exam = new Exam();
            exam.setExamId(Integer.parseInt(request.getParameter("examId")));
            exam.setTitle(request.getParameter("title"));
            exam.setDescription(request.getParameter("description"));
            exam.setDuration(Integer.parseInt(request.getParameter("duration")));
            exam.setTotalMarks(Integer.parseInt(request.getParameter("totalMarks")));
            
            if (examDAO.updateExam(exam)) {
                response.sendRedirect(request.getContextPath() + "/admin/exam/");
            } else {
                request.setAttribute("error", "Failed to update exam");
                request.getRequestDispatcher("/admin/edit-exam.jsp").forward(request, response);
            }
        }
    }
    
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int examId = Integer.parseInt(request.getParameter("id"));
        
        if (examDAO.deleteExam(examId)) {
            response.setStatus(jakarta.servlet.http.HttpServletResponse.SC_OK);
        } else {
            response.setStatus(jakarta.servlet.http.HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Failed to delete exam");
        }
    }
}
