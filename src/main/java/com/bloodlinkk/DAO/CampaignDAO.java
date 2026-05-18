package com.bloodlinkk.DAO;

import com.bloodlinkk.config.DBConfig;
import com.bloodlinkk.model.Campaign;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CampaignDAO {
    
    // Create a new campaign
    public boolean createCampaign(Campaign campaign) {
        String sql = "INSERT INTO campaigns (organizer_id, title, description, location, campaign_date, start_time, end_time, contact_number, target_units, collected_units, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, campaign.getOrganizerId());
            pstmt.setString(2, campaign.getTitle());
            pstmt.setString(3, campaign.getDescription());
            pstmt.setString(4, campaign.getLocation());
            pstmt.setDate(5, campaign.getCampaignDate());
            pstmt.setTime(6, campaign.getStartTime());
            pstmt.setTime(7, campaign.getEndTime());
            pstmt.setString(8, campaign.getContactNumber());
            pstmt.setInt(9, campaign.getTargetUnits());
            pstmt.setInt(10, campaign.getCollectedUnits());
            pstmt.setString(11, campaign.getStatus());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    campaign.setCampaignId(rs.getInt(1));
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all campaigns
    public List<Campaign> getAllCampaigns() {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as organizer_name FROM campaigns c JOIN users u ON c.organizer_id = u.user_id ORDER BY c.campaign_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Campaign campaign = new Campaign();
                campaign.setCampaignId(rs.getInt("campaign_id"));
                campaign.setOrganizerId(rs.getInt("organizer_id"));
                campaign.setTitle(rs.getString("title"));
                campaign.setDescription(rs.getString("description"));
                campaign.setLocation(rs.getString("location"));
                campaign.setCampaignDate(rs.getDate("campaign_date"));
                campaign.setStartTime(rs.getTime("start_time"));
                campaign.setEndTime(rs.getTime("end_time"));
                campaign.setContactNumber(rs.getString("contact_number"));
                campaign.setTargetUnits(rs.getInt("target_units"));
                campaign.setCollectedUnits(rs.getInt("collected_units"));
                campaign.setStatus(rs.getString("status"));
                campaign.setCreatedAt(rs.getTimestamp("created_at"));
                campaign.setOrganizerName(rs.getString("organizer_name"));
                campaigns.add(campaign);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }
    
    // Get upcoming campaigns (future dates, status upcoming)
    public List<Campaign> getUpcomingCampaigns() {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as organizer_name FROM campaigns c JOIN users u ON c.organizer_id = u.user_id WHERE c.status = 'upcoming' AND c.campaign_date >= CURDATE() ORDER BY c.campaign_date ASC LIMIT 10";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Campaign campaign = new Campaign();
                campaign.setCampaignId(rs.getInt("campaign_id"));
                campaign.setOrganizerId(rs.getInt("organizer_id"));
                campaign.setTitle(rs.getString("title"));
                campaign.setDescription(rs.getString("description"));
                campaign.setLocation(rs.getString("location"));
                campaign.setCampaignDate(rs.getDate("campaign_date"));
                campaign.setStartTime(rs.getTime("start_time"));
                campaign.setEndTime(rs.getTime("end_time"));
                campaign.setContactNumber(rs.getString("contact_number"));
                campaign.setTargetUnits(rs.getInt("target_units"));
                campaign.setCollectedUnits(rs.getInt("collected_units"));
                campaign.setStatus(rs.getString("status"));
                campaign.setCreatedAt(rs.getTimestamp("created_at"));
                campaign.setOrganizerName(rs.getString("organizer_name"));
                campaigns.add(campaign);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }
    
    // Get ongoing campaigns
    public List<Campaign> getOngoingCampaigns() {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as organizer_name FROM campaigns c JOIN users u ON c.organizer_id = u.user_id WHERE c.status = 'ongoing' ORDER BY c.campaign_date ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Campaign campaign = new Campaign();
                campaign.setCampaignId(rs.getInt("campaign_id"));
                campaign.setOrganizerId(rs.getInt("organizer_id"));
                campaign.setTitle(rs.getString("title"));
                campaign.setDescription(rs.getString("description"));
                campaign.setLocation(rs.getString("location"));
                campaign.setCampaignDate(rs.getDate("campaign_date"));
                campaign.setStartTime(rs.getTime("start_time"));
                campaign.setEndTime(rs.getTime("end_time"));
                campaign.setContactNumber(rs.getString("contact_number"));
                campaign.setTargetUnits(rs.getInt("target_units"));
                campaign.setCollectedUnits(rs.getInt("collected_units"));
                campaign.setStatus(rs.getString("status"));
                campaign.setCreatedAt(rs.getTimestamp("created_at"));
                campaign.setOrganizerName(rs.getString("organizer_name"));
                campaigns.add(campaign);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }
    
    // Get completed campaigns
    public List<Campaign> getCompletedCampaigns() {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as organizer_name FROM campaigns c JOIN users u ON c.organizer_id = u.user_id WHERE c.status = 'completed' ORDER BY c.campaign_date DESC LIMIT 10";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Campaign campaign = new Campaign();
                campaign.setCampaignId(rs.getInt("campaign_id"));
                campaign.setOrganizerId(rs.getInt("organizer_id"));
                campaign.setTitle(rs.getString("title"));
                campaign.setDescription(rs.getString("description"));
                campaign.setLocation(rs.getString("location"));
                campaign.setCampaignDate(rs.getDate("campaign_date"));
                campaign.setStartTime(rs.getTime("start_time"));
                campaign.setEndTime(rs.getTime("end_time"));
                campaign.setContactNumber(rs.getString("contact_number"));
                campaign.setTargetUnits(rs.getInt("target_units"));
                campaign.setCollectedUnits(rs.getInt("collected_units"));
                campaign.setStatus(rs.getString("status"));
                campaign.setCreatedAt(rs.getTimestamp("created_at"));
                campaign.setOrganizerName(rs.getString("organizer_name"));
                campaigns.add(campaign);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }
    
    // Get campaign by ID
    public Campaign getCampaignById(int campaignId) {
        String sql = "SELECT c.*, u.full_name as organizer_name FROM campaigns c JOIN users u ON c.organizer_id = u.user_id WHERE c.campaign_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, campaignId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Campaign campaign = new Campaign();
                campaign.setCampaignId(rs.getInt("campaign_id"));
                campaign.setOrganizerId(rs.getInt("organizer_id"));
                campaign.setTitle(rs.getString("title"));
                campaign.setDescription(rs.getString("description"));
                campaign.setLocation(rs.getString("location"));
                campaign.setCampaignDate(rs.getDate("campaign_date"));
                campaign.setStartTime(rs.getTime("start_time"));
                campaign.setEndTime(rs.getTime("end_time"));
                campaign.setContactNumber(rs.getString("contact_number"));
                campaign.setTargetUnits(rs.getInt("target_units"));
                campaign.setCollectedUnits(rs.getInt("collected_units"));
                campaign.setStatus(rs.getString("status"));
                campaign.setCreatedAt(rs.getTimestamp("created_at"));
                campaign.setOrganizerName(rs.getString("organizer_name"));
                return campaign;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Update campaign status
    public boolean updateCampaignStatus(int campaignId, String status) {
        String sql = "UPDATE campaigns SET status = ? WHERE campaign_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, campaignId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update collected units for a campaign
    public boolean updateCollectedUnits(int campaignId, int units) {
        String sql = "UPDATE campaigns SET collected_units = collected_units + ? WHERE campaign_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, units);
            pstmt.setInt(2, campaignId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update campaign details
    public boolean updateCampaign(Campaign campaign) {
        String sql = "UPDATE campaigns SET title = ?, description = ?, location = ?, campaign_date = ?, start_time = ?, end_time = ?, contact_number = ?, target_units = ? WHERE campaign_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, campaign.getTitle());
            pstmt.setString(2, campaign.getDescription());
            pstmt.setString(3, campaign.getLocation());
            pstmt.setDate(4, campaign.getCampaignDate());
            pstmt.setTime(5, campaign.getStartTime());
            pstmt.setTime(6, campaign.getEndTime());
            pstmt.setString(7, campaign.getContactNumber());
            pstmt.setInt(8, campaign.getTargetUnits());
            pstmt.setInt(9, campaign.getCampaignId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete campaign
    public boolean deleteCampaign(int campaignId) {
        String sql = "DELETE FROM campaigns WHERE campaign_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, campaignId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get campaigns by organizer
    public List<Campaign> getCampaignsByOrganizer(int organizerId) {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as organizer_name FROM campaigns c JOIN users u ON c.organizer_id = u.user_id WHERE c.organizer_id = ? ORDER BY c.campaign_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, organizerId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Campaign campaign = new Campaign();
                campaign.setCampaignId(rs.getInt("campaign_id"));
                campaign.setOrganizerId(rs.getInt("organizer_id"));
                campaign.setTitle(rs.getString("title"));
                campaign.setDescription(rs.getString("description"));
                campaign.setLocation(rs.getString("location"));
                campaign.setCampaignDate(rs.getDate("campaign_date"));
                campaign.setStartTime(rs.getTime("start_time"));
                campaign.setEndTime(rs.getTime("end_time"));
                campaign.setContactNumber(rs.getString("contact_number"));
                campaign.setTargetUnits(rs.getInt("target_units"));
                campaign.setCollectedUnits(rs.getInt("collected_units"));
                campaign.setStatus(rs.getString("status"));
                campaign.setCreatedAt(rs.getTimestamp("created_at"));
                campaign.setOrganizerName(rs.getString("organizer_name"));
                campaigns.add(campaign);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return campaigns;
    }
    
    // Get total campaigns count
    public int getTotalCampaigns() {
        String sql = "SELECT COUNT(*) FROM campaigns";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Get total blood units collected from all campaigns
    public int getTotalUnitsCollected() {
        String sql = "SELECT SUM(collected_units) FROM campaigns";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}