<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .dashboard-wrapper { display: flex; min-height: calc(100vh - 70px); background: var(--gray-light); }
        .sidebar { width: 280px; background: white; box-shadow: var(--shadow-md); padding: 2rem 1.5rem; }
        .sidebar-header { text-align: center; padding-bottom: 1.5rem; border-bottom: 1px solid var(--gray); margin-bottom: 1.5rem; }
        .avatar { width: 80px; height: 80px; background: var(--blood-red); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; }
        .avatar i { font-size: 2.5rem; color: white; }
        .sidebar-menu { list-style: none; padding: 0; }
        .sidebar-menu li { margin-bottom: 0.5rem; }
        .sidebar-menu a { display: flex; align-items: center; gap: 12px; padding: 12px 16px; color: var(--text-dark); text-decoration: none; border-radius: 8px; transition: all 0.3s; }
        .sidebar-menu a:hover, .sidebar-menu a.active { background: var(--light-red); color: var(--blood-red); }
        .main-content { flex: 1; padding: 2rem; overflow-y: auto; }
        .welcome-card { background: linear-gradient(135deg, var(--blood-red), var(--dark-red)); color: white; padding: 2rem; border-radius: 12px; margin-bottom: 2rem; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        .stat-card { background: white; padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: var(--shadow-sm); }
        .stat-card i { font-size: 2rem; color: var(--blood-red); margin-bottom: 0.5rem; }
        .stat-value { font-size: 2rem; font-weight: 700; color: var(--blood-red); }
        .card { background: white; border-radius: 12px; padding: 1.5rem; margin-bottom: 1.5rem; box-shadow: var(--shadow-sm); }
        .card-title { font-size: 1.2rem; font-weight: 600; margin-bottom: 1rem; display: flex; align-items: center; gap: 10px; }
        .card-title i { color: var(--blood-red); }
        .badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }
        .badge-critical { background: #dc3545; color: white; }
        .badge-urgent { background: #ffc107; color: #333; }
        .badge-normal { background: #28a745; color: white; }
        .toggle-switch { position: relative; display: inline-block; width: 50px; height: 24px; }
        .toggle-switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: 0.3s; border-radius: 24px; }
        .slider:before { position: absolute; content: ""; height: 18px; width: 18px; left: 3px; bottom: 3px; background-color: white; transition: 0.3s; border-radius: 50%; }
        input:checked + .slider { background-color: var(--success-green); }
        input:checked + .slider:before { transform: translateX(26px); }
        .btn-sm { padding: 6px 12px; font-size: 0.85rem; }
        .flex-between { display: flex; justify-content: space-between; align-items: center; }
        @media (max-width: 768px) { .dashboard-wrapper { flex-direction: column; } .sidebar { width: 100%; } }
    </style>
</head>
<body>
    <nav class="navbar"><div class="nav-container"><a href="${pageContext.request.contextPath}/home" class="logo">Blood<span>Link</span></a>
        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/findDonor">Find Donor</a></li>
            <li><a href="${pageContext.request.contextPath}/requestBlood">Request Blood</a></li>
            <li><a href="${pageContext.request.contextPath}/campaigns">Campaigns</a></li>
            <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
            <li><a href="#" class="emergency-helpline"><i class="fas fa-phone-alt"></i> 104</a></li>
        </ul>
    </div></nav>
    <div class="dashboard-wrapper">
        <div class="sidebar">
            <div class="sidebar-header"><div class="avatar"><i class="fas fa-user-circle"></i></div><h3>${sessionScope.user.fullName}</h3><p><c:choose><c:when test="${sessionScope.user.userType == 'donor'}"><span class="badge" style="background: var(--blood-red); color: white;">Donor</span></c:when><c:otherwise><span class="badge" style="background: var(--info-blue); color: white;">Requester</span></c:otherwise></c:choose></p></div>
            <ul class="sidebar-menu"><li><a href="#" class="active" onclick="showSection('overview')"><i class="fas fa-tachometer-alt"></i> Overview</a></li><li><a href="#" onclick="showSection('requests')"><i class="fas fa-tint"></i> My Requests</a></li><c:if test="${sessionScope.user.userType == 'donor'}"><li><a href="#" onclick="showSection('donations')"><i class="fas fa-hand-holding-heart"></i> My Donations</a></li></c:if><li><a href="${pageContext.request.contextPath}/user"><i class="fas fa-user-edit"></i> Edit Profile</a></li><li><a href="${pageContext.request.contextPath}/requestBlood"><i class="fas fa-plus-circle"></i> New Request</a></li></ul>
        </div>
        <div class="main-content">
            <div id="overviewSection"><div class="welcome-card"><h2><i class="fas fa-hand-peace"></i> Welcome back, ${sessionScope.user.fullName}!</h2><p>Thank you for being part of BloodLink. Together we can save lives.</p></div>
            <div class="stats-grid"><div class="stat-card"><i class="fas fa-tint"></i><div class="stat-value">${donor != null ? donor.donationCount : '0'}</div><p>Total Donations</p></div>
            <div class="stat-card"><i class="fas fa-calendar"></i><div class="stat-value">${donor != null && donor.lastDonationDate != null ? donor.lastDonationDate : 'Never'}</div><p>Last Donation</p></div>
            <div class="stat-card"><i class="fas fa-clock"></i><div class="stat-value" style="font-size:1.2rem;">${eligible ? '✅ Eligible' : '⏳ Wait 90 days'}</div><p>Next Donation</p></div>
            <div class="stat-card"><i class="fas fa-file-alt"></i><div class="stat-value">${myRequests != null ? myRequests.size() : '0'}</div><p>My Requests</p></div></div>
            <c:if test="${sessionScope.user.userType == 'donor' && donor != null}"><div class="card"><div class="card-title"><i class="fas fa-user-md"></i><h3>Your Donor Information</h3></div><div class="flex-between"><div><p><strong>Blood Group:</strong> <span style="font-size:1.2rem; font-weight:bold; color:var(--blood-red);">${donor.bloodGroup}</span></p><p><strong>Age:</strong> ${donor.age} years</p><p><strong>Weight:</strong> ${donor.weight} kg</p></div><div><p><strong>Available for Donation:</strong></p><label class="toggle-switch"><input type="checkbox" id="availabilityToggle" ${donor.available ? 'checked' : ''} onchange="updateAvailability(this)"><span class="slider"></span></label></div></div></div></c:if>
            <div class="card"><div class="card-title"><i class="fas fa-exclamation-circle"></i><h3>Recent Blood Requests Near You</h3></div><div><p><i class="fas fa-tint"></i> A+ Blood needed at City Hospital - Critical</p><p><i class="fas fa-tint"></i> O+ Blood needed at Norvic Hospital - Urgent</p><p><i class="fas fa-tint"></i> B- Blood needed at Teaching Hospital - Normal</p></div><div class="mt-3"><a href="${pageContext.request.contextPath}/requestBlood" class="btn btn-primary btn-sm">Post New Request</a><a href="${pageContext.request.contextPath}/findDonor" class="btn btn-secondary btn-sm">Find Donors</a></div></div>
            <div class="card"><div class="card-title"><i class="fas fa-calendar-alt"></i><h3>Upcoming Campaigns in Your Area</h3></div><div><p><i class="fas fa-map-marker-alt"></i> Blood Donation Camp - City Hospital (Dec 15, 2024)</p><p><i class="fas fa-map-marker-alt"></i> Red Cross Blood Drive - Lalitpur (Dec 20, 2024)</p></div><div class="mt-3"><a href="${pageContext.request.contextPath}/campaigns" class="btn btn-primary btn-sm">View All Campaigns</a></div></div></div>
            <div id="requestsSection" style="display:none;"><div class="card"><div class="card-title"><i class="fas fa-list"></i><h3>My Blood Requests</h3></div><c:choose><c:when test="${not empty myRequests}"><c:forEach items="${myRequests}" var="req"><div class="request-item"><div><strong>${req.patientName}</strong> - ${req.bloodGroup} (${req.unitsNeeded} units)<br><small>${req.hospitalName} - ${req.requestDate}</small></div><div><span class="badge badge-${req.status}">${req.status}</span></div></div></c:forEach></c:when><c:otherwise><p>No requests found. <a href="${pageContext.request.contextPath}/requestBlood">Create your first request</a></p></c:otherwise></c:choose></div></div>
            <c:if test="${sessionScope.user.userType == 'donor'}"><div id="donationsSection" style="display:none;"><div class="card"><div class="card-title"><i class="fas fa-history"></i><h3>My Donation History</h3></div><div class="stats-grid"><div class="stat-card"><i class="fas fa-trophy"></i><div class="stat-value">${donor != null ? donor.donationCount : 0}</div><p>Total Donations</p></div><div class="stat-card"><i class="fas fa-heartbeat"></i><div class="stat-value">${donor != null ? donor.donationCount * 3 : 0}</div><p>Lives Saved</p></div><div class="stat-card"><i class="fas fa-calendar-check"></i><div class="stat-value" style="font-size:1rem;">${donor != null && donor.lastDonationDate != null ? donor.lastDonationDate : 'First-time donor'}</div><p>Last Donation</p></div></div><p><i class="fas fa-info-circle"></i> You can donate blood every 90 days. Thank you for saving lives!</p></div></div></c:if>
        </div>
    </div>
    <script>
        function showSection(section){
            document.getElementById('overviewSection').style.display='none';
            document.getElementById('requestsSection').style.display='none';
            if(document.getElementById('donationsSection')) document.getElementById('donationsSection').style.display='none';
            if(section==='overview') document.getElementById('overviewSection').style.display='block';
            else if(section==='requests') document.getElementById('requestsSection').style.display='block';
            else if(section==='donations') document.getElementById('donationsSection').style.display='block';
        }
        function updateAvailability(checkbox){
            const isAvailable=checkbox.checked;
            fetch('${pageContext.request.contextPath}/donor?action=updateStatus',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:'isAvailable='+isAvailable+'&action=updateStatus'})
            .then(response=>{if(!response.ok){alert('Failed to update availability');checkbox.checked=!isAvailable;}})
            .catch(error=>{alert('Error updating availability');checkbox.checked=!isAvailable;});
        }
        showSection('overview');
    </script>
</body>
</html>