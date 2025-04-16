<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Library Fines</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
<body>

    
    <div class="container mt-4">
        <h2>Admin - Library Fines Management</h2>
        <jsp:include page="../admin_navbar.jsp" />
        <!-- Success and Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <!-- Summary Statistics Cards -->
        <div class="row">
            <div class="col-md-4">
                <div class="summary-card total-card">
                    <h4>Total Fines</h4>
                    <h3>$<fmt:formatNumber value="${totalFines}" pattern="#,##0.00" /></h3>
                    <p>${fines.size()} fine records</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-card paid-card">
                    <h4>Paid Fines</h4>
                    <h3>$<fmt:formatNumber value="${totalPaid}" pattern="#,##0.00" /></h3>
                    <p>
                        <c:set var="paidCount" value="0" />
                        <c:forEach items="${fines}" var="fine">
                            <c:if test="${fine.paid}">
                                <c:set var="paidCount" value="${paidCount + 1}" />
                            </c:if>
                        </c:forEach>
                        ${paidCount} records
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-card unpaid-card">
                    <h4>Unpaid Fines</h4>
                    <h3>$<fmt:formatNumber value="${totalUnpaid}" pattern="#,##0.00" /></h3>
                    <p>${fines.size() - paidCount} records</p>
                </div>
            </div>
        </div>
        
        <!-- Search/Filter Panel -->
        
        <!-- Fines Table -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Fine ID</th>
                        <th>User</th>
                        <th>Book</th>
                        <th>Borrow Date</th>
                        <th>Return Date</th>
                        <th>Days Overdue</th>
                        <th>Fine Amount</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty fines}">
                            <tr>
                                <td colspan="9" class="text-center">No fines found</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${fines}" var="fine">
                                <tr>
                                    <td>${fine.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fine.loan != null && fine.loan.user != null}">
                                                ${fine.loan.user.id} - ${fine.loan.user.username}
                                            </c:when>
                                            <c:otherwise>
                                                Unknown User
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fine.loan != null && fine.loan.book != null}">
                                                <c:out value="${fine.loan.book.book_name}" default="Book #${fine.loan.book.id}" />
                                            </c:when>
                                            <c:otherwise>
                                                Unknown Book
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fine.loan != null && fine.loan.borrowDate != null}">
                                                <fmt:formatDate value="${fine.loan.borrowDate}" pattern="yyyy-MM-dd" />
                                            </c:when>
                                            <c:otherwise>
                                                Unknown
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fine.loan != null && fine.loan.returnDate != null}">
                                                <fmt:formatDate value="${fine.loan.returnDate}" pattern="yyyy-MM-dd" />
                                            </c:when>
                                            <c:otherwise>
                                                Not Returned
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${fine.loan != null && fine.loan.borrowDate != null && fine.loan.returnDate != null}">
                                                <c:set var="borrowTime" value="${fine.loan.borrowDate.time}" />
                                                <c:set var="returnTime" value="${fine.loan.returnDate.time}" />
                                                <c:set var="daysDiff" value="${(returnTime - borrowTime) / (1000*60*60*24)}" />
                                                <c:set var="daysOverdue" value="${daysDiff - 14}" />
                                                
                                                <c:choose>
                                                    <c:when test="${daysOverdue > 0}">
                                                        <fmt:formatNumber value="${daysOverdue}" pattern="#" /> days
                                                    </c:when>
                                                    <c:otherwise>
                                                        0 days
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>$<fmt:formatNumber value="${fine.fineAmount}" pattern="#,##0.00" /></td>
                                    <td>
                                        <span class="paid-status ${fine.paid ? 'paid' : 'unpaid'}">
                                            ${fine.paid ? 'Paid' : 'Unpaid'}
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${!fine.paid}">
                                            <form action="${pageContext.request.contextPath}/admin/fines/mark-paid" method="post" style="display:inline;">
                                                <input type="hidden" name="fineId" value="${fine.id}">
                                                <button type="submit" class="btn btn-sm btn-success">Mark as Paid</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${fine.paid}">
                                            <button class="btn btn-sm btn-outline-secondary" disabled>Already Paid</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    

    
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>