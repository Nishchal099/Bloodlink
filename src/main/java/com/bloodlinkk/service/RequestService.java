package com.bloodlinkk.service;

import com.bloodlinkk.DAO.RequestDAO;
import com.bloodlinkk.model.Request;
import java.util.List;

public class RequestService {
    private RequestDAO requestDAO = new RequestDAO();
    
    // Create a new blood request
    public boolean createRequest(Request request) {
        if (request == null) {
            System.out.println("Request object is null");
            return false;
        }
        
        if (request.getRequesterId() <= 0) {
            System.out.println("Invalid requester ID: " + request.getRequesterId());
            return false;
        }
        
        if (request.getPatientName() == null || request.getPatientName().trim().isEmpty()) {
            System.out.println("Patient name is required");
            return false;
        }
        
        if (request.getBloodGroup() == null || request.getBloodGroup().isEmpty()) {
            System.out.println("Blood group is required");
            return false;
        }
        
        if (request.getUnitsNeeded() <= 0) {
            System.out.println("Units needed must be greater than 0");
            return false;
        }
        
        if (request.getHospitalName() == null || request.getHospitalName().trim().isEmpty()) {
            System.out.println("Hospital name is required");
            return false;
        }
        
        if (request.getContactPhone() == null || request.getContactPhone().trim().isEmpty()) {
            System.out.println("Contact phone is required");
            return false;
        }
        
        if (request.getStatus() == null) {
            request.setStatus("pending");
        }
        
        return requestDAO.createRequest(request);
    }
    
    // Get request by ID
    public Request getRequestById(int requestId) {
        if (requestId <= 0) {
            System.out.println("Invalid request ID: " + requestId);
            return null;
        }
        return requestDAO.getRequestById(requestId);
    }
    
    // Get all requests by requester ID
    public List<Request> getRequestsByRequester(int requesterId) {
        if (requesterId <= 0) {
            System.out.println("Invalid requester ID: " + requesterId);
            return null;
        }
        return requestDAO.getRequestsByRequester(requesterId);
    }
    
    // Get all pending requests
    public List<Request> getAllPendingRequests() {
        return requestDAO.getAllPendingRequests();
    }
    
    // Update request status
    public boolean updateRequestStatus(int requestId, String status) {
        if (requestId <= 0) {
            System.out.println("Invalid request ID: " + requestId);
            return false;
        }
        
        if (status == null || status.isEmpty()) {
            System.out.println("Status is required");
            return false;
        }
        
        return requestDAO.updateRequestStatus(requestId, status);
    }
    
    // Get pending requests count
    public int getPendingRequestsCount() {
        return requestDAO.getPendingRequestsCount();
    }
    
    // Get fulfilled requests count
    public int getFulfilledRequestsCount() {
        return requestDAO.getFulfilledRequestsCount();
    }
    
    // Get critical/emergency requests
    public List<Request> getCriticalRequests() {
        List<Request> allRequests = requestDAO.getAllPendingRequests();
        List<Request> criticalRequests = new java.util.ArrayList<>();
        
        for (Request request : allRequests) {
            if ("Critical".equals(request.getEmergencyLevel())) {
                criticalRequests.add(request);
            }
        }
        return criticalRequests;
    }
    
    // Get urgent requests
    public List<Request> getUrgentRequests() {
        List<Request> allRequests = requestDAO.getAllPendingRequests();
        List<Request> urgentRequests = new java.util.ArrayList<>();
        
        for (Request request : allRequests) {
            if ("Urgent".equals(request.getEmergencyLevel())) {
                urgentRequests.add(request);
            }
        }
        return urgentRequests;
    }
    
    // Get requests by blood group
    public List<Request> getRequestsByBloodGroup(String bloodGroup) {
        if (bloodGroup == null || bloodGroup.isEmpty()) {
            return new java.util.ArrayList<>();
        }
        return requestDAO.getRequestsByBloodGroup(bloodGroup);
    }
    
    // Get requests by emergency level
    public List<Request> getRequestsByEmergencyLevel(String emergencyLevel) {
        if (emergencyLevel == null || emergencyLevel.isEmpty()) {
            return new java.util.ArrayList<>();
        }
        return requestDAO.getRequestsByEmergencyLevel(emergencyLevel);
    }
    
    // Cancel request
    public boolean cancelRequest(int requestId) {
        return updateRequestStatus(requestId, "cancelled");
    }
    
    // Mark request as fulfilled
    public boolean fulfillRequest(int requestId) {
        return updateRequestStatus(requestId, "fulfilled");
    }
    
    // Get total units requested (pending)
    public int getTotalUnitsRequested() {
        return requestDAO.getTotalUnitsRequested();
    }
    
    // Get total lives saved (each donation can save up to 3 lives)
    public int getLivesSaved() {
        int fulfilledCount = getFulfilledRequestsCount();
        return fulfilledCount * 3;
    }
    
    // Get recent requests
    public List<Request> getRecentRequests(int limit) {
        if (limit <= 0) {
            limit = 10;
        }
        return requestDAO.getRecentRequests(limit);
    }
}