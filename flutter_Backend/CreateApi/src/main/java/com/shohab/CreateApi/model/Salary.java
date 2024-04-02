package com.shohab.CreateApi.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.sql.Date;

@Data // Generates getters, setters, toString, equals, and hashCode methods
@NoArgsConstructor // Generates a no-argument constructor
@Entity
@AllArgsConstructor
public class Salary {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private Employee employee;
    private BigDecimal empBonus;
    private BigDecimal empAdvance;
    private BigDecimal amount;
    private BigDecimal TotalAmount;
    private BigDecimal totalSalary;
    private String date;
    private String empworkingdays;
    private String empPresent;
    private String empLeaves;
    private String empabsent;
    private String empFines;
    private String workingDays;

    public Employee getEmployee() {
        return employee;
    }

    public Salary(Employee employee) {
        this.employee = employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }
}
