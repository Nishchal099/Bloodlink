<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>.contact-container { max-width: 1200px; margin: 2rem auto; padding: 0 2rem; }
    .contact-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; }
    .contact-info, .contact-form { background: white; padding: 2rem; border-radius: 12px; box-shadow: var(--shadow-md); }
    .info-card { display: flex; align-items: center; gap: 1rem; margin: 1.5rem 0; padding: 1rem; background: var(--gray-light); border-radius: 8px; }
    .info-card i { font-size: 2rem; color: var(--blood-red); }
    .emergency-box { background: linear-gradient(135deg, var(--blood-red), var(--dark-red)); color: white; padding: 2rem; border-radius: 12px; text-align: center; margin-top: 2rem; }
    .emergency-box h1 { font-size: 4rem; margin: 1rem 0; }
    .success-message { background: #d4edda; color: #155724; padding: 1rem; border-radius: 8px; margin-bottom: 1rem; }
    @media (max-width: 768px) { .contact-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <nav class="navbar"><div class="nav-container"><a href="${pageContext.request.contextPath}/home" class="logo">Blood<span>Link</span></a>
        <ul class="nav-menu"><li><a href="${pageContext.request.contextPath}/home">Home</a></li><li><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></li><li><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></li><li><a href="${pageContext.request.contextPath}/campaigns">Campaigns</a></li><li><a href="${pageContext.request.contextPath}/about">About Us</a></li><li><a href="${pageContext.request.contextPath}/contact">Contact</a></li><c:choose><c:when test="${not empty sessionScope.user}"><li><a href="${pageContext.request.contextPath}/logout">Logout</a></li></c:when><c:otherwise><li><a href="${pageContext.request.contextPath}/login">Login</a></li></c:otherwise></c:choose><li><a href="#" class="emergency-helpline"><i class="fas fa-phone-alt"></i> 104</a></li></ul>
    </div></nav>
    <div class="contact-container"><h1><i class="fas fa-envelope"></i> Contact Us</h1><p>Have questions? We're here to help. Reach out to us anytime.</p>
    <% if(request.getParameter("success") != null) { %><div class="success-message"><i class="fas fa-check-circle"></i> Message sent successfully! We'll get back to you soon.</div><% } %>
    <div class="contact-grid"><div class="contact-info"><h2><i class="fas fa-address-card"></i> Get in Touch</h2>
        <div class="info-card"><i class="fas fa-map-marker-alt"></i><div><h4>Our Location</h4><p>BloodLink Headquarters<br>Kathmandu, Nepal</p></div></div>
        <div class="info-card"><i class="fas fa-phone-alt"></i><div><h4>Phone Numbers</h4><p>Emergency: <strong>104</strong><br>Support: +977-1-1234567</p></div></div>
        <div class="info-card"><i class="fas fa-envelope"></i><div><h4>Email Addresses</h4><p>General: info@bloodlink.com<br>Support: support@bloodlink.com</p></div></div>
        <div class="info-card"><i class="fas fa-clock"></i><div><h4>Working Hours</h4><p>24/7 Emergency Support<br>Office Hours: 9 AM - 6 PM (Mon-Fri)</p></div></div></div>
        <div class="contact-form"><h2><i class="fas fa-paper-plane"></i> Send us a Message</h2>
        <form action="${pageContext.request.contextPath}/contact" method="post"><div class="form-group"><label for="name">Your Name *</label><input type="text" id="name" name="name" required></div>
        <div class="form-group"><label for="email">Email Address *</label><input type="email" id="email" name="email" required></div>
        <div class="form-group"><label for="subject">Subject *</label><input type="text" id="subject" name="subject" required></div>
        <div class="form-group"><label for="message">Message *</label><textarea id="message" name="message" rows="5" required></textarea></div>
        <button type="submit" class="btn btn-primary">Send Message</button></form></div></div>
    <div class="emergency-box"><i class="fas fa-ambulance" style="font-size:3rem;"></i><h2>Emergency? Need Blood Urgently?</h2><h1>Call: 104</h1><p>24/7 Blood Helpline - Immediate Assistance Available</p><a href="${pageContext.request.contextPath}/requestBlood" class="btn btn-primary" style="background:white; color:var(--blood-red); margin-top:1rem;">Post Emergency Request</a></div></div>
    <footer class="footer"><div class="footer-content"><div><h3>BloodLink</h3><p>Connecting donors with those in need.</p></div><div><h4>Quick Links</h4><p><a href="${pageContext.request.contextPath}/home">Home</a></p><p><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></p><p><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></p></div><div><h4>Legal</h4><p><a href="#">Privacy Policy</a></p><p><a href="#">Terms of Service</a></p></div></div><div class="copyright"><p>&copy; 2024 BloodLink. All rights reserved.</p></div></footer>
</body>
</html>