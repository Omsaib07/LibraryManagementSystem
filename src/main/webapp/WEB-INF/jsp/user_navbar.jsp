<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 rounded">
    <div class="container-fluid">
        <a class="navbar-brand" href="/user-dashboard">Library System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNavbar" aria-controls="userNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="userNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="/books">Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/loans">My Borrowed Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/fines">My Fines</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/events">Events</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/registration_list">Registrations</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/profile">My Profile</a>
                </li>
            </ul>
            <span class="navbar-text text-white me-3">
                Welcome, ${sessionScope.username}
            </span>
            <a href="/auth/logout" class="btn btn-danger">Logout</a>
        </div>
    </div>
</nav>