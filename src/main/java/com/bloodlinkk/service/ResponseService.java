package com.bloodlinkk.service;

import com.bloodlinkk.DAO.ResponseDAO;
import com.bloodlinkk.model.Response;
import java.util.List;

public class ResponseService {
    private ResponseDAO responseDAO = new ResponseDAO();
    
    public boolean createResponse(Response response) {
        if (response == null || response.getDonorId() <= 0 || response.getRequestId() <= 0) {
            return false;
        }
        return responseDAO.createResponse(response);
    }
    
    public Response getResponseById(int responseId) {
        return responseDAO.getResponseById(responseId);
    }
    
    public List<Response> getResponsesByRequestId(int requestId) {
        return responseDAO.getResponsesByRequestId(requestId);
    }
    
    public List<Response> getResponsesByDonorId(int donorId) {
        return responseDAO.getResponsesByDonorId(donorId);
    }
    
    public boolean updateResponseStatus(int responseId, String status) {
        return responseDAO.updateResponseStatus(responseId, status);
    }
    
    public boolean hasDonorResponded(int donorId, int requestId) {
        return responseDAO.hasDonorResponded(donorId, requestId);
    }
}