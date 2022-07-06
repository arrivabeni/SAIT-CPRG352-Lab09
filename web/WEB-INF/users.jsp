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
            <div>
                <h3>Add User</h3>
                <form method="POST" action="">
                    <input type="email" name="email_post" placeholder="e-mail" value="">
                    <input type="text" name="firstname" placeholder="First Name" value="">
                    <input type="text" name="lastname" placeholder="Last Name" value="">
                    <input type="password" name="password" placeholder="Password" value="">

                    <select name="role">
                        <c:forEach items="${roles}" var="role">
                            <option value="${role.getRoleId()}">${role.getRoleName()}</option>
                        </c:forEach>
                    </select>

                    <div>
                        <input type="checkbox" name="active" value="X">
                        <label for="active">Active</label>
                    </div>
                    <input type="submit" value="Save"/>
                    <input type="hidden" name="action_post" value="add">
                </form>
            </div>
            <div>
                <h3>Users</h3>
                <table>
                    <tr>
                        <th>e-mail</th>
                        <th>First Name</th>
                        <th>Last Name</th>
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
                            <td>${u.getRole().getRoleName()}</td>
                            <td><i class='fa-solid <c:choose>
                                       <c:when test="${u.getActive()}">fa-check</c:when>
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
                                    <input type="hidden" name="action_post" value="delete">
                                    <input type="hidden" name="email_post" value="${u.getEmail()}">
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <form id="deleteForm" method="POST" action="">
                    <input type="hidden" name="action_post" value="delete">
                </form>
            </div>
            <div>
                <h3>Edit User</h3>
                <form method="POST" action="">
                    <input type="email" placeholder="e-mail" value="${user.getEmail()}" disabled>
                    <input type="hidden" name="email_post" placeholder="e-mail" value="${user.getEmail()}">
                    <input type="text" name="firstname" placeholder="First Name" value="${user.getFirstName()}">
                    <input type="text" name="lastname" placeholder="Last Name" value="${user.getLastName()}">
                    <input type="password" name="password" placeholder="Password" value="${user.getPassword()}">

                    <select name="role">
                        <c:forEach items="${roles}" var="role">
                            <option value="${role.getRoleId()}" <c:if test="${user.getRole().getRoleId() == role.getRoleId()}">selected</c:if>>${role.getRoleName()}</option>
                        </c:forEach>
                    </select>

                    <div>
                        <input type="checkbox" name="active" value="X" <c:if test="${user.getActive()}">checked</c:if>>
                            <label for="active">Active</label>
                        </div>

                        <div class="inline">
                            <input type="submit" value="Save"/>
                            <input type="reset" value="Cancel"/>
                        </div>

                        <input type="hidden" name="action_post" value="edit">
                    </form>
                </div>
            </main>

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
