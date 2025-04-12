<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>Event List</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

</head>
<body class="container mt-4">
<!-- Navbar --><h1 class="text-center">Event Lists</h1>
<jsp:include page="admin_navbar.jsp" />
<!-- Event List -->

<a href="/events/new" class="btn btn-primary mb-3">Add Event</a>
<table class="table table-bordered">
<thead class="table-dark">
<tr>
<th>Title</th>
<th>Date & Time</th>
<th>Location</th>
<th>Capacity</th>
<th>Category</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<c:forEach var="event" items="${events}">
<tr>
<td><c:out value="${event.title}" /></td>
<td><c:out value="${event.formattedDate}" /></td>
<td><c:out value="${event.location}" /></td>
<td><c:out value="${event.capacity}" /></td>
<td><c:out value="${event.category}" /></td>
<td>
<a href="/register/${event.id}" class="btn btn-sm btn-outline-primary">Register</a>
<a href="/events/delete/${event.id}" class="btn btn-sm btn-outline-danger">Delete</a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
<footer class="mt-5 pt-5 text-center text-muted">
    <p>&copy; 2025 Library Management System</p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>