<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Event List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">

    <!-- Page Title -->
    <h1 class="text-center mb-4">Event Lists</h1>

    <!-- Navbar -->
    <c:choose>
        <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">
            <jsp:include page="admin_navbar.jsp" />
        </c:when>
        <c:otherwise>
            <jsp:include page="user_navbar.jsp" />
        </c:otherwise>
    </c:choose>

    <!-- Add Event Button: Only visible to Admin -->
    <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
        <a href="/events/new" class="btn btn-primary mb-3">Add Event</a>
    </c:if>

    <!-- Event Table -->
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Title</th>
                <th>Date & Time</th>
                <th>Location</th>
                <th>Capacity</th>
                <th>Category</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="event" items="${events}">
                <tr>
                    <td><c:out value="${event.title}" /></td>
                    <td><c:out value="${event.formattedDate}" /></td>
                    <td><c:out value="${event.location}" /></td>
                    <td><c:out value="${event.capacity}" /></td>
                    <td><c:out value="${event.category}" /></td>
                    <td>
                        <!-- Both USER and ADMIN can register -->
                        <a href="/register/${event.id}" class="btn btn-sm btn-outline-primary">Register</a>

                        <!-- Only ADMIN can delete -->
                        <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                            <a href="/events/delete/${event.id}" class="btn btn-sm btn-outline-danger">Delete</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Footer -->
    <footer class="mt-5 pt-5 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>