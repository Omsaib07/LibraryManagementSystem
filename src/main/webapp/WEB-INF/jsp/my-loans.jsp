<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Loans - Library Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>My Borrowed Books</h2>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <div class="row mb-3">
            <div class="col">
                <a href="${pageContext.request.contextPath}/userbooks/available" class="btn btn-primary">Borrow Books</a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Home</a>
            </div>
        </div>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Book</th>
                    <th>Author</th>
                    <th>Borrow Date</th>
                    <th>Due Date</th>
                    <th>Days Left</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${userBooks}" var="userBook">
                    <c:set var="book" value="${requestScope['book_'.concat(userBook.id)]}" />
                    <c:set var="daysLeft" value="${userBook.returnDate.toEpochDay() - java.time.LocalDate.now().toEpochDay()}" />
                    
                    <tr>
                        <td>${book.bookName}</td>
                        <td>${book.author}</td>
                        <td>${userBook.borrowDate}</td>
                        <td>${userBook.returnDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${daysLeft < 0}">
                                    <span class="text-danger font-weight-bold">Overdue by ${-daysLeft} day(s)</span>
                                </c:when>
                                <c:when test="${daysLeft == 0}">
                                    <span class="text-warning font-weight-bold">Due today</span>
                                </c:when>
                                <c:when test="${daysLeft <= 2}">
                                    <span class="text-warning">${daysLeft} day(s)</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-success">${daysLeft} days</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/userbooks/return/${userBook.id}" method="post" style="display: inline;">
                                <button type="submit" class="btn btn-primary btn-sm">Return Book</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty userBooks}">
                    <tr>
                        <td colspan="6" class="text-center">You don't have any borrowed books.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>