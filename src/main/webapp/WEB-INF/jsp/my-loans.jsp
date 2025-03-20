<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Loans</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">
    <header class="mb-4 text-center">
        <h2>My Loans</h2>
    </header>

    <main>
        <c:if test="${sessionScope.loggedInUser == null}">
            <div class="alert alert-danger text-center">You must be logged in to view this page.</div>
        </c:if>

        <c:if test="${sessionScope.loggedInUser != null}">
            <c:choose>
                <c:when test="${empty loans}">
                    <div class="alert alert-info text-center">You have not borrowed any books.</div>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Book Title</th>
                                <th>Author</th>
                                <th>Issued Date</th>
                                <th>Due Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="loan" items="${loans}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${loan.bookTitle}</td>
                                    <td>${loan.author}</td>
                                    <td>${loan.issueDate}</td>
                                    <td>${loan.dueDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${loan.returned}">
                                                <span class="text-success">Returned</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-danger">Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </c:if>
    </main>

    <footer class="mt-5 pt-3 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>
</body>
</html>