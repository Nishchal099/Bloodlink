package com.bloodlinkk.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

import com.bloodlinkk.model.Campaign;
import com.bloodlinkk.model.User;
import com.bloodlinkk.service.CampaignService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/campaigns")
public class CampaignServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CampaignService campaignService = new CampaignService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            // Show create campaign form (admin only)
            User user = (User) request.getSession().getAttribute("user");
            if (user == null || !"admin".equals(user.getUserType())) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            request.getRequestDispatcher("/WEB-INF/pages/add-campaign.jsp").forward(request, response);
        } else {
            // Show all campaigns
            request.setAttribute("upcomingCampaigns", campaignService.getUpcomingCampaigns());
            request.setAttribute("ongoingCampaigns", campaignService.getOngoingCampaigns());
            request.setAttribute("completedCampaigns", campaignService.getCompletedCampaigns());
            request.getRequestDispatcher("/WEB-INF/pages/campaigns.jsp").forward(request, response);  
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        
        // Check if user is admin
        if (user == null || !"admin".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            Campaign campaign = new Campaign();
            campaign.setOrganizerId(user.getUserId());
            campaign.setTitle(request.getParameter("title"));
            campaign.setDescription(request.getParameter("description"));
            campaign.setLocation(request.getParameter("location"));
            campaign.setCampaignDate(Date.valueOf(request.getParameter("campaignDate")));
            campaign.setStartTime(Time.valueOf(request.getParameter("startTime") + ":00"));
            campaign.setEndTime(Time.valueOf(request.getParameter("endTime") + ":00"));
            campaign.setContactNumber(request.getParameter("contactNumber"));
            campaign.setTargetUnits(Integer.parseInt(request.getParameter("targetUnits")));
            campaign.setCollectedUnits(0);
            campaign.setStatus("upcoming");
            
            if (campaignService.createCampaign(campaign)) {
                response.sendRedirect(request.getContextPath() + "/campaigns?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/campaigns?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/campaigns?error=true");
        }
    }
}