package com.exam.controller;

import com.exam.dao.ResultDAO;
import com.exam.model.Result;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/results/*")
public class ResultServlet extends HttpServlet {
    private ResultDAO resultDAO;

    public void init() {
        resultDAO = new ResultDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        HttpSession session = request.getSession();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Get all results for admin view
            List<Result> results = resultDAO.getAllResults();
            int totalStudents = resultDAO.getTotalStudents();
            double averageScore = resultDAO.getAverageScore();
            double passRate = resultDAO.getPassRate();
            
            request.setAttribute("results", results);
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("averageScore", String.format("%.2f", averageScore));
            request.setAttribute("passRate", String.format("%.2f", passRate));
            
            request.getRequestDispatcher("/admin/view-results.jsp").forward(request, response);
        } else if (pathInfo.equals("/student")) {
            // Get results for a specific student
            Integer studentId = (Integer) session.getAttribute("studentId");
            if (studentId != null) {
                List<Result> results = resultDAO.getStudentResults(studentId);
                request.setAttribute("results", results);
                request.getRequestDispatcher("/student/my-results.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        } else {
            // Get specific result details
            int resultId = Integer.parseInt(pathInfo.substring(1));
            Result result = resultDAO.getResult(resultId);
            if (result != null) {
                request.setAttribute("result", result);
                request.getRequestDispatcher("/admin/result-details.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            Result result = new Result();
            result.setStudentId(Integer.parseInt(request.getParameter("studentId")));
            result.setExamId(Integer.parseInt(request.getParameter("examId")));
            result.setScore(Integer.parseInt(request.getParameter("score")));
            result.setSubmissionDate(new java.sql.Timestamp(System.currentTimeMillis()));
            
            if (resultDAO.addResult(result)) {
                response.sendRedirect("view-results.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int resultId = Integer.parseInt(request.getParameter("id"));
        if (resultDAO.deleteResult(resultId)) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
