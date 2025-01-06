<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Exams - Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">Student Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="available-exams.jsp">Available Exams</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="my-results.jsp">My Results</a>
                    </li>
                </ul>
                <form action="../logout" method="post" class="d-flex">
                    <button type="submit" class="btn btn-outline-light">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">Available Exams</h2>

        <div class="row">
            <c:forEach var="exam" items="${availableExams}">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${exam.title}</h5>
                            <p class="card-text">${exam.description}</p>
                            <ul class="list-unstyled">
                                <li><i class="bi bi-clock"></i> Duration: ${exam.duration} minutes</li>
                                <li><i class="bi bi-award"></i> Total Marks: ${exam.totalMarks}</li>
                            </ul>
                        </div>
                        <div class="card-footer">
                            <button onclick="startExam(${exam.examId})" class="btn btn-primary w-100">
                                <i class="bi bi-play-circle"></i> Start Exam
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- No Exams Message -->
        <c:if test="${empty availableExams}">
            <div class="alert alert-info text-center">
                <i class="bi bi-info-circle"></i> No exams are currently available.
            </div>
        </c:if>
    </div>

    <!-- Start Exam Confirmation Modal -->
    <div class="modal fade" id="startExamModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Start Exam</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you ready to start the exam? Please note:</p>
                    <ul>
                        <li>The timer will start immediately</li>
                        <li>You cannot pause the exam once started</li>
                        <li>Ensure you have a stable internet connection</li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="confirmStartExam">Start Exam</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let selectedExamId = null;
        const startExamModal = new bootstrap.Modal(document.getElementById('startExamModal'));

        function startExam(examId) {
            selectedExamId = examId;
            startExamModal.show();
        }

        document.getElementById('confirmStartExam').addEventListener('click', function() {
            if (selectedExamId) {
                window.location.href = `take-exam.jsp?id=${selectedExamId}`;
            }
        });
    </script>
</body>
</html>
