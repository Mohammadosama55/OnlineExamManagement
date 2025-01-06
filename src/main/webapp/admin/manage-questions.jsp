<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Questions - Admin</title>
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
                        <a class="nav-link active" href="manage-questions.jsp">Manage Questions</a>
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
            <h2>Manage Questions - ${exam.title}</h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addQuestionModal">
                <i class="bi bi-plus-circle"></i> Add New Question
            </button>
        </div>

        <!-- Question List -->
        <div class="row">
            <c:forEach var="question" items="${questions}">
                <div class="col-12 mb-4">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Question ${question.questionId}</h5>
                            <div>
                                <button class="btn btn-sm btn-primary" onclick="editQuestion(${question.questionId})">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="deleteQuestion(${question.questionId})">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <p class="card-text">${question.questionText}</p>
                            <div class="options-list">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" disabled 
                                           ${question.correctAnswer == 'A' ? 'checked' : ''}>
                                    <label class="form-check-label">A) ${question.option1}</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" disabled 
                                           ${question.correctAnswer == 'B' ? 'checked' : ''}>
                                    <label class="form-check-label">B) ${question.option2}</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" disabled 
                                           ${question.correctAnswer == 'C' ? 'checked' : ''}>
                                    <label class="form-check-label">C) ${question.option3}</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" disabled 
                                           ${question.correctAnswer == 'D' ? 'checked' : ''}>
                                    <label class="form-check-label">D) ${question.option4}</label>
                                </div>
                            </div>
                            <div class="mt-2">
                                <strong>Marks: </strong>${question.marks}
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Add Question Modal -->
    <div class="modal fade" id="addQuestionModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Question</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="question" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="examId" value="${exam.examId}">
                        
                        <div class="mb-3">
                            <label for="questionText" class="form-label">Question Text</label>
                            <textarea class="form-control" id="questionText" name="questionText" rows="3" required></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Options</label>
                            <div class="input-group mb-2">
                                <span class="input-group-text">A</span>
                                <input type="text" class="form-control" name="option1" required>
                            </div>
                            <div class="input-group mb-2">
                                <span class="input-group-text">B</span>
                                <input type="text" class="form-control" name="option2" required>
                            </div>
                            <div class="input-group mb-2">
                                <span class="input-group-text">C</span>
                                <input type="text" class="form-control" name="option3" required>
                            </div>
                            <div class="input-group mb-2">
                                <span class="input-group-text">D</span>
                                <input type="text" class="form-control" name="option4" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="correctAnswer" class="form-label">Correct Answer</label>
                            <select class="form-select" id="correctAnswer" name="correctAnswer" required>
                                <option value="">Select correct answer</option>
                                <option value="A">Option A</option>
                                <option value="B">Option B</option>
                                <option value="C">Option C</option>
                                <option value="D">Option D</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="marks" class="form-label">Marks</label>
                            <input type="number" class="form-control" id="marks" name="marks" required min="1">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Question</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editQuestion(questionId) {
            // Implement edit functionality
            window.location.href = `edit-question.jsp?id=${questionId}`;
        }

        function deleteQuestion(questionId) {
            if (confirm('Are you sure you want to delete this question?')) {
                fetch(`question?id=${questionId}`, {
                    method: 'DELETE'
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        alert('Failed to delete question');
                    }
                });
            }
        }
    </script>
</body>
</html>
