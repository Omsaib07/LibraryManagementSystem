<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% System.out.println("Profile JSP loaded!"); %>

<!DOCTYPE html>
<html>
<head>
    <title>Your Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .card {
            max-width: 500px;
            margin: auto;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="container py-4">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Library Management System</a>
            <div class="collapse navbar-collapse justify-content-end">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="/user-dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="/users/profile">Profile</a></li>
                    <li class="nav-item"><a class="nav-link btn btn-danger text-white" href="/users/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <header class="mb-4 text-center">
        <h2>Your Profile</h2>
    </header>

    <main>
        <c:if test="${sessionScope.loggedInUser == null}">
            <div class="alert alert-danger text-center">You must be logged in to view this page.</div>
        </c:if>

        <c:if test="${sessionScope.loggedInUser != null}">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title text-center">User Information</h5>
                    <p><strong>Name:</strong> ${sessionScope.loggedInUser.name}</p>
                    <p><strong>Username:</strong> ${sessionScope.loggedInUser.username}</p>
                    <p><strong>Email:</strong> ${sessionScope.loggedInUser.email}</p>
                    <p><strong>Phone:</strong> ${sessionScope.loggedInUser.phone}</p>
                    <p><strong>Role:</strong> ${sessionScope.loggedInUser.role}</p>

                    <div class="text-center mt-3">
                        <a href="/users/edit/${sessionScope.loggedInUser.id}" class="btn btn-primary">Edit Profile</a>
                        <a href="/user-dashboard" class="btn btn-secondary">Back to Dashboard</a>
                    </div>
                </div>
            </div>
        </c:if>
    </main>

    <footer class="mt-5 pt-3 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

</body>
</html>
