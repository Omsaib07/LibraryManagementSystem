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
    <jsp:include page="admin_navbar.jsp" />

    <!-- Registration List -->
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                
                <th>Patron Name</th>
                <th>Patron Email</th>
                <th>Event Title</th>
                <th>Attended</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="reg" items="${registrations}">
                <tr>
                    
                    <td>${reg.patronName}</td>
                    <td>${reg.patronEmail}</td>
                    <td>${reg.event.title}</td>
                   
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
    <footer class="mt-5 pt-5 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>