<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Donors - BloodLink Admin</title>
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
        }
        .logo { font-size: 1.5rem; font-weight: 700; }
        .logo i { margin-right: 10px; }
        .user-info { display: flex; align-items: center; gap: 20px; }
        .logout-btn { background: rgba(255,255,255,0.2); padding: 8px 16px; border-radius: 8px; color: white; text-decoration: none; }
        
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
        
        .page-header { margin-bottom: 25px; }
        .page-header h1 { font-size: 1.8rem; color: #333; }
        .page-header h1 i { color: #DC143C; margin-right: 10px; }
        
        .search-box {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .search-form { display: flex; gap: 15px; align-items: flex-end; flex-wrap: wrap; }
        .search-group { flex: 1; }
        .search-group label { display: block; margin-bottom: 5px; font-weight: 500; color: #555; }
        .search-group input, .search-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }
        .btn-search { background: #DC143C; color: white; padding: 10px 25px; border: none; border-radius: 8px; cursor: pointer; }
        
        .stats-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .stat-info h3 { font-size: 0.85rem; color: #666; margin-bottom: 5px; }
        .stat-number { font-size: 1.8rem; font-weight: 700; color: #DC143C; }
        .stat-icon { font-size: 2rem; color: #DC143C; opacity: 0.7; }
        
        .card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow-x: auto;
        }
        
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
        .data-table th { background: #f8f9fa; font-weight: 600; }
        .data-table tr:hover { background: #f8f9fa; }
        
        .blood-badge { background: #DC143C; color: white; padding: 4px 12px; border-radius: 20px; font-weight: bold; display: inline-block; font-size: 0.85rem; }
        .available { color: #28a745; font-weight: 600; }
        .unavailable { color: #dc3545; font-weight: 600; }
        
        .btn-sm { padding: 5px 12px; border-radius: 5px; font-size: 0.8rem; border: none; cursor: pointer; margin: 0 2px; }
        .btn-view { background: #17a2b8; color: white; }
        .btn-toggle { background: #ffc107; color: #333; }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background: white;
            border-radius: 12px;
            padding: 25px;
            width: 450px;
            max-width: 90%;
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .modal-header h3 { color: #DC143C; }
        .close-modal { cursor: pointer; font-size: 1.5rem; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 500; }
        .form-group p { padding: 8px; background: #f8f9fa; border-radius: 8px; }
        
        .alert { padding: 12px; border-radius: 8px; margin-bottom: 20px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        
        @media (max-width: 768px) {
            .sidebar { width: 70px; }
            .sidebar-item span { display: none; }
            .main-content { margin-left: 70px; }
            .stats-row { grid-template-columns: 1fr; }
            .search-form { flex-direction: column; }
        }
    </style>
</head>
<body>
    <div class="top-nav">
        <div class="logo"><i class="fas fa-tint"></i> BloodLink Admin</div>
        <div class="user-info">
            <span><i class="fas fa-user-shield"></i> ${sessionScope.user.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
    
    <div class="sidebar">
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin" class="sidebar-item"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a>
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-item"><i class="fas fa-users"></i> <span>Manage Users</span></a>
            <a href="${pageContext.request.contextPath}/admin/donors" class="sidebar-item active"><i class="fas fa-hand-holding-heart"></i> <span>Manage Donors</span></a>
            <a href="${pageContext.request.contextPath}/admin/requests" class="sidebar-item"><i class="fas fa-exclamation-triangle"></i> <span>Blood Requests</span></a>
            <a href="${pageContext.request.contextPath}/campaigns" class="sidebar-item"><i class="fas fa-calendar-alt"></i> <span>Campaigns</span></a>
            <a href="${pageContext.request.contextPath}/home" class="sidebar-item"><i class="fas fa-home"></i> <span>Back to Site</span></a>
        </div>
    </div>
    
    <div class="main-content">
        <div class="page-header">
            <h1><i class="fas fa-hand-holding-heart"></i> Manage Donors</h1>
        </div>
        
        <% if(request.getParameter("success") != null) { %>
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> Operation completed successfully!</div>
        <% } %>
        
        <div class="search-box">
            <form action="${pageContext.request.contextPath}/admin/donors" method="get" class="search-form">
                <div class="search-group"><label><i class="fas fa-search"></i> Search</label><input type="text" name="search" placeholder="Name, blood group or city..." value="${param.search}"></div>
                <div class="search-group"><label><i class="fas fa-tint"></i> Blood Group</label><select name="bloodGroup"><option value="">All</option><option value="A+">A+</option><option value="A-">A-</option><option value="B+">B+</option><option value="B-">B-</option><option value="O+">O+</option><option value="O-">O-</option><option value="AB+">AB+</option><option value="AB-">AB-</option></select></div>
                <div class="search-group"><label><i class="fas fa-circle"></i> Status</label><select name="status"><option value="">All</option><option value="available">Available</option><option value="unavailable">Unavailable</option></select></div>
                <button type="submit" class="btn-search"><i class="fas fa-search"></i> Search</button>
            </form>
        </div>
        
        <div class="stats-row">
            <div class="stat-card"><div class="stat-info"><h3>Total Donors</h3><div class="stat-number">${totalDonors}</div></div><i class="fas fa-users" style="font-size:2rem; color:#DC143C;"></i></div>
            <div class="stat-card"><div class="stat-info"><h3>Available</h3><div class="stat-number">${availableCount}</div></div><i class="fas fa-check-circle" style="font-size:2rem; color:#28a745;"></i></div>
            <div class="stat-card"><div class="stat-info"><h3>Unavailable</h3><div class="stat-number">${unavailableCount}</div></div><i class="fas fa-times-circle" style="font-size:2rem; color:#dc3545;"></i></div>
            <div class="stat-card"><div class="stat-info"><h3>Total Donations</h3><div class="stat-number">${totalDonations}</div></div><i class="fas fa-tint" style="font-size:2rem; color:#DC143C;"></i></div>
        </div>
        
        <div class="card">
            <table class="data-table">
                <thead><tr><th>ID</th><th>Name</th><th>Blood Group</th><th>Age</th><th>Gender</th><th>Weight</th><th>City</th><th>Donations</th><th>Last Donation</th><th>Status</th><th>Actions</th></tr></thead>
                <tbody>
                    <c:forEach items="${donors}" var="d">
                        <tr>
                            <td>${d.donorId}</td>
                            <td><strong>${d.fullName}</strong></td>
                            <td><span class="blood-badge">${d.bloodGroup}</span></td>
                            <td>${d.age}</td>
                            <td>${d.gender}</td>
                            <td>${d.weight} kg</td>
                            <td>${d.city}</td>
                            <td>${d.donationCount}</td>
                            <td>${d.lastDonationDate != null ? d.lastDonationDate : 'Never'}</td>
                            <td class="${d.isAvailable ? 'available' : 'unavailable'}"><i class="fas fa-circle"></i> ${d.isAvailable ? 'Available' : 'Unavailable'}</td>
                            <td><button class="btn-sm btn-view" onclick="viewDonor(${d.donorId})"><i class="fas fa-eye"></i></button><button class="btn-sm btn-toggle" onclick="toggleStatus(${d.donorId}, ${!d.isAvailable})"><i class="fas fa-exchange-alt"></i> Toggle</button></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty donors}"><tr><td colspan="11" style="text-align:center; padding:40px;">No donors found</td></c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- View Donor Modal -->
    <div id="viewModal" class="modal"><div class="modal-content"><div class="modal-header"><h3><i class="fas fa-user-circle"></i> Donor Details</h3><span class="close-modal" onclick="closeModal('viewModal')">&times;</span></div><div id="donorDetails"></div></div></div>
    
    <script>
        function viewDonor(id){ fetch('${pageContext.request.contextPath}/admin/api/donor?id='+id).then(r=>r.json()).then(d=>{ document.getElementById('donorDetails').innerHTML=`<div class="form-group"><label>Full Name:</label><p>${d.fullName}</p></div><div class="form-group"><label>Email:</label><p>${d.email}</p></div><div class="form-group"><label>Phone:</label><p>${d.phone}</p></div><div class="form-group"><label>Blood Group:</label><p>${d.bloodGroup}</p></div><div class="form-group"><label>Age:</label><p>${d.age}</p></div><div class="form-group"><label>Gender:</label><p>${d.gender}</p></div><div class="form-group"><label>Weight:</label><p>${d.weight} kg</p></div><div class="form-group"><label>City:</label><p>${d.city}</p></div><div class="form-group"><label>Donations:</label><p>${d.donationCount}</p></div><div class="form-group"><label>Last Donation:</label><p>${d.lastDonationDate || 'Never'}</p></div><div class="form-group"><label>Status:</label><p class="${d.isAvailable ? 'available' : 'unavailable'}">${d.isAvailable ? 'Available' : 'Unavailable'}</p></div><div class="form-group"><label>Medical Conditions:</label><p>${d.medicalConditions || 'None'}</p></div>`; document.getElementById('viewModal').style.display='flex'; }); }
        function toggleStatus(id, newStatus){ if(confirm('Change donor availability?')) window.location.href='${pageContext.request.contextPath}/admin/donors?action=toggle&donorId='+id+'&status='+newStatus; }
        function closeModal(id){ document.getElementById(id).style.display='none'; }
        window.onclick = function(e) { if(e.target.classList.contains('modal')) e.target.style.display='none'; }
    </script>
</body>
</html>