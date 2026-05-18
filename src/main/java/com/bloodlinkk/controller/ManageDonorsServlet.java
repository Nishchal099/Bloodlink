package com.bloodlinkk.controller;

import java.io.IOException;
import java.util.List;
import com.bloodlinkk.model.Donor;
import com.bloodlinkk.model.User;
import com.bloodlinkk.service.DonorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/manage-donors")
public class ManageDonorsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DonorService donorService = new DonorService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User admin = (User) request.getSession().getAttribute("user");
        if (admin == null || !"admin".equals(admin.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("toggle".equals(action)) {
            int donorId = Integer.parseInt(request.getParameter("donorId"));
            Donor donor = donorService.getDonorById(donorId);
            if (donor != null) {
                donorService.updateAvailability(donor.getUserId(), !donor.isAvailable());
            }
            response.sendRedirect(request.getContextPath() + "/manage-donors?success=true");
            return;
        }
        
        // Get all donors
        List<Donor> donors = donorService.getAllDonors();
        
        // Calculate statistics
        long availableCount = donors.stream().filter(Donor::isAvailable).count();
        long unavailableCount = donors.size() - availableCount;
        int totalDonations = donors.stream().mapToInt(Donor::getDonationCount).sum();
        
        // Set attributes
        request.setAttribute("donors", donors);
        request.setAttribute("totalDonors", donors.size());
        request.setAttribute("availableCount", availableCount);
        request.setAttribute("unavailableCount", unavailableCount);
        request.setAttribute("totalDonations", totalDonations);
        
        request.getRequestDispatcher("/WEB-INF/pages/manage-donors.jsp").forward(request, response);
    }
}