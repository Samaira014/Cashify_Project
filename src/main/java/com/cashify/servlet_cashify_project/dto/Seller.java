package com.cashify.servlet_cashify_project.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Seller {
	
	private int id;
	private String name;
	private String email;
	private String password;
	private long phone;
	

}
