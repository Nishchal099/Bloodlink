package com.bloodlinkk.controller;

import java.io.IOException;
import com.bloodlinkk.model.User;
import com.bloodlinkk.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println("Login attempt - Email: " + email);
        
        User user = userService.loginUser(email, password);
        
        if (user != null) {
            System.out.println("Login successful! User type: " + user.getUserType());
            request.getSession().setAttribute("user", user);
            
            if ("admin".equals(user.getUserType())) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        } else {
            System.out.println("Login failed - Invalid credentials");
            response.sendRedirect(request.getContextPath() + "/login?error=true");
        }
    }
}