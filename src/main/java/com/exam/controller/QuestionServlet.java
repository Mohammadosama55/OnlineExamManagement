package com.exam.controller;

import com.exam.dao.QuestionDAO;
import com.exam.model.Question;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/question/*")
public class QuestionServlet extends HttpServlet {
    private QuestionDAO questionDAO;

    public void init() {
        questionDAO = new QuestionDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            int examId = Integer.parseInt(request.getParameter("examId"));
            List<Question> questions = questionDAO.getQuestionsByExam(examId);
            request.setAttribute("questions", questions);
            request.getRequestDispatcher("/admin/manage-questions.jsp").forward(request, response);
        } else {
            int questionId = Integer.parseInt(pathInfo.substring(1));
            Question question = questionDAO.getQuestion(questionId);
            if (question != null) {
                request.setAttribute("question", question);
                request.getRequestDispatcher("/admin/edit-question.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            Question question = new Question();
            populateQuestion(question, request);
            if (questionDAO.addQuestion(question)) {
                response.sendRedirect("manage-questions.jsp?examId=" + question.getExamId());
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else if ("update".equals(action)) {
            int questionId = Integer.parseInt(request.getParameter("questionId"));
            Question question = questionDAO.getQuestion(questionId);
            if (question != null) {
                populateQuestion(question, request);
                if (questionDAO.updateQuestion(question)) {
                    response.sendRedirect("manage-questions.jsp?examId=" + question.getExamId());
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        }
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int questionId = Integer.parseInt(request.getParameter("id"));
        if (questionDAO.deleteQuestion(questionId)) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void populateQuestion(Question question, HttpServletRequest request) {
        question.setExamId(Integer.parseInt(request.getParameter("examId")));
        question.setQuestionText(request.getParameter("questionText"));
        question.setOption1(request.getParameter("option1"));
        question.setOption2(request.getParameter("option2"));
        question.setOption3(request.getParameter("option3"));
        question.setOption4(request.getParameter("option4"));
        question.setCorrectAnswer(request.getParameter("correctAnswer"));
        question.setMarks(Integer.parseInt(request.getParameter("marks")));
    }
}
