package com.bloodlinkk.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.bloodlinkk.config.DBConfig;

@WebServlet("/testdb")
public class TestDBServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<h1>Database Test</h1>");
        try {
            Connection conn = DBConfig.getConnection();
            out.println("<p style='color:green'>✓ Database connected successfully!</p>");
            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:red'>✗ Database connection failed: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
    }
}