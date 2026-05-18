<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Poppins', sans-serif; background: #f4f6f9; }
        
        .top-nav {
            background: linear-gradient(135deg, #DC143C, #8B0000);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 100;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .logo { font-size: 1.5rem; font-weight: 700; }
        .logo i { margin-right: 10px; }
        .user-info { display: flex; align-items: center; gap: 20px; }
        .logout-btn { background: rgba(255,255,255,0.2); padding: 8px 16px; border-radius: 8px; color: white; text-decoration: none; transition: 0.3s; }
        .logout-btn:hover { background: rgba(255,255,255,0.3); }
        
        .sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            width: 260px;
            height: calc(100% - 60px);
            background: white;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
            overflow-y: auto;
        }
        .sidebar-menu { padding: 20px 0; }
        .sidebar-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 24px;
            color: #333;
            text-decoration: none;
            transition: 0.3s;
            margin: 4px 0;
        }
        .sidebar-item:hover { background: #FFE5E5; color: #DC143C; }
        .sidebar-item.active { background: #DC143C; color: white; }
        .sidebar-item i { width: 20px; }
        
        .main-content { margin-left: 260px; margin-top: 60px; padding: 30px; }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s;
        }
        .stat-card:hover { transform: translateY(-3px); box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .stat-info h3 { font-size: 0.85rem; color: #666; margin-bottom: 5px; }
        .stat-number { font-size: 2rem; font-weight: 700; color: #DC143C; }
        .stat-icon { font-size: 2.5rem; color: #DC143C; opacity: 0.7; }
        
        .card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .card h3 { margin-bottom: 15px; color: #333; display: flex; align-items: center; gap: 8px; }
        .card h3 i { color: #DC143C; }
        
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
        .data-table th { background: #f8f9fa; font-weight: 600; }
        .data-table tr:hover { background: #f8f9fa; }
        
        .badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 0.7rem; font-weight: 600; }
        .badge-admin { background: #DC143C; color: white; }
        .badge-donor { background: #28a745; color: white; }
        .badge-requester { background: #17a2b8; color: white; }
        .badge-critical { background: #dc3545; color: white; }
        .badge-urgent { background: #ffc107; color: #333; }
        .badge-normal { background: #28a745; color: white; }
        
        .btn-sm { padding: 5px 12px; border-radius: 5px; font-size: 0.8rem; border: none; cursor: pointer; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn-primary { background: #DC143C; color: white; padding: 8px 16px; border-radius: 6px; border: none; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn-primary:hover { background: #8B0000; }
        
        .quick-actions {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 10px;
        }
        .quick-btn {
            background: #f8f9fa;
            padding: 12px 20px;
            border-radius: 10px;
            text-decoration: none;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: 0.3s;
            border: 1px solid #eee;
        }
        .quick-btn:hover { background: #DC143C; color: white; transform: translateY(-2px); }
        .quick-btn i { font-size: 1.2rem; }
        
        .activity-list { list-style: none; }
        .activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        .activity-icon {
            width: 40px;
            height: 40px;
            background: #FFE5E5;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #DC143C;
        }
        .activity-detail { flex: 1; }
        .activity-title { font-weight: 500; margin-bottom: 5px; }
        .activity-time { font-size: 0.75rem; color: #999; }
        
        @media (max-width: 768px) {
            .sidebar { width: 70px; }
            .sidebar-item span { display: none; }
            .main-content { margin-left: 70px; }
            .stats-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <!-- Top Navigation -->
    <div class="top-nav">
        <div class="logo"><i class="fas fa-tint"></i> BloodLink Admin</div>
        <div class="user-info">
            <span><i class="fas fa-user-shield"></i> ${sessionScope.user.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
    
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin" class="sidebar-item ${param.section == null ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/manage-users" class="sidebar-item">
                <i class="fas fa-users"></i> <span>Manage Users</span>
            </a>
            <a href="${pageContext.request.contextPath}/manage-donors" class="sidebar-item">
                <i class="fas fa-hand-holding-heart"></i> <span>Manage Donors</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin?section=requests" class="sidebar-item">
                <i class="fas fa-exclamation-triangle"></i> <span>Blood Requests</span>
            </a>
            <a href="${pageContext.request.contextPath}/campaigns" class="sidebar-item">
                <i class="fas fa-calendar-alt"></i> <span>Campaigns</span>
            </a>
            <a href="${pageContext.request.contextPath}/home" class="sidebar-item">
                <i class="fas fa-home"></i> <span>Back to Site</span>
            </a>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info"><h3>Total Users</h3><div class="stat-number">${totalUsers != null ? totalUsers : '0'}</div></div>
                <div class="stat-icon"><i class="fas fa-users"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3>Total Donors</h3><div class="stat-number">${totalDonors != null ? totalDonors : '0'}</div></div>
                <div class="stat-icon"><i class="fas fa-hand-holding-heart"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3>Pending Requests</h3><div class="stat-number">${pendingRequests != null ? pendingRequests : '0'}</div></div>
                <div class="stat-icon"><i class="fas fa-tint"></i></div>
            </div>
            <div class="stat-card">
                <div class="stat-info"><h3>Active Campaigns</h3><div class="stat-number">${activeCampaigns != null ? activeCampaigns : '0'}</div></div>
                <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="card">
            <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/manage-users" class="quick-btn"><i class="fas fa-user-plus"></i> Add New User</a>
                <a href="${pageContext.request.contextPath}/manage-donors" class="quick-btn"><i class="fas fa-tint"></i> View Donors</a>
                <a href="${pageContext.request.contextPath}/admin?section=requests" class="quick-btn"><i class="fas fa-exclamation-circle"></i> Pending Requests</a>
                <a href="${pageContext.request.contextPath}/campaigns" class="quick-btn"><i class="fas fa-calendar-plus"></i> Create Campaign</a>
            </div>
        </div>
        
        <!-- Recent Users -->
        <div class="card">
            <h3><i class="fas fa-users"></i> Recent Users</h3>
            <table class="data-table">
                <thead><tr><th>ID</th><th>Full Name</th><th>Email</th><th>Type</th><th>Registered</th></tr></thead>
                <tbody>
                    <c:forEach items="${allUsers}" var="user" begin="0" end="4">
                        <tr>
                            <td>${user.userId}</td>
                            <td><strong>${user.fullName}</strong></td>
                            <td>${user.email}</td>
                            <td><span class="badge badge-${user.userType}">${user.userType}</span></td>
                            <td>${user.createdAt}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty allUsers}">
                        <tr><td colspan="5" style="text-align:center; padding:20px;">No users found</td></tr>
                    </c:if>
                </tbody>
            </table>
            <div style="margin-top: 15px; text-align: right;">
                <a href="${pageContext.request.contextPath}/manage-users" class="btn-primary">View All Users →</a>
            </div>
        </div>
        
        <!-- Recent Blood Requests -->
        <div class="card">
            <h3><i class="fas fa-exclamation-triangle"></i> Recent Blood Requests</h3>
            <table class="data-table">
                <thead><tr><th>Patient</th><th>Blood Group</th><th>Units</th><th>Hospital</th><th>Emergency</th><th>Date</th></tr></thead>
                <tbody>
                    <c:forEach items="${pendingRequestsList}" var="req" begin="0" end="4">
                        <tr>
                            <td>${req.patientName}</td>
                            <td><strong>${req.bloodGroup}</strong></td>
                            <td>${req.unitsNeeded}</td>
                            <td>${req.hospitalName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${req.emergencyLevel == 'Critical'}">
                                        <span class="badge badge-critical">Critical</span>
                                    </c:when>
                                    <c:when test="${req.emergencyLevel == 'Urgent'}">
                                        <span class="badge badge-urgent">Urgent</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-normal">Normal</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${req.requestDate}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pendingRequestsList}">
                        <tr><td colspan="6" style="text-align:center; padding:20px;">No pending requests</td></tr>
                    </c:if>
                </tbody>
            </table>
            <div style="margin-top: 15px; text-align: right;">
                <a href="${pageContext.request.contextPath}/admin?section=requests" class="btn-primary">View All Requests →</a>
            </div>
        </div>
        
        <!-- Upcoming Campaigns -->
        <div class="card">
            <h3><i class="fas fa-calendar-alt"></i> Upcoming Campaigns</h3>
            <c:forEach items="${upcomingCampaigns}" var="camp">
                <div style="padding: 12px 0; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <strong>${camp.title}</strong><br>
                        <small><i class="fas fa-map-marker-alt"></i> ${camp.location} | <i class="fas fa-calendar"></i> ${camp.campaignDate}</small>
                    </div>
                    <span class="badge" style="background: #17a2b8; color: white;">Upcoming</span>
                </div>
            </c:forEach>
            <c:if test="${empty upcomingCampaigns}">
                <p style="text-align:center; padding:20px;">No upcoming campaigns</p>
            </c:if>
            <div style="margin-top: 15px; text-align: right;">
                <a href="${pageContext.request.contextPath}/campaigns" class="btn-primary">View All Campaigns →</a>
            </div>
        </div>
        
        <!-- Recent Activity -->
        <div class="card">
            <h3><i class="fas fa-clock"></i> Recent Activity</h3>
            <ul class="activity-list">
                <li class="activity-item">
                    <div class="activity-icon"><i class="fas fa-user-plus"></i></div>
                    <div class="activity-detail">
                        <div class="activity-title">New user registered</div>
                        <div class="activity-time">Just now</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon"><i class="fas fa-tint"></i></div>
                    <div class="activity-detail">
                        <div class="activity-title">New blood request posted - Critical (A+)</div>
                        <div class="activity-time">15 minutes ago</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon"><i class="fas fa-hand-holding-heart"></i></div>
                    <div class="activity-detail">
                        <div class="activity-title">New donor registered - Blood Group O+</div>
                        <div class="activity-time">1 hour ago</div>
                    </div>
                </li>
                <li class="activity-item">
                    <div class="activity-icon"><i class="fas fa-check-circle"></i></div>
                    <div class="activity-detail">
                        <div class="activity-title">Blood request fulfilled</div>
                        <div class="activity-time">3 hours ago</div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</body>
</html>