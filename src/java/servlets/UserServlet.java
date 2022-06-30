package servlets;

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

        String action = request.getParameter("action");
        action = (action == null) ? "" : action;

        switch (action) {
            case "delete":
                String email = request.getParameter("email");
                if (deleteUser(email, request)) {
                    request.setAttribute("message", "delete");
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
}
