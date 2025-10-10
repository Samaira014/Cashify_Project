package com.cashify.servlet_cashify_project.dto;



import java.time.LocalDateTime;

import lombok.Data;

@Data
public class SalesReport {
	private int id;
	private int orderId;
	private int sellerId;
	private int productId;
	private int quantity;
	private double price;
	private double totalPrice;
	private String status;
	private LocalDateTime saleDate;
}