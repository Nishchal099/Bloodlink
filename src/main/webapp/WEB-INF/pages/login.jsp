<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - BloodLink</title>
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
            background: linear-gradient(135deg, #DC143C, #8B0000);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .login-container {
            width: 900px;
            max-width: 90%;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            display: flex;
        }
        
        .login-form {
            flex: 1;
            padding: 50px;
            background: white;
        }
        
        .login-form h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }
        
        .login-form p {
            color: #666;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #DC143C;
            box-shadow: 0 0 5px rgba(220,20,60,0.3);
        }
        
        .checkbox-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .checkbox-group label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #666;
            cursor: pointer;
        }
        
        .checkbox-group a {
            color: #DC143C;
            text-decoration: none;
            font-size: 14px;
        }
        
        .btn-login {
            width: 100%;
            padding: 12px;
            background: #DC143C;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .btn-login:hover {
            background: #8B0000;
        }
        
        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        
        .register-link a {
            color: #DC143C;
            text-decoration: none;
            font-weight: 600;
        }
        
        .login-sidebar {
            flex: 1;
            background: linear-gradient(135deg, #DC143C, #8B0000);
            color: white;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .login-sidebar i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
        }
        
        .login-sidebar h2 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }
        
        .helpline {
            font-size: 3rem;
            font-weight: 800;
            margin: 0.5rem 0;
        }
        
        .divider {
            margin: 2rem 0;
            border-top: 1px solid rgba(255,255,255,0.2);
        }
        
        .fact {
            background: rgba(255,255,255,0.1);
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #dc3545;
        }
        
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }
            .login-sidebar {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Login Form -->
        <div class="login-form">
            <h2>Welcome Back!</h2>
            <p>Login to access your account</p>
            
            <!-- Success message after registration -->
            <% if(request.getParameter("registered") != null) { %>
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> Registration successful! Please login with your credentials.
                </div>
            <% } %>
            
            <!-- Error message for invalid login -->
            <% if(request.getParameter("error") != null) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> Invalid email or password. Please try again.
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>
                
                <div class="checkbox-group">
                    <label>
                        <input type="checkbox" name="remember"> Remember Me
                    </label>
                    <a href="#">Forgot Password?</a>
                </div>
                
                <button type="submit" class="btn-login">Login</button>
            </form>
            
            <div class="register-link">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
            </div>
        </div>
        
        <!-- Sidebar -->
        <div class="login-sidebar">
            <i class="fas fa-tint"></i>
            <h2>Emergency Helpline</h2>
            <div class="helpline">104</div>
            <p>24/7 Blood Donation Support</p>
            
            <div class="divider"></div>
            
            <h4>Did You Know?</h4>
            <div class="fact">
                <i class="fas fa-chart-line"></i>
                <p>Every 2 seconds, someone needs blood.</p>
            </div>
            <div class="fact">
                <i class="fas fa-heart"></i>
                <p>One donation can save up to 3 lives.</p>
            </div>
            <div class="fact">
                <i class="fas fa-clock"></i>
                <p>Blood can be donated every 90 days.</p>
            </div>
        </div>
    </div>
</body>
</html>