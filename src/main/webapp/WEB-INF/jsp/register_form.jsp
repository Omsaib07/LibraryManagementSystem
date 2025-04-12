<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register for Event</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <!-- Admin Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="/admin/dashboard">LMS Admin Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <c:choose>
                        <c:when test="${sessionScope.loggedInUser != null}">
                            <a href="/auth/logout" class="btn btn-danger">Logout</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/auth/" class="btn btn-primary">Login</a>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    
    <h2>Register for: ${event.title}</h2>
    <form action="/register?eventId=${event.id}" method="post">
        <div class="mb-3">
            <label for="patronName" class="form-label">Name:</label>
            <input type="text" class="form-control" id="patronName" name="patronName" required>
        </div>
        <div class="mb-3">
            <label for="patronEmail" class="form-label">Email:</label>
            <input type="email" class="form-control" id="patronEmail" name="patronEmail" required>
        </div>
        <button type="submit" class="btn btn-success">Register</button>
        <a href="/events" class="btn btn-secondary">Back to Events</a>
    </form>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>