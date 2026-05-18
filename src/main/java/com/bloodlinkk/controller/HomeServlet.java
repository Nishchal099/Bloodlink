package com.bloodlinkk.controller;

import java.io.IOException;
import com.bloodlinkk.service.DonorService;
import com.bloodlinkk.service.RequestService;
import com.bloodlinkk.service.CampaignService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DonorService donorService = new DonorService();
    private RequestService requestService = new RequestService();
    private CampaignService campaignService = new CampaignService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get total donors count
        int totalDonors = donorService.getDonorsCount();
        request.setAttribute("totalDonors", totalDonors);
        
        // Get fulfilled requests count (each fulfilled request saves lives)
        int fulfilledRequests = requestService.getFulfilledRequestsCount();
        request.setAttribute("requestsFulfilled", fulfilledRequests);
        
        // Calculate lives saved (each blood donation can save up to 3 lives)
        int livesSaved = fulfilledRequests * 3;
        request.setAttribute("livesSaved", livesSaved);
        
        // Get upcoming campaigns for display
        request.setAttribute("upcomingCampaigns", campaignService.getUpcomingCampaigns());
        
        request.getRequestDispatcher("/WEB-INF/pages/index.jsp").forward(request, response);
    }
}