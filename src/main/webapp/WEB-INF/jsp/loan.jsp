<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Loans</title>
</head>
<body>
    <h2>Library Loans</h2>
    <table border="1">
        <tr>
            <th>User Name</th>
            <th>Book Name</th>
            <th>Borrow Date</th>
            <th>Return Date</th>
        </tr>
        <c:forEach var="loan" items="${loans}">
            <tr>
                <td>${loan.user.name}</td>
                <td>${loan.book.book_name}</td>
                <td>${loan.borrowDate}</td>
                <td>${loan.returnDate}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>