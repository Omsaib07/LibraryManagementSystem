<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Fines</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="container py-4">
    <h1 class="text-center">Library Fines</h1>
    <jsp:include page="admin_navbar.jsp" />
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-light">
                    <h5 class="mb-0">All Fines</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Fine ID</th>
                                    <th>Loan ID</th>
                                    <th>User</th>
                                    <th>Book</th>
                                    <th>Fine Amount</th>
                                    <th>Paid Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="fine" items="${fines}">
                                    <tr>
                                        <td>${fine.id}</td>
                                        <td>${fine.loan.id}</td>
                                        <td>${fine.loan.user.name}</td>
                                        <td>${fine.loan.book.book_name}</td>
                                        <td>$${fine.fineAmount}</td>
                                        <td>
                                            <span class="badge ${fine.paid ? 'bg-success' : 'bg-danger'}">
                                                ${fine.paid ? 'Paid' : 'Unpaid'}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="/fines/delete/${fine.id}" class="btn btn-sm btn-danger"
                                               onclick="return confirm('Are you sure you want to delete this fine?')">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
    <footer class="mt-5 pt-5 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>