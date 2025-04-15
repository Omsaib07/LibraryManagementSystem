<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Fines</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
    <!-- Header -->
    <header class="mb-4">
        <h1 class="text-center">Library Fines</h1>
        <!-- Navbar based on role -->
        <c:if test="${sessionScope.role == 'ADMIN'}">
            <jsp:include page="admin_navbar.jsp" />
        </c:if>
        <c:if test="${sessionScope.role == 'USER'}">
            <jsp:include page="user_navbar.jsp" />
        </c:if>
    </header>

    <!-- Alert for success/error messages -->
    <c:if test="${param.success == 'paid'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Fine has been paid successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Fine information -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Your Fines</h5>
            <p>Total unpaid fines: <span class="badge bg-danger">$${totalFines}</span></p>
        </div>
    </div>

    <!-- Fines Table -->
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Fine Details</h5>
            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Book Name</th>
                        <th>Borrowed Date</th>
                        <th>Return Date</th>
                        <th>Days Overdue</th>
                        <th>Fine Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="fine" items="${fines}">
                        <tr>
                            <td>${fine.loan.book.book_name}</td>
                            <td>${fine.loan.borrowDate}</td>
                            <td>${fine.loan.returnDate}</td>
                            <td>
                                <c:set var="borrowDate" value="${fine.loan.borrowDate.time}" />
                                <c:set var="returnDate" value="${fine.loan.returnDate.time}" />
                                <c:set var="daysDiff" value="${(returnDate - borrowDate) / (1000 * 60 * 60 * 24) - 14}" />
                                ${daysDiff} days
                            </td>
                            <td>$${fine.fineAmount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${fine.paid}">
                                        <span class="badge bg-success">Paid</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning">Unpaid</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${!fine.paid}">
                                    <form action="/loans/payFine" method="post" style="display:inline;">
                                        <input type="hidden" name="fineId" value="${fine.id}" />
                                        <button type="submit" class="btn btn-sm btn-primary">Pay Fine</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty fines}">
                <p class="text-center text-muted">No fines found.</p>
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