<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Find Donor - BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background: linear-gradient(135deg, #DC143C, #8B0000);
            padding: 15px 30px;
            color: white;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .search-box {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .donor-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .blood-badge {
            background: #DC143C;
            color: white;
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
        }
        .btn {
            background: #DC143C;
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        select, button {
            padding: 8px 15px;
            margin: 5px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2><i class="fas fa-tint"></i> BloodLink - Find Donor</h2>
    </div>
    
    <div class="container">
        <h1>Find Blood Donors</h1>
        
        <div class="search-box">
            <form action="${pageContext.request.contextPath}/findDonor" method="get">
                <label>Blood Group:</label>
                <select name="bloodGroup">
                    <option value="">All</option>
                    <option value="A+">A+</option>
                    <option value="A-">A-</option>
                    <option value="B+">B+</option>
                    <option value="B-">B-</option>
                    <option value="O+">O+</option>
                    <option value="O-">O-</option>
                    <option value="AB+">AB+</option>
                    <option value="AB-">AB-</option>
                </select>
                <button type="submit" class="btn">Search</button>
            </form>
        </div>
        
        <c:if test="${not empty donors}">
            <h3>Found ${donors.size()} donor(s)</h3>
            <c:forEach items="${donors}" var="donor">
                <div class="donor-card">
                    <h3>${donor.fullName}</h3>
                    <p><span class="blood-badge">${donor.bloodGroup}</span></p>
                    <p>📍 ${donor.city}</p>
                    <p>📞 ${donor.phone}</p>
                    <p>🩸 Donations: ${donor.donationCount}</p>
                </div>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty donors}">
            <p>No donors found. Try a different blood group.</p>
        </c:if>
    </div>
</body>
</html>