<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Custom CSS -->
<style>
    .custom-navbar {
        background-color: #f8f9fa;
        border-radius: 1rem;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        transition: all 0.4s ease;
    }

    .custom-navbar .nav-link {
        color: #333;
        font-weight: 500;
        transition: all 0.3s ease;
        position: relative;
    }

    .custom-navbar .nav-link::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        left: 50%;
        bottom: -4px;
        background-color: #007bff;
        transition: all 0.3s ease;
    }

    .custom-navbar .nav-link:hover {
        color: #007bff;
    }

    .custom-navbar .nav-link:hover::after {
        left: 0;
        width: 100%;
    }

    .custom-navbar .btn {
        transition: transform 0.3s ease, background-color 0.3s ease;
    }

    .custom-navbar .btn:hover {
        transform: translateY(-2px);
    }

    .navbar-nav {
        flex-direction: row;
        gap: 1rem;
        justify-content: flex-end;
        width: 100%;
    }

    @media (max-width: 992px) {
        .navbar-nav {
            flex-direction: column;
            gap: 0.5rem;
        }
    }
</style>

<nav class="navbar navbar-expand-lg custom-navbar mb-4">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="/">LMS</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav text-end">
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
                        <a class="nav-link" href="/admin/fines">Fines</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/categories">Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/events">Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/registration_list">Registrations</a>
                    </li>
                </c:if>
            </ul>
            <div class="d-flex ms-3">
                <a href="/admin-dashboard" class="btn btn-outline-primary me-2">Dashboard</a>
                <a href="/auth/logout" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </div>
</nav>