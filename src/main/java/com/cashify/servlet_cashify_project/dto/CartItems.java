package com.cashify.servlet_cashify_project.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data

public class CartItems {

	private int itemsid;
	private int cartid;
	private int productid;
	private int quantity;
	private double price;
	private LocalDateTime datetimes;
	
	
}