<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Library Management System</title>
    <link rel="stylesheet" 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container">
    <h2 class="mt-4 text-center">Library Management System </h2>

    <!-- Form to Add a New Book -->
    <div class="card mt-4">
        <div class="card-header bg-primary text-white">
            <h4>Add a New Book</h4>
        </div>
        <div class="card-body">
            <form action="saveBook" method="post">
                <div class="mb-3">
                    <label class="form-label">Book Name</label>
                    <input type="text" name="book_name" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Author</label>
                    <input type="text" name="author" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Purchase Date</label>
                    <input type="date" name="purchase_date" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-success">Add Book</button>
            </form>
        </div>
    </div>

    <hr>

    <!-- Book List -->
    <h3 class="mt-4">Available Books</h3>
    <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Book Name</th>
                <th>Author</th>
                <th>Purchase Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.id}</td>
                    <td>${book.book_name}</td>
                    <td>${book.author}</td>
                    <td>${book.purchase_date}</td>
                    <td>
                        <a href="delete/${book.id}" class="btn btn-danger"
                           onclick="return confirm('Are you sure you want to delete this book?');">
                           Delete
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
