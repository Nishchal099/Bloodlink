package com.bloodlinkk.DAO;

import com.bloodlinkk.config.DBConfig;
import com.bloodlinkk.model.Response;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResponseDAO {

    // Create a new donor response to a blood request
    public boolean createResponse(Response response) {
        String sql = "INSERT INTO donor_responses (donor_id, request_id, status, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, response.getDonorId());
            pstmt.setInt(2, response.getRequestId());
            pstmt.setString(3, response.getStatus() != null ? response.getStatus() : "pending");
            pstmt.setString(4, response.getMessage());

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    response.setResponseId(rs.getInt(1));
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get response by ID
    public Response getResponseById(int responseId) {
        String sql = "SELECT r.*, d.donor_id, u.full_name as donor_name, u.phone as donor_phone, req.blood_group, req.units_needed, req.hospital_name FROM donor_responses r JOIN donors d ON r.donor_id = d.donor_id JOIN users u ON d.user_id = u.user_id JOIN requests req ON r.request_id = req.request_id WHERE r.response_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, responseId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Response response = new Response();
                response.setResponseId(rs.getInt("response_id"));
                response.setDonorId(rs.getInt("donor_id"));
                response.setRequestId(rs.getInt("request_id"));
                response.setResponseDate(rs.getTimestamp("response_date"));
                response.setStatus(rs.getString("status"));
                response.setMessage(rs.getString("message"));
                response.setDonorName(rs.getString("donor_name"));
                response.setDonorPhone(rs.getString("donor_phone"));
                return response;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all responses for a specific blood request
    public List<Response> getResponsesByRequestId(int requestId) {
        List<Response> responses = new ArrayList<>();
        String sql = "SELECT r.*, d.donor_id, u.full_name as donor_name, u.phone as donor_phone FROM donor_responses r JOIN donors d ON r.donor_id = d.donor_id JOIN users u ON d.user_id = u.user_id WHERE r.request_id = ? ORDER BY r.response_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, requestId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Response response = new Response();
                response.setResponseId(rs.getInt("response_id"));
                response.setDonorId(rs.getInt("donor_id"));
                response.setRequestId(rs.getInt("request_id"));
                response.setResponseDate(rs.getTimestamp("response_date"));
                response.setStatus(rs.getString("status"));
                response.setMessage(rs.getString("message"));
                response.setDonorName(rs.getString("donor_name"));
                response.setDonorPhone(rs.getString("donor_phone"));
                responses.add(response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return responses;
    }

    // Get all responses by a specific donor
    public List<Response> getResponsesByDonorId(int donorId) {
        List<Response> responses = new ArrayList<>();
        String sql = "SELECT r.*, req.blood_group, req.units_needed, req.hospital_name, req.patient_name FROM donor_responses r JOIN requests req ON r.request_id = req.request_id WHERE r.donor_id = ? ORDER BY r.response_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, donorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Response response = new Response();
                response.setResponseId(rs.getInt("response_id"));
                response.setDonorId(rs.getInt("donor_id"));
                response.setRequestId(rs.getInt("request_id"));
                response.setResponseDate(rs.getTimestamp("response_date"));
                response.setStatus(rs.getString("status"));
                response.setMessage(rs.getString("message"));
                responses.add(response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return responses;
    }

    // Get pending responses for a request
    public List<Response> getPendingResponsesByRequestId(int requestId) {
        List<Response> responses = new ArrayList<>();
        String sql = "SELECT r.*, d.donor_id, u.full_name as donor_name, u.phone as donor_phone FROM donor_responses r JOIN donors d ON r.donor_id = d.donor_id JOIN users u ON d.user_id = u.user_id WHERE r.request_id = ? AND r.status = 'pending' ORDER BY r.response_date ASC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, requestId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Response response = new Response();
                response.setResponseId(rs.getInt("response_id"));
                response.setDonorId(rs.getInt("donor_id"));
                response.setRequestId(rs.getInt("request_id"));
                response.setResponseDate(rs.getTimestamp("response_date"));
                response.setStatus(rs.getString("status"));
                response.setMessage(rs.getString("message"));
                response.setDonorName(rs.getString("donor_name"));
                response.setDonorPhone(rs.getString("donor_phone"));
                responses.add(response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return responses;
    }

    // Update response status (accept/decline)
    public boolean updateResponseStatus(int responseId, String status) {
        String sql = "UPDATE donor_responses SET status = ? WHERE response_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, responseId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update response with message
    public boolean updateResponseMessage(int responseId, String message) {
        String sql = "UPDATE donor_responses SET message = ? WHERE response_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, message);
            pstmt.setInt(2, responseId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete response
    public boolean deleteResponse(int responseId) {
        String sql = "DELETE FROM donor_responses WHERE response_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, responseId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if donor has already responded to a request
    public boolean hasDonorResponded(int donorId, int requestId) {
        String sql = "SELECT COUNT(*) FROM donor_responses WHERE donor_id = ? AND request_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, donorId);
            pstmt.setInt(2, requestId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get accepted response for a request
    public Response getAcceptedResponseForRequest(int requestId) {
        String sql = "SELECT r.*, d.donor_id, u.full_name as donor_name, u.phone as donor_phone FROM donor_responses r JOIN donors d ON r.donor_id = d.donor_id JOIN users u ON d.user_id = u.user_id WHERE r.request_id = ? AND r.status = 'accepted' LIMIT 1";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, requestId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Response response = new Response();
                response.setResponseId(rs.getInt("response_id"));
                response.setDonorId(rs.getInt("donor_id"));
                response.setRequestId(rs.getInt("request_id"));
                response.setResponseDate(rs.getTimestamp("response_date"));
                response.setStatus(rs.getString("status"));
                response.setMessage(rs.getString("message"));
                response.setDonorName(rs.getString("donor_name"));
                response.setDonorPhone(rs.getString("donor_phone"));
                return response;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get response count by status for a request
    public int getResponseCountByStatus(int requestId, String status) {
        String sql = "SELECT COUNT(*) FROM donor_responses WHERE request_id = ? AND status = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, requestId);
            pstmt.setString(2, status);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}