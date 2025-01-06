<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Online Exam System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%-- Check if admin is logged in --%>
    <c:if test="${empty admin}">
        <c:redirect url="../login.jsp"/>
    </c:if>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Online Exam System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="exams.jsp">Manage Exams</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="questions.jsp">Manage Questions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="results.jsp">View Results</a>
                    </li>
                </ul>
                <form action="../logout" method="post" class="d-flex">
                    <button class="btn btn-outline-light" type="submit">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Welcome, ${admin.username}!</h2>
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Manage Exams</h5>
                        <p class="card-text">Create, edit, and delete exams.</p>
                        <a href="exams.jsp" class="btn btn-primary">Go to Exams</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Manage Questions</h5>
                        <p class="card-text">Add and modify exam questions.</p>
                        <a href="questions.jsp" class="btn btn-primary">Go to Questions</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">View Results</h5>
                        <p class="card-text">Check student exam results.</p>
                        <a href="results.jsp" class="btn btn-primary">View Results</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
