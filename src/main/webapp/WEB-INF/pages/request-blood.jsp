<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Blood - BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
        }
        
        /* Navbar */
        .navbar {
            background: linear-gradient(135deg, #DC143C, #8B0000);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
        }
        
        .logo i {
            margin-right: 10px;
        }
        
        .nav-menu {
            display: flex;
            list-style: none;
            gap: 20px;
        }
        
        .nav-menu a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
            transition: 0.3s;
        }
        
        .nav-menu a:hover {
            background: rgba(255,255,255,0.2);
        }
        
        .emergency-helpline {
            background: #ffc107;
            color: #333 !important;
            font-weight: bold;
        }
        
        /* Container */
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        /* Form Card */
        .form-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        
        .form-card h1 {
            color: #DC143C;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-card h1 i {
            font-size: 1.8rem;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        /* Form Groups */
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        
        .form-group label i {
            color: #DC143C;
            width: 20px;
            margin-right: 8px;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            font-family: inherit;
            transition: 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #DC143C;
            box-shadow: 0 0 0 3px rgba(220,20,60,0.1);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        /* Emergency Level */
        .emergency-level {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }
        
        .emergency-option {
            flex: 1;
            padding: 15px;
            text-align: center;
            border: 2px solid #ddd;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .emergency-option i {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }
        
        .emergency-option h4 {
            margin-bottom: 5px;
        }
        
        .emergency-option small {
            font-size: 0.7rem;
        }
        
        .emergency-option.critical {
            background: #fff0f0;
            border-color: #dc3545;
        }
        
        .emergency-option.urgent {
            background: #fff3e0;
            border-color: #ffc107;
        }
        
        .emergency-option.normal {
            background: #e8f5e9;
            border-color: #28a745;
        }
        
        .emergency-option.selected {
            border-width: 3px;
            transform: scale(1.02);
        }
        
        .emergency-option.critical.selected {
            background: #dc3545;
            color: white;
        }
        
        .emergency-option.urgent.selected {
            background: #ffc107;
            color: #333;
        }
        
        .emergency-option.normal.selected {
            background: #28a745;
            color: white;
        }
        
        /* Buttons */
        .btn-primary {
            background: #DC143C;
            color: white;
            padding: 14px 28px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: 0.3s;
        }
        
        .btn-primary:hover {
            background: #8B0000;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        /* Alert Messages */
        .alert-success {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #dc3545;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success i, .alert-error i {
            font-size: 1.2rem;
        }
        
        /* Donor List */
        .donor-list {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .donor-list h3 {
            margin-bottom: 15px;
            color: #DC143C;
        }
        
        .donor-item {
            background: #f8f9fa;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        /* Footer */
        .footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 50px;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            .emergency-level {
                flex-direction: column;
            }
            .nav-menu {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="logo">
            <i class="fas fa-tint"></i> BloodLink
        </a>
        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></li>
            <li><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></li>
            <li><a href="${pageContext.request.contextPath}/campaigns">Campaigns</a></li>
            <li><a href="${pageContext.request.contextPath}/about">About</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                </c:otherwise>
            </c:choose>
            <li><a href="#" class="emergency-helpline"><i class="fas fa-phone-alt"></i> 104</a></li>
        </ul>
    </div>
    
    <!-- Main Content -->
    <div class="container">
        <div class="form-card">
            <h1><i class="fas fa-tint"></i> Request Blood</h1>
            <p class="subtitle">Fill out this form to post a blood request. Donors in your area will be notified.</p>
            
            <!-- Success Message -->
            <% if(request.getParameter("success") != null) { %>
                <div class="alert-success">
                    <i class="fas fa-check-circle"></i>
                    <div>
                        <strong>Success!</strong> Your blood request has been posted successfully. Donors will be notified shortly.
                    </div>
                </div>
            <% } %>
            
            <!-- Error Message -->
            <% if(request.getParameter("error") != null) { %>
                <div class="alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <div>
                        <strong>Error!</strong> Failed to post request. Please try again or contact support.
                    </div>
                </div>
            <% } %>
            
            <!-- Request Form -->
            <form id="requestForm" action="${pageContext.request.contextPath}/requestBlood" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="patientName"><i class="fas fa-user-injured"></i> Patient Name *</label>
                        <input type="text" id="patientName" name="patientName" placeholder="Enter patient's full name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="bloodGroup"><i class="fas fa-tint"></i> Blood Group Required *</label>
                        <select id="bloodGroup" name="bloodGroup" required>
                            <option value="">Select Blood Group</option>
                            <option value="A+">A Positive (A+)</option>
                            <option value="A-">A Negative (A-)</option>
                            <option value="B+">B Positive (B+)</option>
                            <option value="B-">B Negative (B-)</option>
                            <option value="O+">O Positive (O+)</option>
                            <option value="O-">O Negative (O-)</option>
                            <option value="AB+">AB Positive (AB+)</option>
                            <option value="AB-">AB Negative (AB-)</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="unitsNeeded"><i class="fas fa-syringe"></i> Units Needed *</label>
                        <input type="number" id="unitsNeeded" name="unitsNeeded" min="1" max="10" value="1" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="hospitalName"><i class="fas fa-hospital"></i> Hospital Name *</label>
                        <input type="text" id="hospitalName" name="hospitalName" placeholder="Enter hospital name" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="hospitalAddress"><i class="fas fa-location-dot"></i> Hospital Address *</label>
                    <textarea id="hospitalAddress" name="hospitalAddress" rows="2" placeholder="Enter complete hospital address" required></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="contactPerson"><i class="fas fa-user"></i> Contact Person *</label>
                        <input type="text" id="contactPerson" name="contactPerson" placeholder="Name of contact person" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="contactPhone"><i class="fas fa-phone"></i> Contact Phone *</label>
                        <input type="tel" id="contactPhone" name="contactPhone" placeholder="Contact phone number" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-exclamation-triangle"></i> Emergency Level *</label>
                    <div class="emergency-level">
                        <div class="emergency-option critical" onclick="selectEmergency('Critical')">
                            <i class="fas fa-skull-crosswalk"></i>
                            <h4>Critical</h4>
                            <small>Emergency - Need immediately</small>
                        </div>
                        <div class="emergency-option urgent" onclick="selectEmergency('Urgent')">
                            <i class="fas fa-clock"></i>
                            <h4>Urgent</h4>
                            <small>Within 24 hours</small>
                        </div>
                        <div class="emergency-option normal" onclick="selectEmergency('Normal')">
                            <i class="fas fa-calendar-day"></i>
                            <h4>Normal</h4>
                            <small>Within 3-5 days</small>
                        </div>
                    </div>
                    <input type="hidden" id="emergencyLevel" name="emergencyLevel" value="Normal">
                </div>
                
                <div class="form-group">
                    <label for="additionalNotes"><i class="fas fa-notes-medical"></i> Additional Notes</label>
                    <textarea id="additionalNotes" name="additionalNotes" rows="3" placeholder="Any special instructions or requirements (e.g., medical conditions, specific time, etc.)"></textarea>
                </div>
                
                <button type="submit" class="btn-primary">
                    <i class="fas fa-paper-plane"></i> Post Blood Request
                </button>
            </form>
            
            <!-- Available Donors Section (optional) -->
            <div class="donor-list" id="donorList" style="display: none;">
                <h3><i class="fas fa-users"></i> Available Donors</h3>
                <div id="availableDonors"></div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 BloodLink - Blood Donation Management System | Emergency Helpline: 104</p>
    </div>
    
    <script>
        let selectedEmergency = 'Normal';
        
        function selectEmergency(level) {
            selectedEmergency = level;
            document.getElementById('emergencyLevel').value = level;
            
            // Update UI
            document.querySelectorAll('.emergency-option').forEach(opt => {
                opt.classList.remove('selected');
            });
            document.querySelector(`.emergency-option.${level.toLowerCase()}`).classList.add('selected');
        }
        
        function checkAvailableDonors() {
            const bloodGroup = document.getElementById('bloodGroup').value;
            if (bloodGroup) {
                fetch('${pageContext.request.contextPath}/findDonor?bloodGroup=' + bloodGroup)
                    .then(response => response.text())
                    .then(html => {
                        document.getElementById('donorList').style.display = 'block';
                    })
                    .catch(error => console.error('Error:', error));
            }
        }
        
        // Set default emergency selection
        document.querySelector('.emergency-option.normal').classList.add('selected');
        
        // Auto-hide success/error messages after 5 seconds
        setTimeout(() => {
            const successMsg = document.querySelector('.alert-success');
            const errorMsg = document.querySelector('.alert-error');
            if (successMsg) setTimeout(() => successMsg.style.display = 'none', 5000);
            if (errorMsg) setTimeout(() => errorMsg.style.display = 'none', 5000);
        }, 100);
    </script>
</body>
</html>