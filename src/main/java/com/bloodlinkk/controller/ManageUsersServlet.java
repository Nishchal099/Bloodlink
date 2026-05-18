package com.bloodlinkk.controller;

import java.io.IOException;
import java.util.List;
import com.bloodlinkk.model.User;
import com.bloodlinkk.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manage-users")
public class ManageUsersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User admin = (User) request.getSession().getAttribute("user");
        if (admin == null || !"admin".equals(admin.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userService.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/manage-users?success=true");
            return;
        }
        
        // Get all users
        List<User> users = userService.getAllUsers();
        
        // Set attributes
        request.setAttribute("users", users);
        request.setAttribute("totalUsers", userService.getTotalUsers());
        request.setAttribute("adminCount", userService.getUsersByType("admin").size());
        request.setAttribute("donorCount", userService.getUsersByType("donor").size());
        request.setAttribute("requesterCount", userService.getUsersByType("requester").size());
        
        request.getRequestDispatcher("/WEB-INF/pages/manage-users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User admin = (User) request.getSession().getAttribute("user");
        if (admin == null || !"admin".equals(admin.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String userType = request.getParameter("userType");
            
            User user = userService.getUserById(userId);
            if (user != null) {
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setCity(city);
                user.setUserType(userType);
                userService.updateUser(user);
            }
            response.sendRedirect(request.getContextPath() + "/manage-users?success=true");
            
        } else if ("add".equals(action)) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String city = request.getParameter("city");
            String userType = request.getParameter("userType");
            
            User user = new User(fullName, email, password, phone, "", city, userType);
            userService.registerUser(user);
            response.sendRedirect(request.getContextPath() + "/manage-users?success=true");
            
        } else {
            response.sendRedirect(request.getContextPath() + "/manage-users");
        }
    }
}