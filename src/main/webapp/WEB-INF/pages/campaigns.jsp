<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Donation Campaigns - BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>.campaigns-container { max-width: 1200px; margin: 2rem auto; padding: 0 2rem; }
    .campaign-card { background: white; border-radius: 12px; overflow: hidden; box-shadow: var(--shadow-md); margin-bottom: 2rem; }
    .campaign-header { background: linear-gradient(135deg, var(--blood-red), var(--dark-red)); color: white; padding: 1.5rem; }
    .campaign-body { padding: 1.5rem; }
    .campaign-stats { display: flex; gap: 1.5rem; margin: 1rem 0; padding: 1rem 0; border-top: 1px solid var(--gray); border-bottom: 1px solid var(--gray); }
    .progress-bar { width: 100%; height: 30px; background: var(--gray); border-radius: 15px; overflow: hidden; margin: 1rem 0; }
    .progress-fill { height: 100%; background: linear-gradient(90deg, var(--blood-red), var(--dark-red)); display: flex; align-items: center; justify-content: center; color: white; font-size: 0.875rem; font-weight: bold; }
    .status-badge { display: inline-block; padding: 0.25rem 0.75rem; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }
    .status-upcoming { background: var(--info-blue); color: white; }
    .status-ongoing { background: var(--success-green); color: white; }
    .status-completed { background: var(--text-gray); color: white; }
    .register-btn { background: var(--blood-red); color: white; border: none; padding: 0.75rem 1.5rem; border-radius: 8px; cursor: pointer; font-weight: 600; }
    .create-campaign { background: white; padding: 2rem; border-radius: 12px; box-shadow: var(--shadow-md); margin-bottom: 2rem; }
    .campaign-form { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; }
    </style>
</head>
<body>
    <nav class="navbar"><div class="nav-container"><a href="${pageContext.request.contextPath}/home" class="logo">Blood<span>Link</span></a>
        <ul class="nav-menu"><li><a href="${pageContext.request.contextPath}/home">Home</a></li><li><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></li><li><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></li><li><a href="${pageContext.request.contextPath}/campaigns">Campaigns</a></li><li><a href="${pageContext.request.contextPath}/about">About Us</a></li><li><a href="${pageContext.request.contextPath}/contact">Contact</a></li><c:choose><c:when test="${not empty sessionScope.user}"><li><a href="${pageContext.request.contextPath}/logout">Logout</a></li></c:when><c:otherwise><li><a href="${pageContext.request.contextPath}/login">Login</a></li></c:otherwise></c:choose><li><a href="#" class="emergency-helpline"><i class="fas fa-phone-alt"></i> 104</a></li></ul>
    </div></nav>
    <div class="campaigns-container"><h1><i class="fas fa-calendar-alt"></i> Blood Donation Campaigns</h1><p>Join blood donation drives in your area and help save lives.</p>
    <c:if test="${sessionScope.user.userType == 'admin'}"><div class="create-campaign"><h3><i class="fas fa-plus-circle"></i> Create New Campaign</h3><form action="${pageContext.request.contextPath}/campaigns" method="post"><div class="campaign-form"><div class="form-group"><input type="text" name="title" placeholder="Campaign Title" required></div><div class="form-group"><input type="text" name="location" placeholder="Location" required></div><div class="form-group"><input type="date" name="campaignDate" required></div><div class="form-group"><input type="time" name="startTime" required></div><div class="form-group"><input type="time" name="endTime" required></div><div class="form-group"><input type="tel" name="contactNumber" placeholder="Contact Number" required></div><div class="form-group"><input type="number" name="targetUnits" placeholder="Target Units" required></div><div class="form-group"><textarea name="description" rows="2" placeholder="Campaign Description"></textarea></div></div><button type="submit" class="btn btn-primary">Create Campaign</button></form></div></c:if>
    <h2><i class="fas fa-clock"></i> Upcoming Campaigns</h2>
    <c:forEach items="${upcomingCampaigns}" var="campaign"><div class="campaign-card"><div class="campaign-header"><h3>${campaign.title}</h3><p><i class="fas fa-map-marker-alt"></i> ${campaign.location}</p></div><div class="campaign-body"><p>${campaign.description}</p><div class="campaign-stats"><div><i class="fas fa-calendar"></i> Date: ${campaign.campaignDate}</div><div><i class="fas fa-clock"></i> Time: ${campaign.startTime} - ${campaign.endTime}</div><div><i class="fas fa-bullseye"></i> Target: ${campaign.targetUnits} units</div></div><div class="progress-bar"><div class="progress-fill" style="width: ${campaign.targetUnits > 0 ? (campaign.collectedUnits * 100 / campaign.targetUnits) : 0}%">${campaign.collectedUnits}/${campaign.targetUnits} units</div></div><button class="register-btn" onclick="registerForCampaign(${campaign.campaignId})"><i class="fas fa-hand-holding-heart"></i> Register for Campaign</button></div></div></c:forEach>
    <h2><i class="fas fa-play-circle"></i> Ongoing Campaigns</h2>
    <c:forEach items="${ongoingCampaigns}" var="campaign"><div class="campaign-card"><div class="campaign-header" style="background: linear-gradient(135deg, var(--success-green), #1e7e34);"><h3>${campaign.title} <span class="status-badge status-ongoing">Ongoing</span></h3><p><i class="fas fa-map-marker-alt"></i> ${campaign.location}</p></div><div class="campaign-body"><p>${campaign.description}</p><div class="campaign-stats"><div><i class="fas fa-calendar"></i> Date: ${campaign.campaignDate}</div><div><i class="fas fa-clock"></i> Time: ${campaign.startTime} - ${campaign.endTime}</div><div><i class="fas fa-bullseye"></i> Target: ${campaign.targetUnits} units</div></div><div class="progress-bar"><div class="progress-fill" style="width: ${(campaign.collectedUnits / campaign.targetUnits) * 100}%">${campaign.collectedUnits}/${campaign.targetUnits} units</div></div><button class="register-btn" onclick="registerForCampaign(${campaign.campaignId})"><i class="fas fa-hand-holding-heart"></i> Participate Now</button></div></div></c:forEach>
    <h2><i class="fas fa-check-circle"></i> Past Campaigns</h2>
    <c:forEach items="${completedCampaigns}" var="campaign"><div class="campaign-card" style="opacity:0.8;"><div class="campaign-header" style="background: linear-gradient(135deg, var(--text-gray), #555);"><h3>${campaign.title} <span class="status-badge status-completed">Completed</span></h3><p><i class="fas fa-map-marker-alt"></i> ${campaign.location}</p></div><div class="campaign-body"><p>${campaign.description}</p><div class="campaign-stats"><div><i class="fas fa-calendar"></i> Date: ${campaign.campaignDate}</div><div><i class="fas fa-tint"></i> Units Collected: ${campaign.collectedUnits}</div><div><i class="fas fa-heartbeat"></i> Lives Impacted: ${campaign.collectedUnits * 3}</div></div></div></div></c:forEach></div>
    <script>function registerForCampaign(campaignId){ if(confirm('Would you like to register for this blood donation campaign?')){ alert('Registration successful! You will receive details via SMS/Email.'); } }</script>
</body>
</html>