package com.cashify.servlet_cashify_project.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Admin {
	
	private int id;
	private String name;
    private String email;
    private String password;
   
	

}
