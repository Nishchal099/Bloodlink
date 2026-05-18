<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/home" class="logo">Blood<span>Link</span></a>
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div style="max-width: 600px; margin: 2rem auto; padding: 2rem; background: white; border-radius: 12px;">
        <h1><i class="fas fa-user-circle"></i> My Profile</h1>
        
        <form action="${pageContext.request.contextPath}/user" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName" value="${sessionScope.user.fullName}" class="form-control">
            </div>
            
            <div class="form-group">
                <label>Email</label>
                <input type="email" value="${sessionScope.user.email}" disabled class="form-control">
            </div>
            
            <div class="form-group">
                <label>Phone</label>
                <input type="tel" name="phone" value="${sessionScope.user.phone}" class="form-control">
            </div>
            
            <div class="form-group">
                <label>Address</label>
                <textarea name="address" class="form-control">${sessionScope.user.address}</textarea>
            </div>
            
            <div class="form-group">
                <label>City</label>
                <input type="text" name="city" value="${sessionScope.user.city}" class="form-control">
            </div>
            
            <button type="submit" class="btn-primary">Update Profile</button>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-secondary">Back to Dashboard</a>
        </form>
    </div>
</body>
</html>