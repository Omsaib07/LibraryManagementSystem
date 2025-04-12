<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Event</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <jsp:include page="admin_navbar.jsp" />
    <!-- Event Creation Form -->
    <h2>Create New Event</h2>
    <form action="/events/save" method="post" class="mt-3">
        <div class="mb-3">
            <label>Title:</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Description:</label>
            <textarea name="description" class="form-control" rows="3"></textarea>
        </div>
        <div class="mb-3">
            <label>Date & Time:</label>
            <input type="datetime-local" name="dateTime" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Capacity:</label>
            <input type="number" name="capacity" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Location:</label>
            <input type="text" name="location" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Category:</label>
            <input type="text" name="category" class="form-control">
        </div>
        <button type="submit" class="btn btn-success">Create Event</button>
    </form>
</body>
</html>