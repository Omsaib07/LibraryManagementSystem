<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Books</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
    <h1 class="mb-4">Library Books</h1>
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">LMS</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="/books">Books</a>
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

    
    
    <c:if test="${sessionScope.role == 'ADMIN'}">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">Add New Book</h5>
            </div>
            <div class="card-body">
                <form action="/saveBook" method="post" class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Book Name</label>
                        <input type="text" name="book_name" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Author</label>
                        <input type="text" name="author" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Purchase Date</label>
                        <input type="date" name="purchase_date" class="form-control" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Category</label>
                        <input type="text" name="category" class="form-control" required>
                    </div>
                    <div class="col-12 mt-3">
                        <button type="submit" class="btn btn-success">Save Book</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>
    
    <div class="card">
        <div class="card-header bg-light">
            <h5 class="mb-0">Available Books</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Book Name</th>
                            <th>Author</th>
                            <th>Purchase Date</th>
                            <c:if test="${sessionScope.role == 'ADMIN'}">
                                <th>Actions</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="book" items="${books}">
                            <tr>
                                <td>${book.id}</td>
                                <td>${book.book_name}</td>
                                <td>${book.author}</td>
                                <td>${book.purchase_date}</td>
                                <c:if test="${sessionScope.role == 'ADMIN'}">
                                    <td>
                                           <a href="/deleteBook?id=${book.id}"class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this book?')">Delete</a>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>