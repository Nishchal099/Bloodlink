package com.bloodlinkk.model;

import java.sql.Date;

public class Donor {
    private int donorId;
    private int userId;
    private String bloodGroup;
    private int age;
    private String gender;
    private double weight;
    private Date lastDonationDate;
    private boolean available;
    private int donationCount;
    private String medicalConditions;
    private String fullName;
    private String phone;
    private String city;
    private String email;
    
    public Donor() {}
    
    public int getDonorId() { return donorId; }
    public void setDonorId(int donorId) { this.donorId = donorId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }
    
    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }
    
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    
    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }
    
    public Date getLastDonationDate() { return lastDonationDate; }
    public void setLastDonationDate(Date lastDonationDate) { this.lastDonationDate = lastDonationDate; }
    
    // THIS IS THE METHOD YOU ARE MISSING - IT MUST BE EXACTLY THIS:
    public boolean isAvailable() { return available; }
    
    public void setAvailable(boolean available) { this.available = available; }
    
    public int getDonationCount() { return donationCount; }
    public void setDonationCount(int donationCount) { this.donationCount = donationCount; }
    
    public String getMedicalConditions() { return medicalConditions; }
    public void setMedicalConditions(String medicalConditions) { this.medicalConditions = medicalConditions; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}