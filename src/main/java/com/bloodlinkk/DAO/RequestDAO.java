package com.bloodlinkk.DAO;

import com.bloodlinkk.config.DBConfig;
import com.bloodlinkk.model.Request;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RequestDAO {
    
    // Create a new blood request
    public boolean createRequest(Request request) {
        String sql = "INSERT INTO requests (requester_id, patient_name, blood_group, units_needed, hospital_name, hospital_address, contact_person, contact_phone, emergency_level, additional_notes, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, request.getRequesterId());
            pstmt.setString(2, request.getPatientName());
            pstmt.setString(3, request.getBloodGroup());
            pstmt.setInt(4, request.getUnitsNeeded());
            pstmt.setString(5, request.getHospitalName());
            pstmt.setString(6, request.getHospitalAddress());
            pstmt.setString(7, request.getContactPerson());
            pstmt.setString(8, request.getContactPhone());
            pstmt.setString(9, request.getEmergencyLevel());
            pstmt.setString(10, request.getAdditionalNotes());
            pstmt.setString(11, "pending");
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    request.setRequestId(rs.getInt(1));
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get request by ID
    public Request getRequestById(int requestId) {
        String sql = "SELECT r.*, u.full_name as requester_name, u.phone as requester_phone FROM requests r JOIN users u ON r.requester_id = u.user_id WHERE r.request_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, requestId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Request request = new Request();
                request.setRequestId(rs.getInt("request_id"));
                request.setRequesterId(rs.getInt("requester_id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setBloodGroup(rs.getString("blood_group"));
                request.setUnitsNeeded(rs.getInt("units_needed"));
                request.setHospitalName(rs.getString("hospital_name"));
                request.setHospitalAddress(rs.getString("hospital_address"));
                request.setContactPerson(rs.getString("contact_person"));
                request.setContactPhone(rs.getString("contact_phone"));
                request.setEmergencyLevel(rs.getString("emergency_level"));
                request.setRequestDate(rs.getTimestamp("request_date"));
                request.setStatus(rs.getString("status"));
                request.setAdditionalNotes(rs.getString("additional_notes"));
                request.setRequesterName(rs.getString("requester_name"));
                request.setRequesterPhone(rs.getString("requester_phone"));
                return request;
            }
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // Get all requests by requester ID
    public List<Request> getRequestsByRequester(int requesterId) {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT * FROM requests WHERE requester_id = ? ORDER BY request_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, requesterId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Request request = new Request();
                request.setRequestId(rs.getInt("request_id"));
                request.setRequesterId(rs.getInt("requester_id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setBloodGroup(rs.getString("blood_group"));
                request.setUnitsNeeded(rs.getInt("units_needed"));
                request.setHospitalName(rs.getString("hospital_name"));
                request.setHospitalAddress(rs.getString("hospital_address"));
                request.setContactPerson(rs.getString("contact_person"));
                request.setContactPhone(rs.getString("contact_phone"));
                request.setEmergencyLevel(rs.getString("emergency_level"));
                request.setRequestDate(rs.getTimestamp("request_date"));
                request.setStatus(rs.getString("status"));
                request.setAdditionalNotes(rs.getString("additional_notes"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    // Get all pending requests
    public List<Request> getAllPendingRequests() {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name as requester_name, u.phone as requester_phone FROM requests r JOIN users u ON r.requester_id = u.user_id WHERE r.status = 'pending' ORDER BY CASE WHEN r.emergency_level = 'Critical' THEN 1 WHEN r.emergency_level = 'Urgent' THEN 2 ELSE 3 END, r.request_date ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Request request = new Request();
                request.setRequestId(rs.getInt("request_id"));
                request.setRequesterId(rs.getInt("requester_id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setBloodGroup(rs.getString("blood_group"));
                request.setUnitsNeeded(rs.getInt("units_needed"));
                request.setHospitalName(rs.getString("hospital_name"));
                request.setHospitalAddress(rs.getString("hospital_address"));
                request.setContactPerson(rs.getString("contact_person"));
                request.setContactPhone(rs.getString("contact_phone"));
                request.setEmergencyLevel(rs.getString("emergency_level"));
                request.setRequestDate(rs.getTimestamp("request_date"));
                request.setStatus(rs.getString("status"));
                request.setAdditionalNotes(rs.getString("additional_notes"));
                request.setRequesterName(rs.getString("requester_name"));
                request.setRequesterPhone(rs.getString("requester_phone"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    // Get requests by blood group
    public List<Request> getRequestsByBloodGroup(String bloodGroup) {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name as requester_name, u.phone as requester_phone FROM requests r JOIN users u ON r.requester_id = u.user_id WHERE r.blood_group = ? AND r.status = 'pending' ORDER BY r.request_date ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bloodGroup);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Request request = new Request();
                request.setRequestId(rs.getInt("request_id"));
                request.setRequesterId(rs.getInt("requester_id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setBloodGroup(rs.getString("blood_group"));
                request.setUnitsNeeded(rs.getInt("units_needed"));
                request.setHospitalName(rs.getString("hospital_name"));
                request.setHospitalAddress(rs.getString("hospital_address"));
                request.setContactPerson(rs.getString("contact_person"));
                request.setContactPhone(rs.getString("contact_phone"));
                request.setEmergencyLevel(rs.getString("emergency_level"));
                request.setRequestDate(rs.getTimestamp("request_date"));
                request.setStatus(rs.getString("status"));
                request.setAdditionalNotes(rs.getString("additional_notes"));
                request.setRequesterName(rs.getString("requester_name"));
                request.setRequesterPhone(rs.getString("requester_phone"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    // Get requests by emergency level
    public List<Request> getRequestsByEmergencyLevel(String emergencyLevel) {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name as requester_name, u.phone as requester_phone FROM requests r JOIN users u ON r.requester_id = u.user_id WHERE r.emergency_level = ? AND r.status = 'pending' ORDER BY r.request_date ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, emergencyLevel);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Request request = new Request();
                request.setRequestId(rs.getInt("request_id"));
                request.setRequesterId(rs.getInt("requester_id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setBloodGroup(rs.getString("blood_group"));
                request.setUnitsNeeded(rs.getInt("units_needed"));
                request.setHospitalName(rs.getString("hospital_name"));
                request.setHospitalAddress(rs.getString("hospital_address"));
                request.setContactPerson(rs.getString("contact_person"));
                request.setContactPhone(rs.getString("contact_phone"));
                request.setEmergencyLevel(rs.getString("emergency_level"));
                request.setRequestDate(rs.getTimestamp("request_date"));
                request.setStatus(rs.getString("status"));
                request.setAdditionalNotes(rs.getString("additional_notes"));
                request.setRequesterName(rs.getString("requester_name"));
                request.setRequesterPhone(rs.getString("requester_phone"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    // Update request status
    public boolean updateRequestStatus(int requestId, String status) {
        String sql = "UPDATE requests SET status = ? WHERE request_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, requestId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update request with additional info
    public boolean updateRequest(Request request) {
        String sql = "UPDATE requests SET patient_name = ?, units_needed = ?, hospital_name = ?, hospital_address = ?, contact_person = ?, contact_phone = ?, additional_notes = ? WHERE request_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, request.getPatientName());
            pstmt.setInt(2, request.getUnitsNeeded());
            pstmt.setString(3, request.getHospitalName());
            pstmt.setString(4, request.getHospitalAddress());
            pstmt.setString(5, request.getContactPerson());
            pstmt.setString(6, request.getContactPhone());
            pstmt.setString(7, request.getAdditionalNotes());
            pstmt.setInt(8, request.getRequestId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get pending requests count
    public int getPendingRequestsCount() {
        String sql = "SELECT COUNT(*) FROM requests WHERE status = 'pending'";
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
    
    // Get fulfilled requests count
    public int getFulfilledRequestsCount() {
        String sql = "SELECT COUNT(*) FROM requests WHERE status = 'fulfilled'";
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
    
    // Get total units of blood requested (pending)
    public int getTotalUnitsRequested() {
        String sql = "SELECT SUM(units_needed) FROM requests WHERE status = 'pending'";
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
    
    // Get recent requests
    public List<Request> getRecentRequests(int limit) {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name as requester_name, u.phone as requester_phone FROM requests r JOIN users u ON r.requester_id = u.user_id ORDER BY r.request_date DESC LIMIT ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Request request = new Request();
                request.setRequestId(rs.getInt("request_id"));
                request.setRequesterId(rs.getInt("requester_id"));
                request.setPatientName(rs.getString("patient_name"));
                request.setBloodGroup(rs.getString("blood_group"));
                request.setUnitsNeeded(rs.getInt("units_needed"));
                request.setHospitalName(rs.getString("hospital_name"));
                request.setHospitalAddress(rs.getString("hospital_address"));
                request.setContactPerson(rs.getString("contact_person"));
                request.setContactPhone(rs.getString("contact_phone"));
                request.setEmergencyLevel(rs.getString("emergency_level"));
                request.setRequestDate(rs.getTimestamp("request_date"));
                request.setStatus(rs.getString("status"));
                request.setAdditionalNotes(rs.getString("additional_notes"));
                request.setRequesterName(rs.getString("requester_name"));
                request.setRequesterPhone(rs.getString("requester_phone"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
}