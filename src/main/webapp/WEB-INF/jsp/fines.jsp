<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Fines</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
    <h1 class="text-center">Library Fines</h1>
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
                            <a class="nav-link active" href="/fines">Fines</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/categories">Categories</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/events">Events</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/registration_list">Registrations</a>
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
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>