<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Registration List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <!-- Navbar -->
    <h1 class="text-center">All Event Registrations</h1>
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">LMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/books">Books</a>
                    </li>
                    <c:if test="${sessionScope.role == 'ADMIN'}">
                        <li class="nav-item">
                            <a class="nav-link" href="/users">Users</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/loans">Loans</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/fines">Fines</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/categories">Categories</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/events">Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="/registration_list">Registrations</a>
                        </li>
                    </c:if>
                </ul>
                <div class="d-flex">
                    <a href="/admin-dashboard" class="btn btn-outline-primary me-2">Dashboard</a>
                    <a href="/auth/logout" class="btn btn-danger">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Registration List -->
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Patron Name</th>
                <th>Patron Email</th>
                <th>Event ID</th>
                <th>Attended</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="reg" items="${registrations}">
                <tr>
                    <td>${reg.id}</td>
                    <td>${reg.patronName}</td>
                    <td>${reg.patronEmail}</td>
                    <td>${reg.event.id}</td>
                    <td>
                        <c:choose>
                            <c:when test="${reg.attended}">
                                Yes
                            </c:when>
                            <c:otherwise>
                                No
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>a