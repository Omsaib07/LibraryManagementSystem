<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Fines - Library Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
    <h1 class="text-center">My Fines</h1>
    
    <table class="table table-bordered mt-4">
        <thead class="table-dark">
            <tr>
                <th>Fine ID</th>
                <th>Book Title</th>
                <th>Amount</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="fine" items="${fines}">
                <tr>
                    <td><c:out value="${fine.id}" /></td>
                    <td><c:out value="${fine.loan.book.book_name}" /></td>
                    <td>₹<c:out value="${fine.fineAmount}" /></td>
                    <td>
                        <a href="/user/fines/pay/${fine.id}" class="btn btn-success btn-sm">Pay Fine</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <footer class="mt-5 text-center">
        <p>&copy; 2025 Library Management System</p>
    </footer>
</body>
</html>