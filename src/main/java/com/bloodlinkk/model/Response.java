package com.bloodlinkk.model;

import java.sql.Timestamp;

public class Response {
    private int responseId;
    private int donorId;
    private int requestId;
    private Timestamp responseDate;
    private String status;
    private String message;
    private String donorName;
    private String donorPhone;
    private String bloodGroup;
    private int unitsNeeded;
    private String hospitalName;
    private String patientName;
    
    // Default constructor
    public Response() {}
    
    // Parameterized constructor
    public Response(int donorId, int requestId, String status, String message) {
        this.donorId = donorId;
        this.requestId = requestId;
        this.status = status;
        this.message = message;
    }
    
    // Getters and Setters
    public int getResponseId() {
        return responseId;
    }
    
    public void setResponseId(int responseId) {
        this.responseId = responseId;
    }
    
    public int getDonorId() {
        return donorId;
    }
    
    public void setDonorId(int donorId) {
        this.donorId = donorId;
    }
    
    public int getRequestId() {
        return requestId;
    }
    
    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }
    
    public Timestamp getResponseDate() {
        return responseDate;
    }
    
    public void setResponseDate(Timestamp responseDate) {
        this.responseDate = responseDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public String getDonorName() {
        return donorName;
    }
    
    public void setDonorName(String donorName) {
        this.donorName = donorName;
    }
    
    public String getDonorPhone() {
        return donorPhone;
    }
    
    public void setDonorPhone(String donorPhone) {
        this.donorPhone = donorPhone;
    }
    
    public String getBloodGroup() {
        return bloodGroup;
    }
    
    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
    }
    
    public int getUnitsNeeded() {
        return unitsNeeded;
    }
    
    public void setUnitsNeeded(int unitsNeeded) {
        this.unitsNeeded = unitsNeeded;
    }
    
    public String getHospitalName() {
        return hospitalName;
    }
    
    public void setHospitalName(String hospitalName) {
        this.hospitalName = hospitalName;
    }
    
    public String getPatientName() {
        return patientName;
    }
    
    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }
    
    // Helper methods
    public boolean isPending() {
        return "pending".equalsIgnoreCase(status);
    }
    
    public boolean isAccepted() {
        return "accepted".equalsIgnoreCase(status);
    }
    
    public boolean isDeclined() {
        return "declined".equalsIgnoreCase(status);
    }
    
    @Override
    public String toString() {
        return "Response{" +
                "responseId=" + responseId +
                ", donorId=" + donorId +
                ", requestId=" + requestId +
                ", status='" + status + '\'' +
                ", message='" + message + '\'' +
                '}';
    }
}