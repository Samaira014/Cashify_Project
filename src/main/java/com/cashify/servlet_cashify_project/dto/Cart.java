package com.cashify.servlet_cashify_project.dto;

import lombok.Data;

@Data
public class Cart {
	private int id;
	private int productId;
	private int userId;
	private int quantity;
	private String status;
	
}
