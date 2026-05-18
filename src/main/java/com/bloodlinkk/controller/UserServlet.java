package com.bloodlinkk.controller;

import java.io.IOException;

import com.bloodlinkk.model.User;
import com.bloodlinkk.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        
        if (user != null) {
            User updatedUser = userService.getUserById(user.getUserId());
            request.setAttribute("user", updatedUser);
        }
        
        request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        
        if (user != null) {
            user.setFullName(request.getParameter("fullName"));
            user.setPhone(request.getParameter("phone"));
            user.setAddress(request.getParameter("address"));
            user.setCity(request.getParameter("city"));
            
            // Update user in database
            // userService.updateUser(user);
        }
        
        response.sendRedirect(request.getContextPath() + "/user");
    }
}