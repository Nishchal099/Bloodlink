package com.bloodlinkk.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Campaign {
    private int campaignId;
    private int organizerId;
    private String title;
    private String description;
    private String location;
    private Date campaignDate;
    private Time startTime;
    private Time endTime;
    private String contactNumber;
    private int targetUnits;
    private int collectedUnits;
    private String status;
    private Timestamp createdAt;
    private String organizerName;
    
    public Campaign() {}
    
    // Getters and Setters
    public int getCampaignId() { return campaignId; }
    public void setCampaignId(int campaignId) { this.campaignId = campaignId; }
    public int getOrganizerId() { return organizerId; }
    public void setOrganizerId(int organizerId) { this.organizerId = organizerId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public Date getCampaignDate() { return campaignDate; }
    public void setCampaignDate(Date campaignDate) { this.campaignDate = campaignDate; }
    public Time getStartTime() { return startTime; }
    public void setStartTime(Time startTime) { this.startTime = startTime; }
    public Time getEndTime() { return endTime; }
    public void setEndTime(Time endTime) { this.endTime = endTime; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public int getTargetUnits() { return targetUnits; }
    public void setTargetUnits(int targetUnits) { this.targetUnits = targetUnits; }
    public int getCollectedUnits() { return collectedUnits; }
    public void setCollectedUnits(int collectedUnits) { this.collectedUnits = collectedUnits; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getOrganizerName() { return organizerName; }
    public void setOrganizerName(String organizerName) { this.organizerName = organizerName; }
}