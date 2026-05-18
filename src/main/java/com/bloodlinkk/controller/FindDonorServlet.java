package com.bloodlinkk.controller;

import java.io.IOException;
import java.util.List;
import com.bloodlinkk.model.Donor;
import com.bloodlinkk.service.DonorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/findDonor")
public class FindDonorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DonorService donorService = new DonorService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String bloodGroup = request.getParameter("bloodGroup");
        List<Donor> donors;
        
        if (bloodGroup != null && !bloodGroup.isEmpty()) {
            donors = donorService.findDonorsByBloodGroup(bloodGroup);
        } else {
            donors = donorService.getAllDonors();
        }
        
        request.setAttribute("donors", donors);
        
        // CHANGE THIS LINE - Remove /WEB-INF/
        request.getRequestDispatcher("/pages/find-donor.jsp").forward(request, response);
    }
}