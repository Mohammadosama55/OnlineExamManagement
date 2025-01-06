package com.exam.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.exam.dao.AdminDAO;
import com.exam.dao.StudentDAO;
import com.exam.model.Admin;
import com.exam.model.Student;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;
    private StudentDAO studentDAO;
    
    public void init() {
        adminDAO = new AdminDAO();
        studentDAO = new StudentDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userType = request.getParameter("userType");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        HttpSession session = request.getSession();
        
        try {
            if ("admin".equals(userType)) {
                Admin admin = adminDAO.validateLogin(username, password);
                if (admin != null) {
                    session.setAttribute("admin", admin);
                    response.sendRedirect("admin/dashboard.jsp");
                    return;
                }
            } else if ("student".equals(userType)) {
                Student student = studentDAO.validateLogin(username, password);
                if (student != null) {
                    session.setAttribute("student", student);
                    response.sendRedirect("student/dashboard.jsp");
                    return;
                }
            }
            
            request.setAttribute("error", "Invalid credentials. Please try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
