<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found | BloodLink</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .error-container {
            text-align: center;
            padding: 4rem 2rem;
            max-width: 600px;
            margin: 0 auto;
        }
        .error-code {
            font-size: 6rem;
            font-weight: 800;
            color: var(--blood-red);
            margin: 1rem 0;
        }
        .error-message {
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-tint" style="font-size: 5rem; color: var(--blood-red);"></i>
        <div class="error-code">404</div>
        <div class="error-message">Oops! Page Not Found</div>
        <p>The page you're looking for doesn't exist or has been moved.</p>
        <div style="margin-top: 2rem;">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Go Back Home</a>
            <a href="${pageContext.request.contextPath}/requestBlood" class="btn btn-secondary">Request Blood</a>
        </div>
    </div>
</body>
</html>