<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Categories - Library Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .card-link {
            text-decoration: none;
            color: inherit;
            transition: transform 0.2s;
        }
        .card-link:hover .card {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .card {
            transition: all 0.3s;
        }
        .nav-link.active {
            font-weight: bold;
        }
    </style>
</head>
<body class="container py-4">
    <header class="mb-4">

        <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/">Home</a>
                        </li>
                        <c:if test="${sessionScope.loggedInUser != null}">
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
                                    <a class="nav-link active" href="/categories">Categories</a>
                                </li>
                            </c:if>
                        </c:if>
                    </ul>
                    <div class="d-flex">
                        <c:choose>
                            <c:when test="${sessionScope.loggedInUser != null}">
                                <a href="/dashboard" class="btn btn-outline-primary me-2">Dashboard</a>
                                <a href="/auth/logout" class="btn btn-danger">Logout</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/auth/" class="btn btn-primary">Login</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <main>
        <!-- Add Category Form -->
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Add New Category</h5>
                <form action="/categories/save" method="post" class="row g-3">
                    <div class="col-md-8">
                        <input type="text" class="form-control" name="categoryName" placeholder="Category Name" required>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100">Add Category</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Category List -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Existing Categories</h5>
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>${category.id}</td>
                                <td>${category.categoryName}</td>
                                <td>
                                    <a href="/categories/delete/${category.id}" class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this category?');">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty categories}">
                    <p class="text-center text-muted">No categories found.</p>
                </c:if>
            </div>
        </div>
    </main>

    <footer class="mt-5 pt-5 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>