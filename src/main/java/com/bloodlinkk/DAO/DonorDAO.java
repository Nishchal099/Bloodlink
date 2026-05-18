package com.bloodlinkk.DAO;

import com.bloodlinkk.config.DBConfig;
import com.bloodlinkk.model.Donor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DonorDAO {

    // Register a new donor
    public boolean registerDonor(Donor donor) {
        String sql = "INSERT INTO donors (user_id, blood_group, age, gender, weight, last_donation_date, is_available, donation_count, medical_conditions) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, donor.getUserId());
            pstmt.setString(2, donor.getBloodGroup());
            pstmt.setInt(3, donor.getAge());
            pstmt.setString(4, donor.getGender());
            pstmt.setDouble(5, donor.getWeight());
            
            if (donor.getLastDonationDate() != null) {
                pstmt.setDate(6, donor.getLastDonationDate());
            } else {
                pstmt.setNull(6, Types.DATE);
            }
            
            pstmt.setBoolean(7, donor.isAvailable());
            pstmt.setInt(8, donor.getDonationCount());
            pstmt.setString(9, donor.getMedicalConditions());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get donor by user ID
    public Donor getDonorByUserId(int userId) {
        String sql = "SELECT d.*, u.full_name, u.phone, u.city, u.email FROM donors d JOIN users u ON d.user_id = u.user_id WHERE d.user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setAge(rs.getInt("age"));
                donor.setGender(rs.getString("gender"));
                donor.setWeight(rs.getDouble("weight"));
                donor.setLastDonationDate(rs.getDate("last_donation_date"));
                donor.setAvailable(rs.getBoolean("is_available"));
                donor.setDonationCount(rs.getInt("donation_count"));
                donor.setMedicalConditions(rs.getString("medical_conditions"));
                donor.setFullName(rs.getString("full_name"));
                donor.setPhone(rs.getString("phone"));
                donor.setCity(rs.getString("city"));
                donor.setEmail(rs.getString("email"));
                return donor;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get donor by donor ID
    public Donor getDonorById(int donorId) {
        String sql = "SELECT d.*, u.full_name, u.phone, u.city, u.email FROM donors d JOIN users u ON d.user_id = u.user_id WHERE d.donor_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, donorId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setAge(rs.getInt("age"));
                donor.setGender(rs.getString("gender"));
                donor.setWeight(rs.getDouble("weight"));
                donor.setLastDonationDate(rs.getDate("last_donation_date"));
                donor.setAvailable(rs.getBoolean("is_available"));
                donor.setDonationCount(rs.getInt("donation_count"));
                donor.setMedicalConditions(rs.getString("medical_conditions"));
                donor.setFullName(rs.getString("full_name"));
                donor.setPhone(rs.getString("phone"));
                donor.setCity(rs.getString("city"));
                donor.setEmail(rs.getString("email"));
                return donor;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Find donors by blood group
    public List<Donor> findDonorsByBloodGroup(String bloodGroup) {
        List<Donor> donors = new ArrayList<>();
        String sql = "SELECT d.*, u.full_name, u.phone, u.city, u.email FROM donors d JOIN users u ON d.user_id = u.user_id WHERE d.blood_group = ? AND d.is_available = TRUE ORDER BY d.donation_count DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bloodGroup);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setAge(rs.getInt("age"));
                donor.setGender(rs.getString("gender"));
                donor.setWeight(rs.getDouble("weight"));
                donor.setLastDonationDate(rs.getDate("last_donation_date"));
                donor.setAvailable(rs.getBoolean("is_available"));
                donor.setDonationCount(rs.getInt("donation_count"));
                donor.setMedicalConditions(rs.getString("medical_conditions"));
                donor.setFullName(rs.getString("full_name"));
                donor.setPhone(rs.getString("phone"));
                donor.setCity(rs.getString("city"));
                donor.setEmail(rs.getString("email"));
                donors.add(donor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return donors;
    }

    // Find donors by blood group and city
    public List<Donor> findDonorsByBloodGroupAndCity(String bloodGroup, String city) {
        List<Donor> donors = new ArrayList<>();
        String sql = "SELECT d.*, u.full_name, u.phone, u.city, u.email FROM donors d JOIN users u ON d.user_id = u.user_id WHERE d.blood_group = ? AND u.city = ? AND d.is_available = TRUE ORDER BY d.donation_count DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bloodGroup);
            pstmt.setString(2, city);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setAge(rs.getInt("age"));
                donor.setGender(rs.getString("gender"));
                donor.setWeight(rs.getDouble("weight"));
                donor.setLastDonationDate(rs.getDate("last_donation_date"));
                donor.setAvailable(rs.getBoolean("is_available"));
                donor.setDonationCount(rs.getInt("donation_count"));
                donor.setMedicalConditions(rs.getString("medical_conditions"));
                donor.setFullName(rs.getString("full_name"));
                donor.setPhone(rs.getString("phone"));
                donor.setCity(rs.getString("city"));
                donor.setEmail(rs.getString("email"));
                donors.add(donor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return donors;
    }

    // Get all donors
    public List<Donor> getAllDonors() {
        List<Donor> donors = new ArrayList<>();
        String sql = "SELECT d.*, u.full_name, u.phone, u.city, u.email FROM donors d JOIN users u ON d.user_id = u.user_id ORDER BY d.donation_count DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setAge(rs.getInt("age"));
                donor.setGender(rs.getString("gender"));
                donor.setWeight(rs.getDouble("weight"));
                donor.setLastDonationDate(rs.getDate("last_donation_date"));
                donor.setAvailable(rs.getBoolean("is_available"));
                donor.setDonationCount(rs.getInt("donation_count"));
                donor.setMedicalConditions(rs.getString("medical_conditions"));
                donor.setFullName(rs.getString("full_name"));
                donor.setPhone(rs.getString("phone"));
                donor.setCity(rs.getString("city"));
                donor.setEmail(rs.getString("email"));
                donors.add(donor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return donors;
    }

    // Update donor availability
    public boolean updateAvailability(int userId, boolean isAvailable) {
        String sql = "UPDATE donors SET is_available = ? WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBoolean(1, isAvailable);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update donation count after donation
    public boolean updateDonationCount(int donorId) {
        String sql = "UPDATE donors SET donation_count = donation_count + 1, last_donation_date = CURDATE() WHERE donor_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, donorId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update donor information
    public boolean updateDonor(Donor donor) {
        String sql = "UPDATE donors SET blood_group = ?, age = ?, gender = ?, weight = ?, medical_conditions = ? WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, donor.getBloodGroup());
            pstmt.setInt(2, donor.getAge());
            pstmt.setString(3, donor.getGender());
            pstmt.setDouble(4, donor.getWeight());
            pstmt.setString(5, donor.getMedicalConditions());
            pstmt.setInt(6, donor.getUserId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get total number of donors
    public int getDonorsCount() {
        String sql = "SELECT COUNT(*) FROM donors";
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

    // Get active donors count
    public int getActiveDonorsCount() {
        String sql = "SELECT COUNT(*) FROM donors WHERE is_available = TRUE";
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

    // Check if user is already a donor
    public boolean isDonor(int userId) {
        String sql = "SELECT COUNT(*) FROM donors WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get recent donors
    public List<Donor> getRecentDonors(int limit) {
        List<Donor> donors = new ArrayList<>();
        String sql = "SELECT d.*, u.full_name, u.phone, u.city, u.email FROM donors d JOIN users u ON d.user_id = u.user_id ORDER BY d.donation_count DESC LIMIT ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Donor donor = new Donor();
                donor.setDonorId(rs.getInt("donor_id"));
                donor.setUserId(rs.getInt("user_id"));
                donor.setBloodGroup(rs.getString("blood_group"));
                donor.setAge(rs.getInt("age"));
                donor.setGender(rs.getString("gender"));
                donor.setWeight(rs.getDouble("weight"));
                donor.setLastDonationDate(rs.getDate("last_donation_date"));
                donor.setAvailable(rs.getBoolean("is_available"));
                donor.setDonationCount(rs.getInt("donation_count"));
                donor.setMedicalConditions(rs.getString("medical_conditions"));
                donor.setFullName(rs.getString("full_name"));
                donor.setPhone(rs.getString("phone"));
                donor.setCity(rs.getString("city"));
                donor.setEmail(rs.getString("email"));
                donors.add(donor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return donors;
    }
}