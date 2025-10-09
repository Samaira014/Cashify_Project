package com.cashify.servlet_cashify_project.dto;

import lombok.Data;

@Data
public class SalesReport {
    private int productId;
    private String productName;
    private String brand;
    private int totalQuantity;
    private double totalRevenue;
}
