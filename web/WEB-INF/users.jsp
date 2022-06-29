<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users Management</title>
        <link rel="stylesheet" href="<c:url value='/assets/styles/users.css'/>">
        <script src="https://kit.fontawesome.com/2872bf313b.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <header>
            <h1>Manage Users</h1>
        </header>
        <main>
            <table>
                <tr>
                    <th>e-mail</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Password</th>
                    <th>Role</th>
                    <th>Active</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.getEmail()}</td>
                        <td>${user.getFirstName()}</td>
                        <td>${user.getLastName()}</td>
                        <td class="password">${user.getPassword()}</td>
                        <td>${user.getRoleName()}</td>
                        <td><i class='fa-solid <c:choose>
                                   <c:when test="${user.isActive()}">fa-check</c:when>
                                   <c:otherwise>fa-xmark</c:otherwise>
                               </c:choose>'>
                            </i></td>
                        <td><i class="fa-solid fa-pen-to-square"></i></td>
                        <td><i class="fa-solid fa-trash-can"></i></td>
                    </tr>
                </c:forEach>
            </table>
        </main>
    </body>
</html>
