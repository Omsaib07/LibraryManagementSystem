<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Form</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card-custom {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        .form-label {
            font-weight: 500;
        }
        .btn-group-custom {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }
    </style>
</head>
<body class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card card-custom bg-white">
                <h3 class="mb-4 text-center">Edit Your Profile</h3>

                <!-- Use the correct form action based on user role -->
                <c:choose>
                    <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                        <form action="/users/save" method="post">
                    </c:when>
                    <c:otherwise>
                        <form action="/users/update/${user.id}" method="post">
                    </c:otherwise>
                </c:choose>
                    <input type="hidden" name="id" value="${user.id}" />

                    <div class="mb-3">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" name="name" id="name" class="form-control" value="${user.name}" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" name="email" id="email" class="form-control" value="${user.email}" required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="text" name="phone" id="phone" class="form-control" value="${user.phone}" required>
                    </div>

                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" name="username" id="username" class="form-control" value="${user.username}" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" name="password" id="password" class="form-control" value="${user.password}" required>
                    </div>

                    <!-- Only Admins can change role -->
                    <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                        <div class="mb-4">
                            <label for="role" class="form-label">Role</label>
                            <select name="role" id="role" class="form-select" required>
                                <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>User</option>
                                <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                            </select>
                        </div>
                    </c:if>

                    <!-- Send existing role as hidden field if not admin -->
                    <c:if test="${sessionScope.loggedInUser.role != 'ADMIN'}">
                        <input type="hidden" name="role" value="${user.role}" />
                    </c:if>

                    <div class="btn-group-custom">
                        <c:choose>
                            <c:when test="${sessionScope.loggedInUser.role == 'ADMIN'}">
                                <a href="/users" class="btn btn-outline-secondary">Cancel</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/users/profile" class="btn btn-outline-secondary">Cancel</a>
                            </c:otherwise>
                        </c:choose>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
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