<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - BloodLink Admin</title>
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
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }
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
        .btn-add { background: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; }
        
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
        
        .badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }
        .badge-admin { background: #DC143C; color: white; }
        .badge-donor { background: #28a745; color: white; }
        .badge-requester { background: #17a2b8; color: white; }
        
        .btn-sm { padding: 5px 12px; border-radius: 5px; font-size: 0.8rem; border: none; cursor: pointer; margin: 0 2px; }
        .btn-view { background: #17a2b8; color: white; }
        .btn-edit { background: #ffc107; color: #333; }
        .btn-delete { background: #dc3545; color: white; }
        
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
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; }
        .btn-modal { padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; margin-right: 10px; }
        .btn-save { background: #28a745; color: white; }
        .btn-cancel { background: #6c757d; color: white; }
        
        .alert { padding: 12px; border-radius: 8px; margin-bottom: 20px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        
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
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-item active"><i class="fas fa-users"></i> <span>Manage Users</span></a>
            <a href="${pageContext.request.contextPath}/admin/donors" class="sidebar-item"><i class="fas fa-hand-holding-heart"></i> <span>Manage Donors</span></a>
            <a href="${pageContext.request.contextPath}/admin/requests" class="sidebar-item"><i class="fas fa-exclamation-triangle"></i> <span>Blood Requests</span></a>
            <a href="${pageContext.request.contextPath}/campaigns" class="sidebar-item"><i class="fas fa-calendar-alt"></i> <span>Campaigns</span></a>
            <a href="${pageContext.request.contextPath}/home" class="sidebar-item"><i class="fas fa-home"></i> <span>Back to Site</span></a>
        </div>
    </div>
    
    <div class="main-content">
        <div class="page-header">
            <h1><i class="fas fa-users"></i> Manage Users</h1>
            <button class="btn-add" onclick="showAddModal()"><i class="fas fa-plus"></i> Add New User</button>
        </div>
        
        <% if(request.getParameter("success") != null) { %>
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> Operation completed successfully!</div>
        <% } %>
        
        <div class="search-box">
            <form action="${pageContext.request.contextPath}/admin/users" method="get" class="search-form">
                <div class="search-group"><label><i class="fas fa-search"></i> Search</label><input type="text" name="search" placeholder="Name or email..." value="${param.search}"></div>
                <div class="search-group"><label><i class="fas fa-filter"></i> User Type</label>
                    <select name="userType"><option value="">All</option><option value="admin" ${param.userType == 'admin' ? 'selected' : ''}>Admin</option><option value="donor" ${param.userType == 'donor' ? 'selected' : ''}>Donor</option><option value="requester" ${param.userType == 'requester' ? 'selected' : ''}>Requester</option></select>
                </div>
                <button type="submit" class="btn-search"><i class="fas fa-search"></i> Search</button>
            </form>
        </div>
        
        <div class="stats-row">
            <div class="stat-card"><div class="stat-info"><h3>Total Users</h3><div class="stat-number">${totalUsers}</div></div><i class="fas fa-users" style="font-size:2rem; color:#DC143C;"></i></div>
            <div class="stat-card"><div class="stat-info"><h3>Admins</h3><div class="stat-number">${adminCount}</div></div><i class="fas fa-user-shield" style="font-size:2rem; color:#DC143C;"></i></div>
            <div class="stat-card"><div class="stat-info"><h3>Donors</h3><div class="stat-number">${donorCount}</div></div><i class="fas fa-hand-holding-heart" style="font-size:2rem; color:#28a745;"></i></div>
            <div class="stat-card"><div class="stat-info"><h3>Requesters</h3><div class="stat-number">${requesterCount}</div></div><i class="fas fa-tint" style="font-size:2rem; color:#17a2b8;"></i></div>
        </div>
        
        <div class="card">
            <table class="data-table">
                <thead><tr><th>ID</th><th>Full Name</th><th>Email</th><th>Phone</th><th>City</th><th>Type</th><th>Registered</th><th>Actions</th></tr></thead>
                <tbody>
                    <c:forEach items="${users}" var="user">
                        <tr>
                            <td>${user.userId}</td>
                            <td><strong>${user.fullName}</strong></td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>${user.city}</td>
                            <td><span class="badge badge-${user.userType}">${user.userType}</span></td>
                            <td>${user.createdAt}</td>
                            <td>
                                <button class="btn-sm btn-view" onclick="viewUser(${user.userId})"><i class="fas fa-eye"></i></button>
                                <button class="btn-sm btn-edit" onclick="editUser(${user.userId})"><i class="fas fa-edit"></i></button>
                                <c:if test="${user.userType != 'admin'}">
                                    <button class="btn-sm btn-delete" onclick="deleteUser(${user.userId})"><i class="fas fa-trash"></i></button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}"><tr><td colspan="8" style="text-align:center; padding:40px;">No users found</td></c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- View Modal -->
    <div id="viewModal" class="modal"><div class="modal-content"><div class="modal-header"><h3><i class="fas fa-user-circle"></i> User Details</h3><span class="close-modal" onclick="closeModal('viewModal')">&times;</span></div><div id="viewUserDetails"></div></div></div>
    
    <!-- Edit Modal -->
    <div id="editModal" class="modal"><div class="modal-content"><div class="modal-header"><h3><i class="fas fa-edit"></i> Edit User</h3><span class="close-modal" onclick="closeModal('editModal')">&times;</span></div>
        <form action="${pageContext.request.contextPath}/admin/users" method="post"><input type="hidden" name="action" value="update"><input type="hidden" name="userId" id="editUserId">
            <div class="form-group"><label>Full Name</label><input type="text" name="fullName" id="editFullName" required></div>
            <div class="form-group"><label>Email</label><input type="email" name="email" id="editEmail" required></div>
            <div class="form-group"><label>Phone</label><input type="tel" name="phone" id="editPhone" required></div>
            <div class="form-group"><label>City</label><input type="text" name="city" id="editCity" required></div>
            <div class="form-group"><label>User Type</label><select name="userType" id="editUserType"><option value="donor">Donor</option><option value="requester">Requester</option><option value="admin">Admin</option></select></div>
            <button type="submit" class="btn-modal btn-save">Save Changes</button><button type="button" class="btn-modal btn-cancel" onclick="closeModal('editModal')">Cancel</button>
        </form>
    </div></div>
    
    <!-- Add Modal -->
    <div id="addModal" class="modal"><div class="modal-content"><div class="modal-header"><h3><i class="fas fa-user-plus"></i> Add New User</h3><span class="close-modal" onclick="closeModal('addModal')">&times;</span></div>
        <form action="${pageContext.request.contextPath}/admin/users" method="post"><input type="hidden" name="action" value="add">
            <div class="form-group"><label>Full Name *</label><input type="text" name="fullName" required></div>
            <div class="form-group"><label>Email *</label><input type="email" name="email" required></div>
            <div class="form-group"><label>Password *</label><input type="password" name="password" required></div>
            <div class="form-group"><label>Phone *</label><input type="tel" name="phone" required></div>
            <div class="form-group"><label>City *</label><input type="text" name="city" required></div>
            <div class="form-group"><label>User Type *</label><select name="userType" required><option value="donor">Donor</option><option value="requester">Requester</option><option value="admin">Admin</option></select></div>
            <button type="submit" class="btn-modal btn-save">Add User</button><button type="button" class="btn-modal btn-cancel" onclick="closeModal('addModal')">Cancel</button>
        </form>
    </div></div>
    
    <script>
        function viewUser(id){ fetch('${pageContext.request.contextPath}/admin/api/user?id='+id).then(r=>r.json()).then(u=>{ document.getElementById('viewUserDetails').innerHTML=`<div class="form-group"><label>Full Name:</label><p>${u.fullName}</p></div><div class="form-group"><label>Email:</label><p>${u.email}</p></div><div class="form-group"><label>Phone:</label><p>${u.phone}</p></div><div class="form-group"><label>City:</label><p>${u.city}</p></div><div class="form-group"><label>User Type:</label><p>${u.userType}</p></div>`; document.getElementById('viewModal').style.display='flex'; }); }
        function editUser(id){ fetch('${pageContext.request.contextPath}/admin/api/user?id='+id).then(r=>r.json()).then(u=>{ document.getElementById('editUserId').value=u.userId; document.getElementById('editFullName').value=u.fullName; document.getElementById('editEmail').value=u.email; document.getElementById('editPhone').value=u.phone; document.getElementById('editCity').value=u.city; document.getElementById('editUserType').value=u.userType; document.getElementById('editModal').style.display='flex'; }); }
        function deleteUser(id){ if(confirm('Delete this user?')) window.location.href='${pageContext.request.contextPath}/admin/users?action=delete&userId='+id; }
        function showAddModal(){ document.getElementById('addModal').style.display='flex'; }
        function closeModal(id){ document.getElementById(id).style.display='none'; }
        window.onclick = function(e) { if(e.target.classList.contains('modal')) e.target.style.display='none'; }
    </script>
</body>
</html>