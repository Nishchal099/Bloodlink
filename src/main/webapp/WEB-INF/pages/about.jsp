<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>.about-container { max-width: 1200px; margin: 2rem auto; padding: 0 2rem; }
    .hero-section { background: linear-gradient(135deg, #DC143C, #8B0000); color: white; text-align: center; padding: 3rem; border-radius: 12px; margin-bottom: 2rem; }
    .hero-section h1 { font-size: 2.5rem; margin-bottom: 1rem; }
    .mission-box { text-align: center; padding: 2rem; background: #f5f5f5; border-radius: 12px; margin-bottom: 2rem; }
    .values-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin: 2rem 0; }
    .value-card { background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    .value-card i { font-size: 2.5rem; color: #DC143C; margin-bottom: 1rem; }
    .stats-section { background: #2D3748; color: white; padding: 2rem; border-radius: 12px; text-align: center; margin-top: 2rem; }
    .stats-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 2rem; margin-top: 1.5rem; }
    .stat-number { font-size: 2rem; font-weight: bold; color: #DC143C; }
    @media (max-width: 768px) { .stats-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <nav class="navbar"><div class="nav-container"><a href="${pageContext.request.contextPath}/home" class="logo">Blood<span>Link</span></a>
        <ul class="nav-menu"><li><a href="${pageContext.request.contextPath}/home">Home</a></li><li><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></li><li><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></li><li><a href="${pageContext.request.contextPath}/campaigns">Campaigns</a></li><li><a href="${pageContext.request.contextPath}/about">About Us</a></li><li><a href="${pageContext.request.contextPath}/contact">Contact</a></li><c:choose><c:when test="${not empty sessionScope.user}"><li><a href="${pageContext.request.contextPath}/logout">Logout</a></li></c:when><c:otherwise><li><a href="${pageContext.request.contextPath}/login">Login</a></li></c:otherwise></c:choose><li><a href="#" class="emergency-helpline"><i class="fas fa-phone-alt"></i> 104</a></li></ul>
    </div></nav>
    <div class="about-container"><div class="hero-section"><h1>About BloodLink</h1><p>Donate Blood, Save Life</p></div>
    <div class="mission-box"><i class="fas fa-quote-left" style="font-size:2rem; color:#DC143C;"></i><h2>Our Mission</h2><p>To create a reliable platform that connects blood donors with recipients instantly during emergencies, ensuring no life is lost due to lack of blood.</p></div>
    <div class="values-grid"><div class="value-card"><i class="fas fa-heartbeat"></i><h3>Save Lives</h3><p>One donation can save up to 3 lives</p></div><div class="value-card"><i class="fas fa-bolt"></i><h3>Fast Response</h3><p>Emergency requests notified instantly</p></div><div class="value-card"><i class="fas fa-shield-alt"></i><h3>Verified Donors</h3><p>All donors are verified</p></div><div class="value-card"><i class="fas fa-map-marked-alt"></i><h3>Location Based</h3><p>Find donors near you</p></div><div class="value-card"><i class="fas fa-trophy"></i><h3>Recognition</h3><p>Regular donors are recognized</p></div><div class="value-card"><i class="fas fa-clock"></i><h3>24/7 Service</h3><p>Emergency helpline always available</p></div></div>
    <div class="stats-section"><h2>Our Impact</h2><div class="stats-grid"><div><div class="stat-number">2,500+</div><p>Registered Donors</p></div><div><div class="stat-number">1,200+</div><p>Lives Saved</p></div><div><div class="stat-number">50+</div><p>Blood Camps</p></div></div></div></div>
    <footer class="footer"><div class="footer-content"><div><h3>BloodLink</h3><p>Connecting donors with those in need.</p></div><div><h4>Quick Links</h4><p><a href="${pageContext.request.contextPath}/home">Home</a></p><p><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></p><p><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></p></div><div><h4>Contact</h4><p><i class="fas fa-phone"></i> Emergency: 104</p><p><i class="fas fa-envelope"></i> info@bloodlink.com</p></div></div><div class="copyright"><p>&copy; 2024 BloodLink. All rights reserved.</p></div></footer>
</body>
</html>