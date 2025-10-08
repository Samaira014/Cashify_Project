package com.cashify.servlet_cashify_project.dto;

import lombok.Data;

@Data
public class SellOldPhone {

	private int id;
	private String name;
	private String email;
	private long phone;
	private String brand;
	private String model;
	private String storage;
	private String conditions;
	private double expectedprice;
	private String comments;
	private byte[] image;
	private String status;
}
