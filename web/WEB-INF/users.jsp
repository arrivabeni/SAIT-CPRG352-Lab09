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
                <c:forEach items="${users}" var="u">
                    <tr>
                        <td>${u.getEmail()}</td>
                        <td>${u.getFirstName()}</td>
                        <td>${u.getLastName()}</td>
                        <td class="password">${u.getPassword()}</td>
                        <td>${u.getRoleName()}</td>
                        <td><i class='fa-solid <c:choose>
                                   <c:when test="${u.isActive()}">fa-check</c:when>
                                   <c:otherwise>fa-xmark</c:otherwise>
                               </c:choose>'>
                            </i></td>
                        <td>
                            <a href='<c:url value="">
                                        <c:param name="action" value="view"/>
                                        <c:param name="email" value="${u.getEmail()}"/>
                                    </c:url>'>
                                <i class="fa-solid fa-pen-to-square fa-lg"></i>
                            </a>
                        </td>
                        <td>
                            <form method="POST" action="">
                                <button type="submit" class="icon-btn">
                                    <i class="fa-solid fa-trash-can fa-lg"></i>
                                </button>
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="email" value="${u.getEmail()}">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <p>${user.getEmail()}</p>
        </main>

        <form id="deleteForm" method="POST" action="">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="emailToDelete" id="emailToDelete" value="">
        </form>

        <div id="message">
            <c:if test="${message eq 'create'}">User created</c:if>
            <c:if test="${message eq 'update'}">User updated</c:if>
            <c:if test="${message eq 'delete'}">User deleted</c:if>
            <c:if test="${message eq 'error'}">Sorry, something went wrong. <i class="fa-solid fa-face-frown"></i></c:if>
            </div>

            <!-- Custom scripts -->
            <script src="<c:url value='/assets/scripts/users.js'/>"></script>
    </body>
</html>
