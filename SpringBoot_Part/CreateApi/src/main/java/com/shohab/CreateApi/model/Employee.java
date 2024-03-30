package com.shohab.CreateApi.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data // Generates getters, setters, toString, equals, and hashCode methods
@NoArgsConstructor // Generates a no-argument constructor
@Entity
@AllArgsConstructor
public class Employee  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private Date joiningDate;
    @Column(unique = true)
    private String email;
    private String gender;
    private String contact;
    private String salary;
    @ManyToOne
    private Department department;

    public Employee(String name, Date joiningDate, String email, String gender, String contact, String salary, Department department) {
        this.name = name;
        this.joiningDate = joiningDate;
        this.email = email;
        this.gender = gender;
        this.contact = contact;
        this.salary = salary;
        this.department = department;
    }



    public Employee(String name) {
        this.name = name;
    }
}
