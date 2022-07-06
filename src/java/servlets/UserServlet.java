package servlets;

import dataaccess.RoleDB;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Role;
import models.User;
import services.RoleService;
import services.UserService;

public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        action = (action == null) ? "" : action;

        switch (action) {
            case "view":
                String email = request.getParameter("email");
                getUser(email, request);
                break;
            default:
                break;
        }

        loadAllData(request);

        // load the JSP
        getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
        return; // Stop code call after send it to a jsp
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user;
        String action = request.getParameter("action_post");
        action = (action == null) ? "" : action;

        switch (action) {
            case "delete":
                String email = request.getParameter("email_post");
                if (deleteUser(email, request)) {
                    request.setAttribute("message", "delete");
                }
                break;
            case "edit":
                user = getUserData(request);

                if (isMandatoryDataProvided(user, request) && updateUser(user, request)) {
                    request.setAttribute("message", "update");
                }
                break;
            case "add":
                user = getUserData(request);

                if (isMandatoryDataProvided(user, request) && createUser(user, request)) {
                    request.setAttribute("message", "create");
                }
                break;
            default:
                break;
        }

        loadAllData(request);

        // load the JSP
        getServletContext().getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
        return; // Stop code call after send it to a jsp
    }

    private boolean loadAllData(HttpServletRequest request) {
        try {
            UserService userService = new UserService();
            RoleService roleService = new RoleService();

            List<User> users = userService.getAll();
            request.setAttribute("users", users);

            List<Role> roles = roleService.getAll();
            request.setAttribute("roles", roles);

            return true;
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
            return false;
        }
    }

    private boolean getUser(String email, HttpServletRequest request) {
        try {
            UserService userService = new UserService();

            User user = userService.get(email);
            request.setAttribute("user", user);

            return true;
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
            return false;
        }
    }

    private boolean deleteUser(String email, HttpServletRequest request) {
        try {
            UserService userService = new UserService();
            userService.delete(email);
            return true;
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
            return false;
        }
    }

    private boolean updateUser(User user, HttpServletRequest request) {
        try {
            UserService userService = new UserService();
            userService.update(user.getEmail(), user.getActive(), user.getFirstName(), user.getLastName(), user.getPassword(), user.getRole().getRoleId());
            return true;
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
            return false;
        }
    }

    private boolean createUser(User user, HttpServletRequest request) {
        try {
            UserService userService = new UserService();
            userService.insert(user.getEmail(), user.getActive(), user.getFirstName(), user.getLastName(), user.getPassword(), user.getRole().getRoleId());
            return true;
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
            return false;
        }
    }

    private User getUserData(HttpServletRequest request) {
        String email = request.getParameter("email_post");
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String password = request.getParameter("password");
        int role = Integer.parseInt(request.getParameter("role"));
        String activeStr = request.getParameter("active");
        boolean active = activeStr == null ? false : !activeStr.isEmpty();
        User user = new User(email, active, firstName, lastName, password);

        try {
            RoleDB roleDB = new RoleDB();
            Role r = roleDB.get(role);
            user.setRole(r);
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    private boolean isMandatoryDataProvided(User user, HttpServletRequest request) {

        boolean validData = true;

        if ((user.getEmail() == null || user.getEmail().isEmpty())) {
            validData = false;
        }

        if (user.getLastName() == null || user.getLastName().isEmpty()) {
            validData = false;
        }

        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            validData = false;
        }

        if (user.getRole().getRoleId() < 0) {
            validData = false;
        }

        if (!validData) {
            request.setAttribute("message", "error");
        }

        return validData;
    }
}
