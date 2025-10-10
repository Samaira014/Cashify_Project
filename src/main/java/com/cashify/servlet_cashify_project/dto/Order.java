package com.cashify.servlet_cashify_project.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class Order {
	
	private int id;
	private int userid;
	private int seller_id;
	private int product_id;
	private String address;
	private int quantity;
	private double total_price;
	private String payment_status;
	private String coupon_code;
	private String delivery_note;
	private Date delivery_date;
	private Timestamp created_at;
}
