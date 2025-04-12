<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Categories - Library Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script>
        // Display alert messages if available
        window.onload = function() {
            var errorMessage = "${errorMessage}";
            var successMessage = "${successMessage}";
            if (errorMessage) {
                alert(errorMessage);
            }
            if (successMessage) {
                alert(successMessage);
            }
        };
    </script>
</head>
<body class="container py-4">
    <header class="mb-4">
        <h1 class="text-center">Book Categories</h1>
        <jsp:include page="admin_navbar.jsp" />
    </header>

    <main>
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Add New Category</h5>
                <form action="/categories/save" method="post" class="row g-3">
                    <div class="col-md-8">
                        <input type="text" class="form-control" name="categoryName" placeholder="Category Name" required>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100">Add Category</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Existing Categories</h5>
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>${category.id}</td>
                                <td>${category.categoryName}</td>
                             
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
    <footer class="mt-5 pt-5 text-center text-muted">
        <p>&copy; 2025 Library Management System</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>