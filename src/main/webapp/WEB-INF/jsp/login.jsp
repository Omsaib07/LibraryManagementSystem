<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Library Management - Login</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        /* Custom styles */
        body {
            background: linear-gradient(to right, #4a90e2, #145388);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
            max-width: 400px;
            width: 100%;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }
        .login-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .login-header h2 {
            font-weight: bold;
            color: #145388;
        }
        .btn-login {
            width: 100%;
            font-size: 16px;
            padding: 10px;
            background-color: #28a745;
            border: none;
        }
        .btn-login:hover {
            background-color: #218838;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <div class="login-header">
            <h2>Library Management</h2>
            <p class="text-muted">Sign in to your account</p>
        </div>

        <!-- Display error message if login fails -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>

        <!-- Login Form -->
        <form action="login" method="post">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" placeholder="Enter your Username" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-success btn-login">Login</button>
        </form>
        

        <!-- Additional Links -->
       
        <!-- signup_page -->
    <div class="text-center mt-3">
        <p><a href="<c:url value='/signup' />" class="text-primary">Create an Account</a></p>

    </div>
    </div>

    
    

    <!-- Bootstrap JS (Optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>