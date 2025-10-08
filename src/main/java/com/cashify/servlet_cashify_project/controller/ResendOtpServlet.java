//package com.cashify.servlet_cashify_project.controller;
//
//import java.io.IOException;
//import java.util.Properties;
////import jakarta.mail.*;
////import jakarta.mail.internet.*;
////import java.net.Authenticator;
////import java.net.PasswordAuthentication;
////
////import com.mysql.cj.Session;
////import com.mysql.cj.protocol.Message;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//
//import com.cashify.servlet_cashify_project.dto.User;
//import com.mysql.cj.Session;
//import com.mysql.cj.protocol.Message;
//
//@WebServlet("/resendOtp")
//public class ResendOtpServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        HttpSession session = req.getSession();
//        User pendingUser = (User) session.getAttribute("pendingUser");
//        Integer otpAttempts = (Integer) session.getAttribute("otpAttempts");
//
//        if (pendingUser == null) {
//            req.setAttribute("error", "Session expired! Please register again.");
//            req.getRequestDispatcher("registration.jsp").forward(req, resp);
//            return;
//        }
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
//        // Increment attempt count
//        session.setAttribute("otpAttempts", otpAttempts + 1);
//
//        // Generate new OTP
//        int otp = (int) (Math.random() * 900000) + 100000;
//        session.setAttribute("otp", otp);
//        session.setAttribute("otpTime", System.currentTimeMillis());
//
//        // Send OTP via email
//        sendOtpEmail(req, pendingUser.getEmail(), otp);
//
//        req.setAttribute("success", "A new OTP has been sent. Attempt " + (otpAttempts + 1) + " of 10.");
//        req.getRequestDispatcher("otp-verify.jsp").forward(req, resp);
//    }
//
//    private void sendOtpEmail(HttpServletRequest req, String recipientEmail, int otp) {
//        String fromEmail = req.getServletContext().getInitParameter("emailFrom");
//        String appPassword = req.getServletContext().getInitParameter("emailPassword");
//
//        if (fromEmail == null || appPassword == null) {
//            System.out.println("Email credentials not set in web.xml!");
//            return;
//        }
//
//        Properties props = new Properties();
//        props.put("mail.smtp.host", "smtp.gmail.com");
//        props.put("mail.smtp.port", "587");
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.starttls.enable", "true");
////
////        Session mailSession = Session.getInstance(props, new Authenticator() {
////            protected PasswordAuthentication getPasswordAuthentication() {
////                return new PasswordAuthentication(fromEmail, appPassword);
////            }
////        });
////
////        try {
////            Message message = new MimeMessage(mailSession);
////            message.setFrom(new InternetAddress(fromEmail));
////            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
////            message.setSubject("Cashify OTP Verification - Resend");
////            message.setText("Your new OTP is: " + otp + "\nIt will expire in 5 minutes. Max 10 attempts allowed.");
////
////            Transport.send(message);
////            System.out.println("Resent OTP successfully to " + recipientEmail);
////        } catch (Exception e) {
////            e.printStackTrace();
////        }
//  }
//}
