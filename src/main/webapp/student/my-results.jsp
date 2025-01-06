<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Results - Student</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .progress {
            height: 20px;
        }
        .certificate-btn {
            transition: transform 0.2s;
        }
        .certificate-btn:hover {
            transform: scale(1.05);
        }
    </style>
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
                        <a class="nav-link" href="available-exams.jsp">Available Exams</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="my-results.jsp">My Results</a>
                    </li>
                </ul>
                <form action="../logout" method="post" class="d-flex">
                    <button type="submit" class="btn btn-outline-light">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">My Results</h2>

        <!-- Performance Summary Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <h6 class="card-title">Exams Taken</h6>
                        <p class="display-6">${examsTaken}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <h6 class="card-title">Average Score</h6>
                        <p class="display-6">${averageScore}%</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <h6 class="card-title">Highest Score</h6>
                        <p class="display-6">${highestScore}%</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <h6 class="card-title">Pass Rate</h6>
                        <p class="display-6">${passRate}%</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Results List -->
        <div class="row">
            <c:forEach var="result" items="${results}">
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">${result.examTitle}</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <p class="mb-2">Score: ${result.score}/${result.totalMarks}</p>
                                <div class="progress">
                                    <div class="progress-bar ${result.percentage >= 60 ? 'bg-success' : 'bg-danger'}" 
                                         role="progressbar" 
                                         style="width: ${result.percentage}%" 
                                         aria-valuenow="${result.percentage}" 
                                         aria-valuemin="0" 
                                         aria-valuemax="100">
                                        ${result.percentage}%
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <small class="text-muted">
                                        <i class="bi bi-calendar"></i> ${result.submissionDate}
                                    </small>
                                </div>
                                <div class="col-6 text-end">
                                    <span class="badge ${result.percentage >= 60 ? 'bg-success' : 'bg-danger'}">
                                        ${result.percentage >= 60 ? 'PASS' : 'FAIL'}
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="d-flex justify-content-between">
                                <button class="btn btn-primary btn-sm" onclick="viewDetails(${result.resultId})">
                                    <i class="bi bi-eye"></i> View Details
                                </button>
                                <c:if test="${result.percentage >= 60}">
                                    <button class="btn btn-success btn-sm certificate-btn" onclick="downloadCertificate(${result.resultId})">
                                        <i class="bi bi-award"></i> Get Certificate
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- No Results Message -->
        <c:if test="${empty results}">
            <div class="alert alert-info text-center">
                <i class="bi bi-info-circle"></i> You haven't taken any exams yet.
                <br>
                <a href="available-exams.jsp" class="btn btn-primary mt-2">View Available Exams</a>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewDetails(resultId) {
            window.location.href = `result-details.jsp?id=${resultId}`;
        }

        function downloadCertificate(resultId) {
            window.location.href = `download-certificate?id=${resultId}`;
        }
    </script>
</body>
</html>
