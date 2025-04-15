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
        <!-- Navbar based on role -->
        <c:if test="${sessionScope.role == 'ADMIN'}">
            <jsp:include page="admin_navbar.jsp" />
        </c:if>
        <c:if test="${sessionScope.role == 'USER'}">
            <jsp:include page="user_navbar.jsp" />
        </c:if>
    </header>

    <!-- Alert for success/error messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Book returned successfully!
            <c:if test="${not empty param.fine}">
                <strong>Note:</strong> A fine of $${param.fine} has been charged for returning this book late.
                <a href="/loans/fines" class="alert-link">View your fines</a>
            </c:if>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            Error: ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- User Fines Summary (only for regular users) -->
    <c:if test="${sessionScope.role == 'USER' && totalUnpaidFines.compareTo(java.math.BigDecimal.ZERO) > 0}">
        <div class="alert alert-warning">
            <strong>You have unpaid fines:</strong> $${totalUnpaidFines}
            <a href="/loans/fines" class="btn btn-sm btn-primary ms-3">View and Pay Fines</a>
        </div>
    </c:if>

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
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="loan" items="${loans}">
                        <tr>
                            <td>${loan.user.name}</td>
                            <td>${loan.book.book_name}</td>
                            <td>${loan.borrowDate}</td>
                            <td>${loan.returnDate != null ? loan.returnDate : 'Not returned'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${loan.returnDate == null}">
                                        <span class="badge bg-primary">Borrowed</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">Returned</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${loan.returnDate == null}">
                                    <form action="/loans/return" method="post" style="display:inline;">
                                        <input type="hidden" name="loanId" value="${loan.id}" />
                                        <button type="submit" class="btn btn-sm btn-success">Return Book</button>
                                    </form>
                                </c:if>
                                
                                <c:if test="${sessionScope.role == 'ADMIN'}">
                                    <a href="/loans/delete/${loan.id}" class="btn btn-sm btn-danger ms-2"
                                    onclick="return confirm('Are you sure you want to delete this loan record?')">Delete</a>
                                </c:if>
                            </td>
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