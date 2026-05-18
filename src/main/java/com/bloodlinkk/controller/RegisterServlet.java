package com.bloodlinkk.controller;

import java.io.IOException;
import java.sql.Date;

import com.bloodlinkk.model.Donor;
import com.bloodlinkk.model.User;
import com.bloodlinkk.service.UserService;
import com.bloodlinkk.service.DonorService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
    private DonorService donorService = new DonorService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get basic user information
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String userType = request.getParameter("userType");
            
            // Create and register user
            User user = new User(fullName, email, password, phone, address, city, userType);
            boolean userRegistered = userService.registerUser(user);
            
            if (userRegistered) {
                request.getSession().setAttribute("user", user);
                
                // If user is a donor, register donor details
                if ("donor".equals(userType)) {
                    String bloodGroup = request.getParameter("bloodGroup");
                    String ageStr = request.getParameter("age");
                    String gender = request.getParameter("gender");
                    String weightStr = request.getParameter("weight");
                    String medicalConditions = request.getParameter("medicalConditions");
                    
                    Donor donor = new Donor();
                    donor.setUserId(user.getUserId());
                    donor.setBloodGroup(bloodGroup != null && !bloodGroup.isEmpty() ? bloodGroup : "O+");
                    donor.setAge(ageStr != null && !ageStr.isEmpty() ? Integer.parseInt(ageStr) : 25);
                    donor.setGender(gender != null && !gender.isEmpty() ? gender : "Male");
                    donor.setWeight(weightStr != null && !weightStr.isEmpty() ? Double.parseDouble(weightStr) : 65.0);
                    donor.setLastDonationDate(null);
                    donor.setMedicalConditions(medicalConditions != null && !medicalConditions.isEmpty() ? medicalConditions : "None");
                    donor.setAvailable(true);
                    donor.setDonationCount(0);
                    
                    donorService.registerDonor(donor);
                }
                
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/register?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/register?error=true");
        }
    }
}