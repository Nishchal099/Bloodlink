package com.bloodlinkk.controller;

import java.io.IOException;
import java.util.List;
import com.bloodlinkk.model.User;
import com.bloodlinkk.model.Donor;
import com.bloodlinkk.model.Request;
import com.bloodlinkk.model.Campaign;
import com.bloodlinkk.service.CampaignService;
import com.bloodlinkk.service.DonorService;
import com.bloodlinkk.service.RequestService;
import com.bloodlinkk.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
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
        
        if (!"admin".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        String section = request.getParameter("section");
        
        // Common attributes for all sections
        request.setAttribute("totalUsers", userService.getTotalUsers());
        request.setAttribute("totalDonors", userService.getTotalDonors());
        request.setAttribute("pendingRequests", requestService.getPendingRequestsCount());
        request.setAttribute("activeCampaigns", campaignService.getActiveCampaignsCount());
        
        // Handle different sections
        if ("users".equals(section)) {
            // Redirect to ManageUsersServlet
            response.sendRedirect(request.getContextPath() + "/manage-users");
            return;
            
        } else if ("donors".equals(section)) {
            // Redirect to ManageDonorsServlet
            response.sendRedirect(request.getContextPath() + "/manage-donors");
            return;
            
        } else if ("requests".equals(section)) {
            // Blood Requests Section
            List<Request> pendingRequests = requestService.getAllPendingRequests();
            long criticalCount = pendingRequests.stream().filter(r -> "Critical".equals(r.getEmergencyLevel())).count();
            long urgentCount = pendingRequests.stream().filter(r -> "Urgent".equals(r.getEmergencyLevel())).count();
            long normalCount = pendingRequests.stream().filter(r -> "Normal".equals(r.getEmergencyLevel())).count();
            
            request.setAttribute("pendingRequestsList", pendingRequests);
            request.setAttribute("criticalCount", criticalCount);
            request.setAttribute("urgentCount", urgentCount);
            request.setAttribute("normalCount", normalCount);
            request.getRequestDispatcher("/WEB-INF/pages/admin-requests.jsp").forward(request, response);
            
        } else {
            // Dashboard Section (default)
            request.setAttribute("allUsers", userService.getAllUsers());
            request.setAttribute("allDonors", donorService.getAllDonors());
            request.setAttribute("pendingRequestsList", requestService.getAllPendingRequests());
            request.setAttribute("upcomingCampaigns", campaignService.getUpcomingCampaigns());
            request.setAttribute("ongoingCampaigns", campaignService.getOngoingCampaigns());
            request.setAttribute("completedCampaigns", campaignService.getCompletedCampaigns());
            request.getRequestDispatcher("/WEB-INF/pages/admin-dashboard.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User user = (User) request.getSession().getAttribute("user");
        
        if (user == null || !"admin".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("deleteUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userService.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/admin?section=users&success=true");
            
        } else if ("toggleDonor".equals(action)) {
            int donorId = Integer.parseInt(request.getParameter("donorId"));
            Donor donor = donorService.getDonorById(donorId);
            if (donor != null) {
                donorService.updateAvailability(donor.getUserId(), !donor.isAvailable());
            }
            response.sendRedirect(request.getContextPath() + "/admin?section=donors&success=true");
            
        } else if ("fulfillRequest".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            requestService.updateRequestStatus(requestId, "fulfilled");
            response.sendRedirect(request.getContextPath() + "/admin?section=requests&success=true");
            
        } else {
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }
}