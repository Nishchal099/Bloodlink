<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - BloodLink</title>
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
        
        .navbar {
            background: linear-gradient(135deg, #DC143C, #8B0000);
            color: white;
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        
        .register-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: calc(100vh - 70px);
        }
        
        .register-form {
            padding: 3rem;
            background: white;
        }
        
        .register-sidebar {
            background: linear-gradient(135deg, #DC143C, #8B0000);
            color: white;
            padding: 3rem;
            overflow-y: auto;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            font-family: inherit;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #DC143C;
        }
        
        .eligibility-card {
            background: rgba(255,255,255,0.1);
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        #donorFields {
            display: none;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        
        #donorFields h3 {
            color: #DC143C;
            margin-bottom: 1rem;
        }
        
        .btn-primary {
            background: #DC143C;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            font-weight: 600;
            margin-top: 1rem;
        }
        
        .btn-primary:hover {
            background: #8B0000;
        }
        
        .error-message {
            background: #fee;
            color: #c00;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        hr {
            margin: 1.5rem 0;
            border-color: rgba(255,255,255,0.2);
        }
        
        @media (max-width: 768px) {
            .register-container {
                grid-template-columns: 1fr;
            }
            .register-sidebar {
                display: none;
            }
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/home" class="logo">
                <i class="fas fa-tint"></i> BloodLink
            </a>
        </div>
    </div>

    <div class="register-container">
        <div class="register-form">
            <h2>Create an Account</h2>
            <p>Join BloodLink and help save lives</p>
            
            <% if(request.getParameter("error") != null) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> Registration failed! Please try again.
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName"><i class="fas fa-user"></i> Full Name *</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope"></i> Email Address *</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone"><i class="fas fa-phone"></i> Phone Number *</label>
                        <input type="tel" id="phone" name="phone" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="city"><i class="fas fa-city"></i> City *</label>
                        <select id="city" name="city" required>
                            <option value="">Select City</option>
                            <option value="Kathmandu">Kathmandu</option>
                            <option value="Lalitpur">Lalitpur</option>
                            <option value="Bhaktapur">Bhaktapur</option>
                            <option value="Pokhara">Pokhara</option>
                            <option value="Biratnagar">Biratnagar</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> Password *</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="userType"><i class="fas fa-user-tag"></i> Register as *</label>
                        <select id="userType" name="userType" required onchange="toggleDonorFields()">
                            <option value="requester">Requester (Need Blood)</option>
                            <option value="donor">Donor (Want to Donate Blood)</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address"><i class="fas fa-address-card"></i> Address</label>
                    <textarea id="address" name="address" rows="2" placeholder="Your full address"></textarea>
                </div>
                
                <!-- Donor Specific Fields -->
                <div id="donorFields">
                    <h3><i class="fas fa-hand-holding-heart"></i> Donor Information</h3>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="bloodGroup"><i class="fas fa-tint"></i> Blood Group *</label>
                            <select id="bloodGroup" name="bloodGroup">
                                <option value="">Select Blood Group</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="age"><i class="fas fa-calendar-alt"></i> Age</label>
                            <input type="number" id="age" name="age" min="18" max="65" placeholder="18-65 years">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="gender"><i class="fas fa-venus-mars"></i> Gender</label>
                            <select id="gender" name="gender">
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="weight"><i class="fas fa-weight-scale"></i> Weight (kg)</label>
                            <input type="number" id="weight" name="weight" step="0.1" min="45" placeholder="Minimum 45 kg">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="medicalConditions"><i class="fas fa-notes-medical"></i> Medical Conditions</label>
                        <textarea id="medicalConditions" name="medicalConditions" rows="2" placeholder="Any medical conditions? Leave empty if none"></textarea>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>
                        <input type="checkbox" id="terms" required> I agree to the <a href="#">Terms and Conditions</a>
                    </label>
                </div>
                
                <button type="submit" class="btn-primary">Register</button>
            </form>
        </div>
        
        <div class="register-sidebar">
            <i class="fas fa-tint" style="font-size: 3rem; margin-bottom: 1rem;"></i>
            <h3>Donor Eligibility Criteria</h3>
            <div class="eligibility-card">
                <i class="fas fa-check-circle"></i> Age between 18-65 years
            </div>
            <div class="eligibility-card">
                <i class="fas fa-check-circle"></i> Weight at least 45 kg
            </div>
            <div class="eligibility-card">
                <i class="fas fa-check-circle"></i> Good general health
            </div>
            <div class="eligibility-card">
                <i class="fas fa-check-circle"></i> No major illnesses
            </div>
            
            <hr>
            
            <h4>Benefits of Blood Donation</h4>
            <div class="eligibility-card">
                <i class="fas fa-heartbeat"></i> Saves up to 3 lives
            </div>
            <div class="eligibility-card">
                <i class="fas fa-chart-line"></i> Reduces heart disease risk
            </div>
            <div class="eligibility-card">
                <i class="fas fa-smile"></i> Free health checkup
            </div>
            
            <hr>
            
            <h4>Emergency Helpline</h4>
            <div class="eligibility-card">
                <i class="fas fa-phone-alt"></i> Call 104 for Emergency Blood
            </div>
        </div>
    </div>

    <script>
        function toggleDonorFields() {
            var userType = document.getElementById('userType').value;
            var donorFields = document.getElementById('donorFields');
            if (userType === 'donor') {
                donorFields.style.display = 'block';
                // Make donor fields required
                document.getElementById('bloodGroup').required = true;
                document.getElementById('age').required = true;
                document.getElementById('gender').required = true;
                document.getElementById('weight').required = true;
            } else {
                donorFields.style.display = 'none';
                // Remove required from donor fields
                document.getElementById('bloodGroup').required = false;
                document.getElementById('age').required = false;
                document.getElementById('gender').required = false;
                document.getElementById('weight').required = false;
            }
        }
        
        // Initialize on page load
        toggleDonorFields();
    </script>
</body>
</html>