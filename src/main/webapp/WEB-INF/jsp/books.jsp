<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Books</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="container py-4">
    <header class="mb-4 text-center">
        <h2>Library Books</h2>
    </header>

    <!-- Navbar based on role -->
    <c:choose>
        <c:when test="${sessionScope.role == 'ADMIN'}">
            <jsp:include page="admin_navbar.jsp" />
            <div class="alert alert-info text-center">
                You are logged in as an Admin. You can add or delete books.
            </div>
        </c:when>
        <c:when test="${sessionScope.role == 'USER'}">
            <jsp:include page="user_navbar.jsp" />
        </c:when>
    </c:choose>

    <!-- Admin: Add Book Form -->
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
                    <div class="col-md-4">
                        <label class="form-label">Number of Copies</label>
                        <input type="number" name="available_copies" class="form-control" required min="1">
                    </div>
                    <div class="col-12 mt-3">
                        <button type="submit" class="btn btn-success">Save Book</button>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Book List -->
    <div class="card">
        <div class="card-header bg-light">
            <h5 class="mb-0">Available Books</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Book Name</th>
                            <th>Author</th>
                            <th>Purchase Date</th>
                            <th>Available Copies</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="book" items="${books}">
                            <tr>
                                <td>${book.book_name}</td>
                                <td>${book.author}</td>
                                <td>${book.purchase_date}</td>
                                <td>${book.available_copies}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${sessionScope.role == 'ADMIN'}">
                                            <a href="/deleteBook?id=${book.id}" class="btn btn-sm btn-danger"
                                               onclick="return confirm('Are you sure you want to delete this book?')">Delete</a>
                                        </c:when>
                                        <c:when test="${sessionScope.role == 'USER'}">
                                            <c:choose>
                                                <c:when test="${book.available_copies > 0}">
                                                    <form action="/borrowBook" method="post" style="display:inline;">
                                                        <input type="hidden" name="bookId" value="${book.id}" />
                                                        <button type="submit" class="btn btn-sm btn-primary">Borrow</button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-sm btn-secondary" disabled>Unavailable</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
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