package com.cashify.servlet_cashify_project.dto;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {

	private int id;
	private int sellerId;
	private String productName;
	private String brand;
	private String category;
	private String model;
	private double price;
	private String color;
	private int ram;
	private String condition;
	private int quantity;
	private String description;
	private byte[] image;
	private double discountedPrice;// nullable
	private String rejection_msg;

	public Double getDiscountedPrice() {
		return discountedPrice;
	}

	public void setDiscountedPrice(Double discountedPrice) {
		this.discountedPrice = discountedPrice;
	}

	private double rating;
	private boolean verified;
	private Timestamp joinedDateTime;

}
