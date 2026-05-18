<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BloodLink - Donate Blood, Save Life</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .testimonial-section {
            padding: 4rem 2rem;
            background: var(--gray-light);
        }
        .testimonial-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .testimonial-card {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: var(--shadow-md);
            text-align: center;
        }
        .testimonial-card i {
            font-size: 3rem;
            color: var(--blood-red);
            margin-bottom: 1rem;
        }
        .progress-bar {
            width: 100%;
            height: 8px;
            background: var(--gray);
            border-radius: 4px;
            overflow: hidden;
            margin-top: 10px;
        }
        .progress-fill {
            height: 100%;
            background: var(--blood-red);
            border-radius: 4px;
            transition: width 0.3s ease;
        }
        
        /* Campaign Cards Section - Centered */
        .campaigns-section {
            padding: 4rem 2rem;
            background: var(--white);
        }
        .campaigns-section h2 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
            color: var(--text-dark);
        }
        .campaigns-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .campaign-card {
            background: var(--white);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .campaign-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }
        .campaign-image {
            background: linear-gradient(135deg, var(--blood-red), var(--dark-red));
            padding: 2rem;
            text-align: center;
            color: white;
        }
        .campaign-image i {
            font-size: 3rem;
            margin-bottom: 0.5rem;
        }
        .campaign-image h3 {
            font-size: 1.5rem;
            margin: 0.5rem 0;
        }
        .campaign-details {
            padding: 1.5rem;
        }
        .campaign-details p {
            margin: 0.75rem 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: var(--text-gray);
        }
        .campaign-details i {
            width: 20px;
            color: var(--blood-red);
        }
        .campaign-btn {
            display: inline-block;
            width: 100%;
            text-align: center;
            padding: 0.75rem;
            background: var(--blood-red);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            margin-top: 1rem;
            transition: background 0.3s;
            border: none;
            cursor: pointer;
        }
        .campaign-btn:hover {
            background: var(--dark-red);
        }
        
        .footer {
            background: var(--text-dark);
            color: var(--white);
            padding: 3rem 2rem 1rem;
            margin-top: 4rem;
        }
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }
        .footer a {
            color: var(--white);
            text-decoration: none;
        }
        .social-links a {
            margin-right: 1rem;
            font-size: 1.5rem;
        }
        .copyright {
            text-align: center;
            padding-top: 2rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/home" class="logo">Blood<span>Link</span></a>
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></li>
                <li><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></li>
                <li><a href="${pageContext.request.contextPath}/campaigns">Campaigns</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                    </c:otherwise>
                </c:choose>
                <li><a href="#" class="emergency-helpline"><i class="fas fa-phone-alt"></i> 104</a></li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <h1>Donate Blood, Save Life</h1>
        <p>Every drop counts. Join us in saving lives through blood donation.</p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/register?type=donor" class="btn btn-primary">Become a Donor</a>
            <a href="${pageContext.request.contextPath}/requestBlood" class="btn btn-secondary">Request Blood</a>
        </div>
    </section>

    <!-- Stats Section - Connected to Database -->
    <section class="stats">
        <div class="stat-card">
            <div class="stat-number">${totalDonors != null ? totalDonors : '0'}</div>
            <h3>Total Donors</h3>
            <i class="fas fa-users"></i>
        </div>
        <div class="stat-card">
            <div class="stat-number">${livesSaved != null ? livesSaved : '0'}</div>
            <h3>Lives Saved</h3>
            <i class="fas fa-heartbeat"></i>
        </div>
        <div class="stat-card">
            <div class="stat-number">${requestsFulfilled != null ? requestsFulfilled : '0'}</div>
            <h3>Requests Fulfilled</h3>
            <i class="fas fa-tint"></i>
        </div>
    </section>

    <!-- Emergency Banner -->
    <div class="emergency-banner">
        <i class="fas fa-exclamation-triangle"></i>
        <h3>Need Urgent Blood? Post an Emergency Request</h3>
        <p>24/7 Blood Donation Support - Helpline: 104</p>
        <a href="${pageContext.request.contextPath}/requestBlood" class="btn btn-primary" style="margin-top: 10px;">Post Emergency Request</a>
    </div>

    <!-- Blood Groups Availability -->
    <section class="blood-groups">
        <h2 style="text-align: center; margin-bottom: 2rem;">Blood Groups Availability</h2>
        <div class="blood-grid">
            <div style="text-align: center;">
                <div class="blood-badge blood-a-positive">A+</div>
                <div class="progress-bar"><div class="progress-fill" style="width: 75%"></div></div>
                <span>75% Available</span>
            </div>
            <div style="text-align: center;">
                <div class="blood-badge blood-a-negative">A-</div>
                <div class="progress-bar"><div class="progress-fill" style="width: 45%"></div></div>
                <span>45% Available</span>
            </div>
            <div style="text-align: center;">
                <div class="blood-badge blood-b-positive">B+</div>
                <div class="progress-bar"><div class="progress-fill" style="width: 65%"></div></div>
                <span>65% Available</span>
            </div>
            <div style="text-align: center;">
                <div class="blood-badge blood-b-negative">B-</div>
                <div class="progress-bar"><div class="progress-fill" style="width: 35%"></div></div>
                <span>35% Available</span>
            </div>
            <div style="text-align: center;">
                <div class="blood-badge blood-o-positive">O+</div>
                <div class="progress-bar"><div class="progress-fill" style="width: 85%"></div></div>
                <span>85% Available</span>
            </div>
            <div style="text-align: center;">
                <div class="blood-badge blood-o-negative">O-</div>
                <div class="progress-bar"><div class="progress-fill" style="width: 25%"></div></div>
                <span>25% Available</span>
            </div>
            <div style="text-align: center;">
                <div class="blood-badge blood-ab-positive">AB+</div>
                <div class="progress-bar"><div class="progress-fill" style="width: 55%"></div></div>
                <span>55% Available</span>
            </div>
            <div style="text-align: center;">
                <div class="blood-badge blood-ab-negative">AB-</div>
                <div class="progress-bar"><div class="progress-fill" style="width: 15%"></div></div>
                <span>15% Available</span>
            </div>
        </div>
    </section>

    <!-- Upcoming Campaigns Section - CENTERED -->
    <section class="campaigns-section">
        <h2><i class="fas fa-calendar-alt"></i> Upcoming Donation Campaigns</h2>
        <div class="campaigns-grid">
            <c:forEach items="${upcomingCampaigns}" var="campaign">
                <div class="campaign-card">
                    <div class="campaign-image">
                        <i class="fas fa-hospital-user"></i>
                        <h3>${campaign.title}</h3>
                    </div>
                    <div class="campaign-details">
                        <p><i class="fas fa-calendar"></i> ${campaign.campaignDate}</p>
                        <p><i class="fas fa-map-marker-alt"></i> ${campaign.location}</p>
                        <p><i class="fas fa-clock"></i> ${campaign.startTime} - ${campaign.endTime}</p>
                        <a href="${pageContext.request.contextPath}/campaigns" class="campaign-btn">Join Campaign</a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty upcomingCampaigns}">
                <div class="campaign-card">
                    <div class="campaign-image">
                        <i class="fas fa-calendar-alt"></i>
                        <h3>No Upcoming Campaigns</h3>
                    </div>
                    <div class="campaign-details">
                        <p>Check back later for upcoming blood donation campaigns in your area.</p>
                    </div>
                </div>
            </c:if>
        </div>
    </section>

    <!-- Testimonials -->
    <section class="testimonial-section">
        <h2 style="text-align: center; margin-bottom: 2rem;">What People Say</h2>
        <div class="testimonial-grid">
            <div class="testimonial-card">
                <i class="fas fa-quote-left"></i>
                <p>"BloodLink helped me find a donor for my father in just 2 hours. Truly a life-saving platform!"</p>
                <h4>- Rajesh K.</h4>
                <p>Patient's Family</p>
            </div>
            <div class="testimonial-card">
                <i class="fas fa-quote-left"></i>
                <p>"I've been a regular donor for 3 years. BloodLink makes it easy to connect with those in need."</p>
                <h4>- Sita G.</h4>
                <p>Donor</p>
            </div>
            <div class="testimonial-card">
                <i class="fas fa-quote-left"></i>
                <p>"As a hospital administrator, this platform has been invaluable for emergency blood requests."</p>
                <h4>- Dr. Sharma</h4>
                <p>Hospital Admin</p>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div>
                <h3>BloodLink</h3>
                <p>Connecting donors with those in need.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div>
                <h4>Quick Links</h4>
                <p><a href="${pageContext.request.contextPath}/home">Home</a></p>
                <p><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></p>
                <p><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></p>
                <p><a href="${pageContext.request.contextPath}/campaigns">Campaigns</a></p>
            </div>
            <div>
                <h4>Contact Info</h4>
                <p><i class="fas fa-phone"></i> Emergency: 104</p>
                <p><i class="fas fa-envelope"></i> info@bloodlink.com</p>
                <p><i class="fas fa-map-marker-alt"></i> Kathmandu, Nepal</p>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2024 BloodLink. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>