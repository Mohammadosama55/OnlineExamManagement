<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Results - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">Admin Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manage-exams.jsp">Manage Exams</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manage-questions.jsp">Manage Questions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="view-results.jsp">View Results</a>
                    </li>
                </ul>
                <form action="../logout" method="post" class="d-flex">
                    <button type="submit" class="btn btn-outline-light">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">Exam Results</h2>

        <!-- Filters -->
        <div class="row mb-4">
            <div class="col-md-4">
                <select class="form-select" id="examFilter">
                    <option value="">All Exams</option>
                    <c:forEach var="exam" items="${exams}">
                        <option value="${exam.examId}">${exam.title}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-4">
                <input type="text" class="form-control" id="studentFilter" placeholder="Search by student name">
            </div>
            <div class="col-md-4">
                <button class="btn btn-primary" onclick="applyFilters()">
                    <i class="bi bi-search"></i> Search
                </button>
                <button class="btn btn-secondary" onclick="resetFilters()">
                    <i class="bi bi-arrow-counterclockwise"></i> Reset
                </button>
            </div>
        </div>

        <!-- Results Table -->
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Student Name</th>
                        <th>Exam Title</th>
                        <th>Score</th>
                        <th>Total Marks</th>
                        <th>Percentage</th>
                        <th>Submission Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="result" items="${results}">
                        <tr>
                            <td>${result.studentName}</td>
                            <td>${result.examTitle}</td>
                            <td>${result.score}</td>
                            <td>${result.totalMarks}</td>
                            <td>${result.percentage}%</td>
                            <td>${result.submissionDate}</td>
                            <td>
                                <button class="btn btn-sm btn-info" onclick="viewDetails(${result.resultId})">
                                    <i class="bi bi-eye"></i> View Details
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="deleteResult(${result.resultId})">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Statistics Cards -->
        <div class="row mt-4">
            <div class="col-md-3">
                <div class="card text-white bg-primary">
                    <div class="card-body">
                        <h5 class="card-title">Total Students</h5>
                        <p class="card-text display-6">${totalStudents}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-success">
                    <div class="card-body">
                        <h5 class="card-title">Average Score</h5>
                        <p class="card-text display-6">${averageScore}%</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-warning">
                    <div class="card-body">
                        <h5 class="card-title">Pass Rate</h5>
                        <p class="card-text display-6">${passRate}%</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-info">
                    <div class="card-body">
                        <h5 class="card-title">Total Exams</h5>
                        <p class="card-text display-6">${totalExams}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewDetails(resultId) {
            window.location.href = `result-details.jsp?id=${resultId}`;
        }

        function deleteResult(resultId) {
            if (confirm('Are you sure you want to delete this result?')) {
                fetch(`result?id=${resultId}`, {
                    method: 'DELETE'
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        alert('Failed to delete result');
                    }
                });
            }
        }

        function applyFilters() {
            const exam = document.getElementById('examFilter').value;
            const student = document.getElementById('studentFilter').value;
            window.location.href = `view-results.jsp?examId=${exam}&student=${student}`;
        }

        function resetFilters() {
            window.location.href = 'view-results.jsp';
        }
    </script>
</body>
</html>
