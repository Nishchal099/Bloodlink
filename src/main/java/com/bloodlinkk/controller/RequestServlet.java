package com.bloodlinkk.controller;

import java.io.IOException;

import com.bloodlinkk.model.Request;
import com.bloodlinkk.model.User;
import com.bloodlinkk.service.DonorService;
import com.bloodlinkk.service.RequestService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/requestBlood")
public class RequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RequestService requestService = new RequestService();
    private DonorService donorService = new DonorService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String bloodGroup = request.getParameter("bloodGroup");
        if (bloodGroup != null && !bloodGroup.isEmpty()) {
            request.setAttribute("availableDonors", donorService.findDonorsByBloodGroup(bloodGroup));
        }
        request.getRequestDispatcher("/WEB-INF/pages/request-blood.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        Request bloodRequest = new Request();
        bloodRequest.setRequesterId(user.getUserId());
        bloodRequest.setPatientName(request.getParameter("patientName"));
        bloodRequest.setBloodGroup(request.getParameter("bloodGroup"));
        bloodRequest.setUnitsNeeded(Integer.parseInt(request.getParameter("unitsNeeded")));
        bloodRequest.setHospitalName(request.getParameter("hospitalName"));
        bloodRequest.setHospitalAddress(request.getParameter("hospitalAddress"));
        bloodRequest.setContactPerson(request.getParameter("contactPerson"));
        bloodRequest.setContactPhone(request.getParameter("contactPhone"));
        bloodRequest.setEmergencyLevel(request.getParameter("emergencyLevel"));
        bloodRequest.setAdditionalNotes(request.getParameter("additionalNotes"));
        
        if (requestService.createRequest(bloodRequest)) {
            // Redirect to the same page with success parameter
            response.sendRedirect(request.getContextPath() + "/requestBlood?success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/requestBlood?error=true");
        }
    }
}