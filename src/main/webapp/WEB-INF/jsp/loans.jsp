<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Loans</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">

    <!-- Header -->
    <header class="mb-4">
        <h1 class="text-center">Library Loans</h1>
        <jsp:include page="admin_navbar.jsp" />
    </header>

    <!-- Loans Table -->
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Library Loans</h5>
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>User Name</th>
                        <th>Book Name</th>
                        <th>Borrow Date</th>
                        <th>Return Date</th>
                        <th>Category ID</th>  <!-- Added Category ID Column -->
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="loan" items="${loans}">
                        <tr>
                            <td>${loan.user.name}</td>
                            <td>${loan.book.book_name}</td>
                            <td>${loan.borrowDate}</td>
                            <td>${loan.returnDate}</td>
                            <td>${loan.categoryId}</td>  <!-- Display Category ID -->
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty loans}">
                <p class="text-center text-muted">No loans found.</p>
            </c:if>
        </div>
    </div>

    <!-- Footer -->
    <footer class="mt-5 pt-5 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>