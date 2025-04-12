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
<nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
<div class="container-fluid">
<a class="navbar-brand" href="/">LMS</a>
<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
<span class="navbar-toggler-icon"></span>
</button>
<div class="collapse navbar-collapse" id="navbarNav">
<ul class="navbar-nav me-auto">
<li class="nav-item">
<a class="nav-link active" href="/books">Books</a>
</li>
<c:if test="${sessionScope.role == 'ADMIN'}">
<li class="nav-item">
<a class="nav-link" href="/users">Users</a>
</li>
<li class="nav-item">
<a class="nav-link" href="/loans">Loans</a>
</li>
<li class="nav-item">
<a class="nav-link" href="/fines">Fines</a>
</li>
<li class="nav-item">
<a class="nav-link" href="/categories">Categories</a>
</li>
<li class="nav-item">
<a class="nav-link active" href="/events">Events</a>
</li>
<li class="nav-item">
    <a class="nav-link" href="/registration_list">Registrations</a>
</li>
</c:if>
</ul>
<div class="d-flex">
    <a href="/admin-dashboard" class="btn btn-outline-primary me-2">Dashboard</a>
<a href="/auth/logout" class="btn btn-danger">Logout</a>
</div>
</div>
</div>
</nav>
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
</body>
</html>