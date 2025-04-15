<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register for Event</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">

    <!-- Include Navbar Based on Role -->
    <c:choose>
        <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">
            <jsp:include page="admin_navbar.jsp" />
        </c:when>
        <c:otherwise>
            <jsp:include page="user_navbar.jsp" />
        </c:otherwise>
    </c:choose>

    <!-- Event Title -->
    <h2 class="mb-4">Register for: <c:out value="${event.title}" /></h2>

    <!-- Registration Form -->
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

    <!-- Footer -->
    <footer class="mt-5 pt-5 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>