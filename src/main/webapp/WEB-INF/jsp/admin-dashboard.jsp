<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Management System</title>
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
    <header class="mb-5">
        <h1 class="text-center">Library Management System</h1>
        <p class="text-center text-muted">Welcome to the Library Management System Portal</p>
        
        <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
            <div class="container-fluid">
                <a class="navbar-brand" href="/">LMS</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    
                    <div class="d-flex">
                        <c:choose>
                            <c:when test="${sessionScope.loggedInUser != null}">
                                
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
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <c:if test="${sessionScope.loggedInUser == null}">
                <!-- Only show if not logged in -->
                <div class="col">
                    <a href="/auth/" class="card-link">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h5 class="card-title">Login</h5>
                                <p class="card-text">Access your library account</p>
                                <div class="d-grid">
                                    <button class="btn btn-primary">Login Now</button>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </c:if>
            
            <c:if test="${sessionScope.loggedInUser != null}">
                <!-- Show these when logged in -->
                <div class="col">
                    <a href="/books" class="card-link">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h5 class="card-title">Books</h5>
                                <p class="card-text">Browse all available books</p>
                                <div class="d-grid">
                                    <button class="btn btn-outline-primary">View Books</button>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                
                
                
                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <!-- Admin-only links -->
                    <div class="col">
                        <a href="/users" class="card-link">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <h5 class="card-title">Users</h5>
                                    <p class="card-text">Manage library users</p>
                                    <div class="d-grid">
                                        <button class="btn btn-outline-primary">Manage Users</button>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    
                    <div class="col">
                        <a href="/loans" class="card-link">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <h5 class="card-title">Loans</h5>
                                    <p class="card-text">Manage book loans</p>
                                    <div class="d-grid">
                                        <button class="btn btn-outline-primary">View Loans</button>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    
                    <div class="col">
                        <a href="/fines" class="card-link">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <h5 class="card-title">Fines</h5>
                                    <p class="card-text">Manage user fines</p>
                                    <div class="d-grid">
                                        <button class="btn btn-outline-primary">Manage Fines</button>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    
                    <div class="col">
                        <a href="/categories" class="card-link">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <h5 class="card-title">Categories</h5>
                                    <p class="card-text">Manage book categories</p>
                                    <div class="d-grid">
                                        <button class="btn btn-outline-primary">Manage Categories</button>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:if>
            </c:if>
        </div>
    </main>
    
    <footer class="mt-5 pt-5 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>