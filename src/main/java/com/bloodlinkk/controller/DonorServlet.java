package com.bloodlinkk.controller;

import java.io.IOException;
import java.sql.Date;

import com.bloodlinkk.model.Donor;
import com.bloodlinkk.model.User;
import com.bloodlinkk.service.DonorService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/donor")
public class DonorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DonorService donorService = new DonorService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("register".equals(action)) {
            // Make sure this path is correct - your add-donor.jsp should be here
            request.getRequestDispatcher("/WEB-INF/pages/add-donor.jsp").forward(request, response);
        } else if ("status".equals(action)) {
            User user = (User) request.getSession().getAttribute("user");
            if (user != null) {
                Donor donor = donorService.getDonorByUserId(user.getUserId());
                request.setAttribute("donor", donor);
                request.getRequestDispatcher("/WEB-INF/pages/user-dashboard.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("register".equals(action)) {
            User user = (User) request.getSession().getAttribute("user");
            
            Donor donor = new Donor();
            donor.setUserId(user.getUserId());
            donor.setBloodGroup(request.getParameter("bloodGroup"));
            donor.setAge(Integer.parseInt(request.getParameter("age")));
            donor.setGender(request.getParameter("gender"));
            donor.setWeight(Double.parseDouble(request.getParameter("weight")));
            donor.setLastDonationDate(Date.valueOf(request.getParameter("lastDonationDate")));
            donor.setMedicalConditions(request.getParameter("medicalConditions"));
            donor.setAvailable(true);
            
            if (donorService.registerDonor(donor)) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/donor?action=register&error=true");
            }
        } else if ("updateStatus".equals(action)) {
            User user = (User) request.getSession().getAttribute("user");
            boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));
            donorService.updateAvailability(user.getUserId(), isAvailable);
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}