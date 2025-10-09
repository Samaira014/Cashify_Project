package com.cashify.servlet_cashify_project.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeliveryPerson {
	
	    private int id;
	    private String name;
	    private String email;
	    private long phone;
	    private String password;
	    private String status;
	    private Timestamp joined_date;

}
