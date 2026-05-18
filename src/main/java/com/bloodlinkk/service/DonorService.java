package com.bloodlinkk.service;

import com.bloodlinkk.DAO.DonorDAO;
import com.bloodlinkk.model.Donor;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class DonorService {
    private DonorDAO donorDAO = new DonorDAO();
    
    // Register a new donor with eligibility check
    public boolean registerDonor(Donor donor) {
        if (donor == null) {
            System.out.println("Donor object is null");
            return false;
        }
        
        if (donor.getAge() < 18 || donor.getAge() > 65) {
            System.out.println("Validation failed: Donor age must be between 18 and 65. Current age: " + donor.getAge());
            return false;
        }
        
        if (donor.getWeight() < 45) {
            System.out.println("Validation failed: Donor weight must be at least 45 kg. Current weight: " + donor.getWeight());
            return false;
        }
        
        if (donor.getBloodGroup() == null || donor.getBloodGroup().isEmpty()) {
            System.out.println("Validation failed: Blood group is required");
            return false;
        }
        
        if (donor.getGender() == null || donor.getGender().isEmpty()) {
            System.out.println("Validation failed: Gender is required");
            return false;
        }
        
        return donorDAO.registerDonor(donor);
    }
    
    // Get donor by user ID
    public Donor getDonorByUserId(int userId) {
        if (userId <= 0) {
            System.out.println("Invalid user ID: " + userId);
            return null;
        }
        return donorDAO.getDonorByUserId(userId);
    }
    
    // Find donors by blood group
    public List<Donor> findDonorsByBloodGroup(String bloodGroup) {
        if (bloodGroup == null || bloodGroup.isEmpty()) {
            System.out.println("Blood group is required for search");
            return null;
        }
        return donorDAO.findDonorsByBloodGroup(bloodGroup);
    }
    
    // Find donors by blood group and city
    public List<Donor> findDonorsByBloodGroupAndCity(String bloodGroup, String city) {
        if (bloodGroup == null || bloodGroup.isEmpty()) {
            System.out.println("Blood group is required for search");
            return null;
        }
        return donorDAO.findDonorsByBloodGroupAndCity(bloodGroup, city);
    }
    
    // Get all donors
    public List<Donor> getAllDonors() {
        return donorDAO.getAllDonors();
    }
    
    // Update donor availability status
    public boolean updateAvailability(int userId, boolean isAvailable) {
        if (userId <= 0) {
            System.out.println("Invalid user ID: " + userId);
            return false;
        }
        return donorDAO.updateAvailability(userId, isAvailable);
    }
    
    // Get total number of donors
    public int getDonorsCount() {
        return donorDAO.getDonorsCount();
    }
    
    // Check if user is already a donor
    public boolean isDonor(int userId) {
        Donor donor = donorDAO.getDonorByUserId(userId);
        return donor != null;
    }
    
    // Update donation count after donation
    public boolean updateDonationCount(int donorId) {
        if (donorId <= 0) {
            System.out.println("Invalid donor ID: " + donorId);
            return false;
        }
        return donorDAO.updateDonationCount(donorId);
    }
    
    // Check if donor is eligible to donate again (90 days rule)
    public boolean isEligibleToDonate(Donor donor) {
        if (donor == null || donor.getLastDonationDate() == null) {
            return true;
        }
        
        java.util.Date lastDonation = donor.getLastDonationDate();
        java.util.Date today = new java.util.Date();
        
        long diffInMillies = today.getTime() - lastDonation.getTime();
        long diffInDays = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
        
        return diffInDays >= 90;
    }
    
    // Get active donors count
    public int getActiveDonorsCount() {
        List<Donor> allDonors = donorDAO.getAllDonors();
        int activeCount = 0;
        for (Donor donor : allDonors) {
            if (donor.isAvailable()) {
                activeCount++;
            }
        }
        return activeCount;
    }
    
    // Update donor information
    public boolean updateDonor(Donor donor) {
        if (donor == null || donor.getUserId() <= 0) {
            System.out.println("Invalid donor data");
            return false;
        }
        return donorDAO.updateDonor(donor);
    }
    
    // Get donor by donor ID
    public Donor getDonorById(int donorId) {
        if (donorId <= 0) {
            System.out.println("Invalid donor ID: " + donorId);
            return null;
        }
        return donorDAO.getDonorById(donorId);
    }
    
    // Get recent donors
    public List<Donor> getRecentDonors(int limit) {
        if (limit <= 0) {
            limit = 10;
        }
        return donorDAO.getRecentDonors(limit);
    }
}