package com.bloodlinkk.controller;

import java.io.IOException;
import java.util.List;
import com.bloodlinkk.model.Donor;
import com.bloodlinkk.model.Request;
import com.bloodlinkk.model.User;
import com.bloodlinkk.service.DonorService;
import com.bloodlinkk.service.RequestService;
import com.bloodlinkk.service.CampaignService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DonorService donorService = new DonorService();
    private RequestService requestService = new RequestService();
    private CampaignService campaignService = new CampaignService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get donor info if user is a donor
        if ("donor".equals(user.getUserType())) {
            Donor donor = donorService.getDonorByUserId(user.getUserId());
            request.setAttribute("donor", donor);
            
            // Check eligibility (90 days rule)
            if (donor != null && donor.getLastDonationDate() != null) {
                java.util.Date lastDonation = donor.getLastDonationDate();
                java.util.Date today = new java.util.Date();
                long diffInDays = (today.getTime() - lastDonation.getTime()) / (1000 * 60 * 60 * 24);
                request.setAttribute("eligible", diffInDays >= 90);
            } else {
                request.setAttribute("eligible", true);
            }
        }
        
        // Get user's requests
        List<Request> myRequests = requestService.getRequestsByRequester(user.getUserId());
        request.setAttribute("myRequests", myRequests);
        
        // Get recent requests for display
        List<Request> recentRequests = requestService.getRecentRequests(5);
        request.setAttribute("recentRequests", recentRequests);
        
        // Get upcoming campaigns
        request.setAttribute("upcomingCampaigns", campaignService.getUpcomingCampaigns());
        
        // Correct path - JSP is in WEB-INF/pages/
        request.getRequestDispatcher("/WEB-INF/pages/user-dashboard.jsp").forward(request, response);
    }
}