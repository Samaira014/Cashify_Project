//package com.cashify.servlet_cashify_project.controller;
//
//import java.io.IOException;
//import com.cashify.servlet_cashify_project.dao.UserDao;
//import com.cashify.servlet_cashify_project.dto.User;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//@WebServlet("/verifyOtp")
//public class OtpVerifyServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        int enteredOtp = Integer.parseInt(req.getParameter("otp"));
//        HttpSession session = req.getSession();
//
//        Integer generatedOtp = (Integer) session.getAttribute("otp");
//        Long otpTime = (Long) session.getAttribute("otpTime");
//        User pendingUser = (User) session.getAttribute("pendingUser");
//        Integer otpAttempts = (Integer) session.getAttribute("otpAttempts");
//
//        if (otpAttempts == null) otpAttempts = 0;
//
//        if (otpAttempts >= 10) {
//            session.invalidate();
//            req.setAttribute("error", "Maximum OTP attempts reached! Please register again.");
//            req.getRequestDispatcher("registration.jsp").forward(req, resp);
//            return;
//        }
//
//        session.setAttribute("otpAttempts", otpAttempts + 1);
//
//        if (System.currentTimeMillis() - otpTime > 300000) {
//            session.invalidate();
//            req.setAttribute("error", "OTP expired! Please register again.");
//            req.getRequestDispatcher("registration.jsp").forward(req, resp);
//            return;
//        }
//
//        if (enteredOtp == generatedOtp) {
//            // Save user to DB
//            new UserDao().saveUserDao(pendingUser);
//            session.invalidate();
//
//            req.setAttribute("success", "Registration successful! Please login.");
//            req.getRequestDispatcher("login.jsp").forward(req, resp);
//        } else {
//            req.setAttribute("error", "Invalid OTP! Attempt " + (otpAttempts + 1) + " of 10.");
//            req.getRequestDispatcher("otp-verify.jsp").forward(req, resp);
//        }
//    }
//}
