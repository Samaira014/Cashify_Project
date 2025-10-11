package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.SalesReport;

public class SalesDao {

    private Connection connection = CashifyConnection.getCashifyConnection();

    // Add a sale
    public boolean addSale(SalesReport sale) {
        boolean flag = false;
        try {
            String sql = "INSERT INTO sales (order_id, seller_id, product_id, quantity, price, total_price, status) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sale.getOrderId());
            ps.setInt(2, sale.getSellerId());
            ps.setInt(3, sale.getProductId());
            ps.setInt(4, sale.getQuantity());
            ps.setDouble(5, sale.getPrice());
            ps.setDouble(6, sale.getTotalPrice());
            ps.setString(7, sale.getStatus());

            int i = ps.executeUpdate();
            if (i > 0) flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    // Get all sales for a specific seller
    public List<SalesReport> getSalesBySellerId(int sellerId) {
        List<SalesReport> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM sales WHERE seller_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SalesReport sale = new SalesReport();
                sale.setId(rs.getInt("id"));
                sale.setOrderId(rs.getInt("order_id"));
                sale.setSellerId(rs.getInt("seller_id"));
                sale.setProductId(rs.getInt("product_id"));
                sale.setQuantity(rs.getInt("quantity"));
                sale.setPrice(rs.getDouble("price"));
                sale.setTotalPrice(rs.getDouble("total_price"));
                sale.setStatus(rs.getString("status"));
                sale.setSaleDate(rs.getTimestamp("sale_date").toLocalDateTime());
                list.add(sale);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        //dummy data
//        SalesReport sale = new SalesReport();
//        sale.setId(1);
//        sale.setOrderId(3);
//        sale.setSellerId(2);
//        sale.setProductId(3);
//        sale.setQuantity(6);
//        sale.setPrice(56.0);
//        sale.setTotalPrice(89.0);
//        sale.setStatus("dsa");
//        sale.setSaleDate(null);
//        list.add(sale);
        
        return list;
    }

    // Get all sales (for all sellers)
    public List<SalesReport> getAllSales() {
        List<SalesReport> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM sales";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SalesReport sale = new SalesReport();
                sale.setId(rs.getInt("id"));
                sale.setOrderId(rs.getInt("order_id"));
                sale.setSellerId(rs.getInt("seller_id"));
                sale.setProductId(rs.getInt("product_id"));
                sale.setQuantity(rs.getInt("quantity"));
                sale.setPrice(rs.getDouble("price"));
                sale.setTotalPrice(rs.getDouble("total_price"));
                sale.setStatus(rs.getString("status"));
                sale.setSaleDate(rs.getTimestamp("sale_date").toLocalDateTime());
                list.add(sale);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
