package com.cashify.servlet_cashify_project.dto;

import java.time.LocalDate; // use LocalDate for joined date
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {

    private int id;
    private String name;
    private String email;
    private String password;
    private long phone;
    private LocalDate joinedDate; // store date properly
}
