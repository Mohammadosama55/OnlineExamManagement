<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Exams - Admin</title>
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
                        <a class="nav-link active" href="manage-exams.jsp">Manage Exams</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manage-questions.jsp">Manage Questions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="view-results.jsp">View Results</a>
                    </li>
                </ul>
                <form action="../logout" method="post" class="d-flex">
                    <button type="submit" class="btn btn-outline-light">Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Manage Exams</h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addExamModal">
                <i class="bi bi-plus-circle"></i> Add New Exam
            </button>
        </div>

        <!-- Exam List Table -->
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Duration (mins)</th>
                        <th>Total Marks</th>
                        <th>Created Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="exam" items="${exams}">
                        <tr>
                            <td>${exam.title}</td>
                            <td>${exam.description}</td>
                            <td>${exam.duration}</td>
                            <td>${exam.totalMarks}</td>
                            <td>${exam.createdAt}</td>
                            <td>
                                <button class="btn btn-sm btn-primary" onclick="editExam(${exam.examId})">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="deleteExam(${exam.examId})">
                                    <i class="bi bi-trash"></i>
                                </button>
                                <a href="manage-questions.jsp?examId=${exam.examId}" class="btn btn-sm btn-info">
                                    <i class="bi bi-question-circle"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Add Exam Modal -->
    <div class="modal fade" id="addExamModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Exam</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="exam" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        <div class="mb-3">
                            <label for="title" class="form-label">Title</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="duration" class="form-label">Duration (minutes)</label>
                            <input type="number" class="form-control" id="duration" name="duration" required min="1">
                        </div>
                        <div class="mb-3">
                            <label for="totalMarks" class="form-label">Total Marks</label>
                            <input type="number" class="form-control" id="totalMarks" name="totalMarks" required min="1">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Exam</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editExam(examId) {
            // Implement edit functionality
            window.location.href = `edit-exam.jsp?id=${examId}`;
        }

        function deleteExam(examId) {
            if (confirm('Are you sure you want to delete this exam?')) {
                fetch(`exam?id=${examId}`, {
                    method: 'DELETE'
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        alert('Failed to delete exam');
                    }
                });
            }
        }
    </script>
</body>
</html>
