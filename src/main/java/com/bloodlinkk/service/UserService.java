package com.bloodlinkk.service;

import com.bloodlinkk.DAO.UserDAO;
import com.bloodlinkk.model.User;
import java.util.List;

public class UserService {
    private UserDAO userDAO = new UserDAO();
    
    public boolean registerUser(User user) {
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            System.out.println("Validation failed: Full name is required");
            return false;
        }
        
        if (user.getEmail() == null || !user.getEmail().contains("@")) {
            System.out.println("Validation failed: Invalid email format");
            return false;
        }
        
        if (user.getPassword() == null || user.getPassword().length() < 4) {
            System.out.println("Validation failed: Password must be at least 4 characters");
            return false;
        }
        
        if (user.getPhone() == null || user.getPhone().trim().isEmpty()) {
            System.out.println("Validation failed: Phone number is required");
            return false;
        }
        
        if (user.getCity() == null || user.getCity().trim().isEmpty()) {
            System.out.println("Validation failed: City is required");
            return false;
        }
        
        return userDAO.registerUser(user);
    }
    
    public User loginUser(String email, String password) {
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            System.out.println("Login failed: Email or password is empty");
            return null;
        }
        return userDAO.loginUser(email, password);
    }
    
    public User getUserById(int userId) {
        if (userId <= 0) {
            System.out.println("Invalid user ID: " + userId);
            return null;
        }
        return userDAO.getUserById(userId);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public boolean deleteUser(int userId) {
        if (userId <= 0) {
            System.out.println("Invalid user ID for deletion: " + userId);
            return false;
        }
        return userDAO.deleteUser(userId);
    }
    
    // NEW METHOD - Get total users
    public int getTotalUsers() {
        return userDAO.getTotalUsers();
    }
    
    // NEW METHOD - Get total donors
    public int getTotalDonors() {
        return userDAO.getTotalDonors();
    }
    
    public boolean updateUser(User user) {
        if (user == null || user.getUserId() <= 0) {
            System.out.println("Invalid user object for update");
            return false;
        }
        return userDAO.updateUser(user);
    }
    
    public boolean isEmailExists(String email) {
        List<User> users = userDAO.getAllUsers();
        for (User user : users) {
            if (user.getEmail().equals(email)) {
                return true;
            }
        }
        return false;
    }
    
    public boolean updatePassword(int userId, String newPassword) {
        if (userId <= 0 || newPassword == null || newPassword.isEmpty()) {
            return false;
        }
        return userDAO.updatePassword(userId, newPassword);
    }
    
    public List<User> getUsersByType(String userType) {
        return userDAO.getUsersByType(userType);
    }
}