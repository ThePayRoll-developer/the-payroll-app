package com.shohab.CreateApi.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data // Generates getters, setters, toString, equals, and hashCode methods
@NoArgsConstructor // Generates a no-argument constructor
@AllArgsConstructor
@Entity
public class Advance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private Employee employee;
    private BigDecimal amount;
    private String reason;
    private String date;

    public Advance(Employee employee, BigDecimal amount) {
        this.employee = employee;
        this.amount = amount;
    }
}
