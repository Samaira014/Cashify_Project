package com.cashify.servlet_cashify_project.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.SalesReport;

public class SalesDao {

    private Connection connection = CashifyConnection.getCashifyConnection();

    // Get sales report for a seller
    public List<SalesReport> getSalesBySellerId(int sellerId) {
        List<SalesReport> list = new ArrayList<>();
        try {
            String sql = "SELECT p.id AS productId, p.productName, p.brand, "
                    + "SUM(o.correct_quantity_column) AS totalQuantity, "
                    + "SUM(o.correct_quantity_column * o.correct_price_column) AS totalRevenue "
                    + "FROM product p "
                    + "JOIN orders o ON p.id = o.product_id "
                    + "WHERE p.seller_id = ? "
                    + "GROUP BY p.id, p.productName, p.brand";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SalesReport report = new SalesReport();
                report.setProductId(rs.getInt("productId"));
                report.setProductName(rs.getString("productName"));
                report.setBrand(rs.getString("brand"));
                report.setTotalQuantity(rs.getInt("totalQuantity"));
                report.setTotalRevenue(rs.getDouble("totalRevenue"));
                list.add(report);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    public boolean deleteSellerById(int sellerId) {
        boolean flag = false;
        try {
            String sql = "DELETE FROM seller WHERE id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            int i = ps.executeUpdate();
            if (i > 0) flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }


}

