package com.bloodlinkk.service;

import com.bloodlinkk.DAO.CampaignDAO;
import com.bloodlinkk.model.Campaign;
import java.util.Date;
import java.util.List;

public class CampaignService {
    private CampaignDAO campaignDAO = new CampaignDAO();
    
    // Create a new campaign
    public boolean createCampaign(Campaign campaign) {
        if (campaign == null) {
            System.out.println("Campaign object is null");
            return false;
        }
        
        if (campaign.getOrganizerId() <= 0) {
            System.out.println("Invalid organizer ID: " + campaign.getOrganizerId());
            return false;
        }
        
        if (campaign.getTitle() == null || campaign.getTitle().trim().isEmpty()) {
            System.out.println("Campaign title is required");
            return false;
        }
        
        if (campaign.getLocation() == null || campaign.getLocation().trim().isEmpty()) {
            System.out.println("Campaign location is required");
            return false;
        }
        
        if (campaign.getCampaignDate() == null) {
            System.out.println("Campaign date is required");
            return false;
        }
        
        if (campaign.getTargetUnits() <= 0) {
            System.out.println("Target units must be greater than 0");
            return false;
        }
        
        if (campaign.getStatus() == null) {
            campaign.setStatus("upcoming");
        }
        
        if (campaign.getCampaignDate().before(new java.sql.Date(new Date().getTime()))) {
            System.out.println("Campaign date cannot be in the past");
            return false;
        }
        
        return campaignDAO.createCampaign(campaign);
    }
    
    // Get all campaigns
    public List<Campaign> getAllCampaigns() {
        return campaignDAO.getAllCampaigns();
    }
    
    // Get upcoming campaigns
    public List<Campaign> getUpcomingCampaigns() {
        return campaignDAO.getUpcomingCampaigns();
    }
    
    // Get ongoing campaigns
    public List<Campaign> getOngoingCampaigns() {
        return campaignDAO.getOngoingCampaigns();
    }
    
    // Get completed campaigns
    public List<Campaign> getCompletedCampaigns() {
        return campaignDAO.getCompletedCampaigns();
    }
    
    // Get campaign by ID
    public Campaign getCampaignById(int campaignId) {
        if (campaignId <= 0) {
            System.out.println("Invalid campaign ID: " + campaignId);
            return null;
        }
        return campaignDAO.getCampaignById(campaignId);
    }
    
    // Update campaign status
    public boolean updateCampaignStatus(int campaignId, String status) {
        if (campaignId <= 0) {
            System.out.println("Invalid campaign ID: " + campaignId);
            return false;
        }
        
        if (status == null || status.isEmpty()) {
            System.out.println("Status is required");
            return false;
        }
        
        return campaignDAO.updateCampaignStatus(campaignId, status);
    }
    
    // Update collected units for a campaign
    public boolean updateCollectedUnits(int campaignId, int units) {
        if (campaignId <= 0) {
            System.out.println("Invalid campaign ID: " + campaignId);
            return false;
        }
        
        if (units <= 0) {
            System.out.println("Units must be greater than 0");
            return false;
        }
        
        return campaignDAO.updateCollectedUnits(campaignId, units);
    }
    
    // Update campaign details
    public boolean updateCampaign(Campaign campaign) {
        if (campaign == null || campaign.getCampaignId() <= 0) {
            System.out.println("Invalid campaign data");
            return false;
        }
        return campaignDAO.updateCampaign(campaign);
    }
    
    // Delete campaign
    public boolean deleteCampaign(int campaignId) {
        if (campaignId <= 0) {
            System.out.println("Invalid campaign ID: " + campaignId);
            return false;
        }
        return campaignDAO.deleteCampaign(campaignId);
    }
    
    // Start a campaign
    public boolean startCampaign(int campaignId) {
        return updateCampaignStatus(campaignId, "ongoing");
    }
    
    // Complete a campaign
    public boolean completeCampaign(int campaignId) {
        return updateCampaignStatus(campaignId, "completed");
    }
    
    // Cancel a campaign
    public boolean cancelCampaign(int campaignId) {
        return updateCampaignStatus(campaignId, "cancelled");
    }
    
    // Get total campaigns count
    public int getTotalCampaigns() {
        return campaignDAO.getTotalCampaigns();
    }
    
    // Get total blood units collected from all campaigns
    public int getTotalUnitsCollected() {
        return campaignDAO.getTotalUnitsCollected();
    }
    
    // Get campaigns by organizer
    public List<Campaign> getCampaignsByOrganizer(int organizerId) {
        if (organizerId <= 0) {
            return new java.util.ArrayList<>();
        }
        return campaignDAO.getCampaignsByOrganizer(organizerId);
    }
    
    // Check if user can create campaign
    public boolean canCreateCampaign(String userType) {
        return "admin".equals(userType);
    }
    
    // Get active campaigns count
    public int getActiveCampaignsCount() {
        List<Campaign> upcoming = getUpcomingCampaigns();
        List<Campaign> ongoing = getOngoingCampaigns();
        int count = 0;
        if (upcoming != null) count += upcoming.size();
        if (ongoing != null) count += ongoing.size();
        return count;
    }
}