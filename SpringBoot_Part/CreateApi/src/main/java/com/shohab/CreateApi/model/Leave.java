package com.shohab.CreateApi.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Value;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "`emp_leave`")
public class Leave {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne
    @JoinColumn(name = "employee_id")
    private Employee employee;
    private String contact;
    private String leaveDate;
    private String leaveReason;
    private boolean isGrant;

    public Leave(Employee employee) {
        this.employee = employee;
    }
}
