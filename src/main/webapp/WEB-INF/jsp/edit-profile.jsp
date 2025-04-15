<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Library Management System</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <c:choose>
                        <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                            <li class="nav-item"><a class="nav-link" href="/admin/dashboard">Dashboard</a></li>
                            <li class="nav-item"><a class="nav-link" href="/users/manage">Manage Users</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="/user/dashboard">Dashboard</a></li>
                            <li class="nav-item"><a class="nav-link" href="/books">Browse Books</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li class="nav-item"><a class="nav-link" href="/users/profile">Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Header -->
    <header class="mb-4 text-center">
        <h2>Edit Your Profile2</h2>
    </header>

    <!-- Main Content -->
    <main>
        <form action="/users/update/${sessionScope.loggedInUser.id}" method="post">
            
            <!-- Hidden input to ensure ID is passed correctly -->
            <input type="hidden" name="id" value="${sessionScope.loggedInUser.id}">

            <div class="card">
                <div class="card-body">
                    
                    <!-- Name Field -->
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" id="name" name="name" class="form-control" 
                               value="${sessionScope.loggedInUser.name}" required>
                    </div>

                    <!-- Email Field -->
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" id="email" name="email" class="form-control" 
                               value="${sessionScope.loggedInUser.email}" required>
                    </div>

                    <!-- Phone Field -->
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="text" id="phone" name="phone" class="form-control" 
                               value="${sessionScope.loggedInUser.phone}" required>
                    </div>

                    <!-- Username Field -->
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" id="username" name="username" class="form-control" 
                               value="${sessionScope.loggedInUser.username}" required>
                    </div>

                    <!-- Password Field -->
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" id="password" name="password" class="form-control" 
                               value="${sessionScope.loggedInUser.password}" required>
                    </div>

                    <!-- Role Selection (Only visible/editable for Admins) -->
                    <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <select id="role" name="role" class="form-control" required>
                                <option value="USER" ${sessionScope.loggedInUser.role == 'USER' ? 'selected' : ''}>User</option>
                                <option value="ADMIN" ${sessionScope.loggedInUser.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                            </select>
                        </div>
                    </c:if>

                    <!-- Hidden Role Field for Users (to preserve current value) -->
                    <c:if test="${sessionScope.loggedInUser.role != 'ADMIN'}">
                        <input type="hidden" name="role" value="${sessionScope.loggedInUser.role}">
                    </c:if>

                    <!-- Buttons -->
                    <div class="text-center mt-3">
                        <button type="submit" class="btn btn-success">Save Changes</button>
                        <a href="/users/profile" class="btn btn-secondary">Back to Profile</a>
                    </div>

                </div>
            </div>
        </form>
    </main>

    <!-- Footer -->
    <footer class="mt-5 pt-3 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

</body>
</html>